//
//  SportTrendViewController.m
//  iRun
//
//  Created by izhangyb on 16/4/20.
//  Copyright © 2016年 izhangyb. All rights reserved.
//

#import "SportTrendViewController.h"
#import "SportDataLogic.h"
#import "Define.h"

@interface SportTrendViewController () {
    NSArray *_data;
    LPLineChartView *distanceChartView;
    LPLineChartView *calorieChartView;
    
    NSMutableArray *weekData;
    NSMutableArray *monthData;
    
    NSInteger weekZeroXCount;
    NSInteger monthZeroXCount;
}

@end

@implementation SportTrendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:self.bgImage]];
    [self.segmentedControl addTarget:self action:@selector(segementedTouchAction:) forControlEvents:UIControlEventValueChanged];
    
    [self loadDataSource];
    
    distanceChartView = [[LPLineChartView alloc] initWithFrame:CGRectMake(0, 120, CURREN_SCREEN_WIDTH, (CURREN_SCREEN_HEIGHT-142)/2)];
    distanceChartView.backgroundColor = [UIColor clearColor];
    distanceChartView.data = weekData;
    [distanceChartView setZeroXCount:weekZeroXCount];
    [distanceChartView setChartTitle:@"距离"];
    distanceChartView.yRange = NSMakeRange(0, 20000);
    distanceChartView.ySpace = 4000;
    distanceChartView.xRankKey = @"id";
    distanceChartView.yKey = @"distance";
    distanceChartView.xKey = @"day";
    distanceChartView.xMinCount = 4;
    distanceChartView.xMaxCount = 10;
    distanceChartView.layout = [[LPLineChartViewCustomLayout alloc] init];
    
    [self.view addSubview:distanceChartView];
    
//    calorieChartView = [[LPLineChartView alloc] initWithFrame:CGRectMake(0, CURREN_SCREEN_HEIGHT/2+49, CURREN_SCREEN_WIDTH, (CURREN_SCREEN_HEIGHT-142)/2)];
//    calorieChartView.backgroundColor = [UIColor clearColor];
//    [calorieChartView setChartTitle:@"卡路里"];
//    calorieChartView.data = _data;
//    calorieChartView.yRange = NSMakeRange(0, 100);
//    calorieChartView.ySpace = 20;
//    calorieChartView.xRankKey = @"id";
//    calorieChartView.yKey = @"grade";
//    calorieChartView.xKey = @"name";
//    calorieChartView.xMinCount = 4;
//    calorieChartView.xMaxCount = 10;
//    calorieChartView.layout = [[LPLineChartViewCustomLayout alloc] init];
//    
//    [self.view addSubview:calorieChartView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)segementedTouchAction:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        distanceChartView.data = weekData;
    } else {
        distanceChartView.data = monthData;
    }
    
    [distanceChartView reloadViews];
}

#pragma mark - Load Datasource

- (void)loadDataSource {
    
    NSMutableArray *tempWeekData = [[NSMutableArray alloc] init];
    NSMutableArray *tempMonthData = [[NSMutableArray alloc] init];
    
    [SportDataLogic loadWeekData:&tempWeekData monthData:&tempMonthData];
    
    monthData = tempMonthData;
    weekData = tempWeekData;
    
    NSInteger tempWeekDataCount = weekData.count;
    weekZeroXCount = 7 - tempWeekDataCount;
    
    NSMutableDictionary *temp;
    
    for (int i=0; i<weekZeroXCount; i++) {
        temp = [[NSMutableDictionary alloc] init];
        
        [temp setValue:@"0" forKey:@"calorie"];
        [temp setValue:@"0" forKey:@"distance"];
        [temp setValue:[NSString stringWithFormat:@"%ld", tempWeekDataCount + i] forKey:@"day"];
        
        [weekData addObject:temp];
    }
}

@end
