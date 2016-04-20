//
//  SportTrendViewController.m
//  iRun
//
//  Created by izhangyb on 16/4/20.
//  Copyright © 2016年 izhangyb. All rights reserved.
//

#import "SportTrendViewController.h"
#import "Define.h"

@interface SportTrendViewController () {
    NSMutableArray *_data;
    LPLineChartView *distanceChartView;
    LPLineChartView *calorieChartView;
}

@end

@implementation SportTrendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:self.bgImage]];
    
    _data = [@[@{@"id": @"1", @"name":@"1", @"grade":@"10"},
               @{@"id": @"2", @"name":@"2", @"grade":@"40"},
               @{@"id": @"3", @"name":@"3", @"grade":@"0"},
               @{@"id": @"4", @"name":@"4", @"grade":@"76"},
               @{@"id": @"5", @"name":@"5", @"grade":@"79"},
               @{@"id": @"6", @"name":@"6", @"grade":@"90"},
               @{@"id": @"7", @"name":@"7", @"grade":@"86"},
               @{@"id": @"8", @"name":@"8", @"grade":@"71"},
               @{@"id": @"9", @"name":@"9", @"grade":@"0"},
               @{@"id": @"10", @"name":@"10", @"grade":@"10"},
               @{@"id": @"1", @"name":@"11", @"grade":@"10"},
               @{@"id": @"2", @"name":@"12", @"grade":@"40"},
               @{@"id": @"3", @"name":@"13", @"grade":@"0"},
               @{@"id": @"4", @"name":@"14", @"grade":@"76"},
               @{@"id": @"5", @"name":@"15", @"grade":@"79"},
               @{@"id": @"6", @"name":@"16", @"grade":@"90"},
               @{@"id": @"7", @"name":@"17", @"grade":@"86"},
               @{@"id": @"8", @"name":@"18", @"grade":@"71"},
               @{@"id": @"9", @"name":@"19", @"grade":@"0"},
               @{@"id": @"10", @"name":@"20", @"grade":@"10"},
               @{@"id": @"1", @"name":@"21", @"grade":@"10"},
               @{@"id": @"2", @"name":@"22", @"grade":@"40"},
               @{@"id": @"3", @"name":@"23", @"grade":@"0"},
               @{@"id": @"4", @"name":@"24", @"grade":@"76"},
               @{@"id": @"5", @"name":@"25", @"grade":@"79"},
               @{@"id": @"6", @"name":@"26", @"grade":@"90"},
               @{@"id": @"7", @"name":@"27", @"grade":@"86"},
               @{@"id": @"8", @"name":@"28", @"grade":@"71"},
               @{@"id": @"9", @"name":@"29", @"grade":@"0"},
               @{@"id": @"10", @"name":@"30", @"grade":@"10"}] mutableCopy];
    
    //    _data = [@[@{@"id": @"1", @"name":@"周日", @"grade":@"10"},
    //               @{@"id": @"2", @"name":@"周二", @"grade":@"40"},
    //               @{@"id": @"3", @"name":@"周三", @"grade":@"0"},
    //               @{@"id": @"4", @"name":@"周四", @"grade":@"76"},
    //               @{@"id": @"5", @"name":@"周五", @"grade":@"79"},
    //               @{@"id": @"6", @"name":@"周六", @"grade":@"90"},
    //               @{@"id": @"7", @"name":@"周一", @"grade":@"86"}] mutableCopy];
    
    
    distanceChartView = [[LPLineChartView alloc] initWithFrame:CGRectMake(0, 120, CURREN_SCREEN_WIDTH, (CURREN_SCREEN_HEIGHT-142)/2)];
    distanceChartView.backgroundColor = [UIColor clearColor];
    [distanceChartView setChartTitle:@"距离"];
    distanceChartView.data = _data;
    distanceChartView.yRange = NSMakeRange(0, 100);
    distanceChartView.ySpace = 20;
    distanceChartView.xRankKey = @"id";
    distanceChartView.yKey = @"grade";
    distanceChartView.xKey = @"name";
    distanceChartView.xMinCount = 4;
    distanceChartView.xMaxCount = 10;
    distanceChartView.layout = [[LPLineChartViewCustomLayout alloc] init];
    
    [self.view addSubview:distanceChartView];
    
    calorieChartView = [[LPLineChartView alloc] initWithFrame:CGRectMake(0, CURREN_SCREEN_HEIGHT/2+49, CURREN_SCREEN_WIDTH, (CURREN_SCREEN_HEIGHT-142)/2)];
    calorieChartView.backgroundColor = [UIColor clearColor];
    [calorieChartView setChartTitle:@"卡路里"];
    calorieChartView.data = _data;
    calorieChartView.yRange = NSMakeRange(0, 100);
    calorieChartView.ySpace = 20;
    calorieChartView.xRankKey = @"id";
    calorieChartView.yKey = @"grade";
    calorieChartView.xKey = @"name";
    calorieChartView.xMinCount = 4;
    calorieChartView.xMaxCount = 10;
    calorieChartView.layout = [[LPLineChartViewCustomLayout alloc] init];
    
    [self.view addSubview:calorieChartView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
