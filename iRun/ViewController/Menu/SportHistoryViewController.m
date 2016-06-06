//
//  SportHistoryViewController.m
//  iRun
//
//  Created by izhangyb on 16/4/20.
//  Copyright © 2016年 izhangyb. All rights reserved.
//

#import "SportHistoryViewController.h"
#import "SportTrendViewController.h"
#import "SportHistoryCell.h"
#import "SportDataLogic.h"
#import "SportResultViewController.h"

@interface SportHistoryViewController () {
    SportDataDto *data;
    
    int pageNo;
    UIButton *moreButton;
    int pageSize;
}

@end

@implementation SportHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:self.bgImage]];
    
    [self.historyTableView setDelegate:self];
    [self.historyTableView setDataSource:self];
    [self.historyTableView setTableFooterView:[[UITableView alloc] init]];
    [self.historyTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
     
    pageNo = 0;
    pageSize = 10;
    [self loadDataSource];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    pageNo = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toSportTrendSegue"]) {
        SportTrendViewController *trendVC = segue.destinationViewController;
        [trendVC setBgImage:self.bgImage];
    } else {
        SportResultViewController *resultVC = segue.destinationViewController;
        [resultVC setData:data];
        [resultVC setPreVCTag:1];
        [resultVC setBgImage:self.bgImage];
    }
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSourceArr count] + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.dataSourceArr.count) {
        return 35.f;
    }
    return 60.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifer = @"cell";
    SportHistoryCell *cell;
    
    if (indexPath.row == self.dataSourceArr.count) {
        UITableViewCell *moreCell = [[UITableViewCell alloc] init];
        [moreCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        [moreButton setFrame:CGRectMake(0, 0, CURREN_SCREEN_WIDTH, 35.f)];
        [moreButton addTarget:self action:@selector(loadMoreData) forControlEvents:UIControlEventTouchUpInside];
        
        [moreCell setBackgroundColor:[UIColor clearColor]];
        [moreCell addSubview:moreButton];
        return moreCell;
    }
    
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    
    if (!cell) {
        cell = (SportHistoryCell *)[[[NSBundle mainBundle] loadNibNamed:@"SportHistoryCell" owner:self options:nil] lastObject];
    }
    
    [cell setCellData:[self.dataSourceArr objectAtIndex:indexPath.row]];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row != self.dataSourceArr.count) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self performSegueWithIdentifier:@"toSportDetailFromHistorySegue" sender:self];
        
        data = [self.dataSourceArr objectAtIndex:indexPath.row];
    }
}

#pragma mark - Action

- (IBAction)trendAction:(id)sender {
    [self performSegueWithIdentifier:@"toSportTrendSegue" sender:self];
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - private method

- (void)loadDataSource {
    
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray *dataSource = [[NSMutableArray alloc] init];
        [SportDataLogic loadSportHistory:&dataSource withPageNo:pageNo pageSize:pageSize];
        
        moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (dataSource.count < pageSize) {
                NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:@"没有更多数据了"];
                [attributedStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:FONT_NAME size:12] range:NSMakeRange(0, 7)];
                [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, 7)];
                [moreButton setAttributedTitle:attributedStr forState:UIControlStateNormal];
                [moreButton setEnabled:NO];
            } else {
                NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:@"点击加载更多"];
                [attributedStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:FONT_NAME size:12] range:NSMakeRange(0, 6)];
                [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, 6)];
                [moreButton setAttributedTitle:attributedStr forState:UIControlStateNormal];
            }
            
            self.dataSourceArr = dataSource;
            [self.historyTableView reloadData];
        });
    });

}

- (void)loadMoreData {
    
    pageNo++;
    
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray *dataSource = [[NSMutableArray alloc] init];
        [SportDataLogic loadSportHistory:&dataSource withPageNo:pageNo pageSize:pageSize];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (dataSource.count < pageSize) {
                NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:@"没有更多数据了"];
                [attributedStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:FONT_NAME size:12] range:NSMakeRange(0, 7)];
                [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, 7)];
                [moreButton setAttributedTitle:attributedStr forState:UIControlStateNormal];
                [moreButton setEnabled:NO];
            }
            
            [self.dataSourceArr addObjectsFromArray:dataSource];;
            [self.historyTableView reloadData];
        });
    });
}

@end
