//
//  SportResultViewController.m
//  iRun
//
//  Created by izhangyb on 16/4/18.
//  Copyright © 2016年 izhangyb. All rights reserved.
//

#import "SportResultViewController.h"
#import "SportDistanceCell.h"
#import "SportDetailItemCell.h"

@interface SportResultViewController () {
    NSMutableArray *dataSourceArr;
}

@end

@implementation SportResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationController.navigationBar setBackgroundImage:
    
    [self.sportResultTableView setDelegate:self];
    [self.sportResultTableView setDataSource:self];
    [self.sportResultTableView setTableFooterView:[[UIView alloc] init]];
    
    dataSourceArr = [[NSMutableArray alloc] init];
    
    int size = sizeof(SportDataStruct);
    SportDataStruct data1 = {@"icon_menu_setting", [NSString stringWithFormat:@"%@", self.data.timer], @"--", @"icon_menu_setting", @"--", @"--"};
    SportDataStruct data2 = {@"icon_menu_setting", @"--", @"--", @"icon_menu_setting", @"--", @"--"};
    SportDataStruct data3 = {@"icon_menu_setting", @"--", @"--", @"icon_menu_setting", @"--", @"--"};
    
    [dataSourceArr addObject:[NSData dataWithBytes:&data1 length:size]];
    [dataSourceArr addObject:[NSData dataWithBytes:&data2 length:size]];
    [dataSourceArr addObject:[NSData dataWithBytes:&data3 length:size]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 140.f;
    } else {
        return 60.f;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *distanceCellIndentifier = @"distanceCellIndentifier";
    static NSString *detailCellCellIndentifier = @"detailCellCellIndentifier";
    SportDistanceCell *distanceCell;
    SportDetailItemCell *detailCell;
    
    if (indexPath.row == 0) {
        distanceCell = [tableView dequeueReusableCellWithIdentifier:distanceCellIndentifier];
        
        if (!distanceCell) {
            distanceCell = (SportDistanceCell *)[[[NSBundle mainBundle] loadNibNamed:@"SportDistanceCell" owner:self options:nil] lastObject];
            [distanceCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        [distanceCell.distanceLabel setText:[NSString stringWithFormat:@"%@", self.data.distance]];
        [distanceCell.distanceUnitLabel setText:@"公里"];
        
        return distanceCell;
    } else {
        detailCell = [tableView dequeueReusableCellWithIdentifier:detailCellCellIndentifier];
        
        if (!detailCell) {
            detailCell = (SportDetailItemCell *)[[[NSBundle mainBundle] loadNibNamed:@"SportDetailItemCell" owner:self options:nil] lastObject];
            [detailCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        
        SportDataStruct dataSt;
        NSData *data = [dataSourceArr objectAtIndex:indexPath.row -1];
        [data getBytes:&dataSt length:sizeof(SportDataStruct)];
        
        [detailCell.leftImageView setImage:[UIImage imageNamed:dataSt.leftItemImage]];
        [detailCell.leftValueLabel setText:dataSt.leftItemValue];
        [detailCell.leftTipLabel setText:dataSt.leftItemTip];
        [detailCell.rightImageView setImage:[UIImage imageNamed:dataSt.rightItemImage]];
        [detailCell.rightValueLabel setText:dataSt.rightItemValue];
        [detailCell.rightTipLabel setText:dataSt.rightItemTip];
        
        return detailCell;
    }
}

#pragma mark - UITableViewDelegate

- (IBAction)backToSportAction:(id)sender {
    int index=(int)[[self.navigationController viewControllers] indexOfObject:self];
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:index-2]animated:YES];
}
@end
