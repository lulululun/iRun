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

@interface SportHistoryViewController ()

@end

@implementation SportHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:self.bgImage]];
    
    [self.historyTableView setDelegate:self];
    [self.historyTableView setDataSource:self];
    [self.historyTableView setTableFooterView:[[UITableView alloc] init]];
    
    [self loadDataSource];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    SportTrendViewController *trendVC = segue.destinationViewController;
    [trendVC setBgImage:self.bgImage];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSourceArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifer = @"cell";
    SportHistoryCell *cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    
    if (!cell) {
        cell = (SportHistoryCell *)[[[NSBundle mainBundle] loadNibNamed:@"SportHistoryCell" owner:self options:nil] lastObject];
    }
    
    [cell setCellData:[self.dataSourceArr objectAtIndex:indexPath.row]];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
        [SportDataLogic loadSportHistory:&dataSource];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.dataSourceArr = dataSource;
            [self.historyTableView reloadData];
        });
    });

}

@end
