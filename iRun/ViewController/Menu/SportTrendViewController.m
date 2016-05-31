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
    [distanceChartView setChartTitle:@"距离 (km)"];
    distanceChartView.yRange = NSMakeRange(0, 20000);
    distanceChartView.ySpace = 4000;
    distanceChartView.xRankKey = @"id";
    distanceChartView.yKey = @"distance";
    distanceChartView.xKey = @"day";
    distanceChartView.xMinCount = 4;
    distanceChartView.xMaxCount = 10;
    distanceChartView.layout = [[LPLineChartViewCustomLayout alloc] init];
    
    [self.view addSubview:distanceChartView];
    
    calorieChartView = [[LPLineChartView alloc] initWithFrame:CGRectMake(0, CURREN_SCREEN_HEIGHT/2+49, CURREN_SCREEN_WIDTH, (CURREN_SCREEN_HEIGHT-142)/2)];
    calorieChartView.backgroundColor = [UIColor clearColor];
    [calorieChartView setChartTitle:@"卡路里 (千卡)"];
    calorieChartView.data = weekData;
    [calorieChartView setZeroXCount:weekZeroXCount];
    calorieChartView.yRange = NSMakeRange(0, 2000);
    calorieChartView.ySpace = 400;
    calorieChartView.xRankKey = @"id";
    calorieChartView.yKey = @"calorie";
    calorieChartView.xKey = @"day";
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

- (void)segementedTouchAction:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        [distanceChartView setZeroXCount:weekZeroXCount];
        distanceChartView.data = weekData;
        
        [calorieChartView setZeroXCount:weekZeroXCount];
        calorieChartView.data = weekData;
    } else {
        distanceChartView.data = monthData;
        [distanceChartView setZeroXCount:monthZeroXCount];
        
        [calorieChartView setZeroXCount:monthZeroXCount];
        calorieChartView.data = monthData;
    }
    
    [distanceChartView reloadViews];
    [calorieChartView reloadViews];
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
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar componentsInTimeZone:[NSTimeZone systemTimeZone] fromDate:[NSDate date]];
    
    NSMutableDictionary *temp;
    
    NSArray *monthArr = @[@"1", @"3", @"5", @"7", @"8", @"10", @"12"];
    
    if ([monthArr containsObject:[NSString stringWithFormat:@"%ld", dateComponents.month]]) {
        monthZeroXCount = 31 - monthData.count;
    } else {
        monthZeroXCount = 30 - monthData.count;
    }
    
    for (int i=0; i<monthZeroXCount; i++) {
        temp = [[NSMutableDictionary alloc] init];
        
        [temp setValue:@"0" forKey:@"calorie"];
        [temp setValue:@"0" forKey:@"distance"];
        [temp setValue:[NSString stringWithFormat:@"%ld", tempWeekDataCount + i] forKey:@"day"];
        
        [monthData addObject:temp];
    }
    
    for (int i=0; i<weekZeroXCount; i++) {
        temp = [[NSMutableDictionary alloc] init];
        
        [temp setValue:@"0" forKey:@"calorie"];
        [temp setValue:@"0" forKey:@"distance"];
        [temp setValue:[NSString stringWithFormat:@"%ld", tempWeekDataCount + i] forKey:@"day"];
        
        [weekData addObject:temp];
    }
}

@end
