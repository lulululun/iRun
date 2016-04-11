//
//  MainSportViewController.m
//  iRun
//
//  Created by izhangyb on 16/3/31.
//  Copyright © 2016年 izhangyb. All rights reserved.
//

#import "MainSportViewController.h"
#import "MainMenuViewController.h"
#import "SportViewController.h"

@interface MainSportViewController () {
    SportType sportType;
}

@end

@implementation MainSportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.sportChooseScrollView setDelegate:self];
    [self.startSportButton.layer setCornerRadius:20.f];
    sportType = SportTypeRun;
    
    [self loadDataSource];
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    self.contentViewConstraint.constant = CGRectGetWidth([UIScreen mainScreen].bounds) * 3;
    self.climbViewLeading.constant = CGRectGetWidth([UIScreen mainScreen].bounds);
    self.bikeViewLeading.constant = CGRectGetWidth([UIScreen mainScreen].bounds) * 2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    NSLog(@"dealloc");
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.startSportButton setEnabled:NO];
    
    CGFloat pageWidth = scrollView.frame.size.width;
    float currentContentX= scrollView.contentOffset.x ;
    
    if (currentContentX <= pageWidth) {
        float climbAlpha = currentContentX/pageWidth*0.6;
        [self.climbBackgroundImageView setAlpha:climbAlpha];
        [self.runBackgroundImageView setAlpha:0.6-climbAlpha];
        [self.bikeBackgroundImageView setAlpha:0];
    } else {
        float bikeAlpha = (currentContentX/pageWidth-1)*0.6;
        [self.bikeBackgroundImageView setAlpha:bikeAlpha];
        [self.climbBackgroundImageView setAlpha:0.6-bikeAlpha];
        [self.runBackgroundImageView setAlpha:0];
    }
    
    int currentPage = floor((currentContentX - pageWidth / 2) / pageWidth) + 1;
    self.sportPageControl.currentPage = currentPage;
    switch (currentPage) {
        case 0:
            [self.startSportButton setTitle:@"开始跑步" forState:UIControlStateNormal];
            sportType = SportTypeRun;
            break;
        case 1:
            [self.startSportButton setTitle:@"开始爬山" forState:UIControlStateNormal];
            sportType = SportTypeClimb;
            break;
        default:
            [self.startSportButton setTitle:@"开始骑行" forState:UIControlStateNormal];
            sportType = SportTypeBike;
            break;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self.startSportButton setEnabled:YES];
}

#pragma mark - Action & Private method

// 点击菜单按钮事件
- (IBAction)menuAction:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MainMenuViewController *settingVC = [storyboard instantiateViewControllerWithIdentifier:@"mainMenuViewController"];
    [self presentViewController:settingVC animated:YES completion:nil];
}

// 点击开始运动按钮事件
- (IBAction)startSportAction:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SportViewController *sportVC = [storyboard instantiateViewControllerWithIdentifier:@"sportViewController"];
    [sportVC setSportType:sportType];
    [self presentViewController:sportVC animated:YES completion:nil];
}

// 加载首页运动数据
- (void)loadDataSource {
    NSMutableDictionary *runDic = [[NSMutableDictionary alloc] init];
    [runDic setValue:@"步" forKey:@"units"];
    [runDic setValue:@"100000" forKey:@"accumulation"];
    
    NSMutableDictionary *climbDic = [[NSMutableDictionary alloc] init];
    [climbDic setValue:@"米(海拔落差)" forKey:@"units"];
    [climbDic setValue:@"5678" forKey:@"accumulation"];
    
    NSMutableDictionary *bikeDic = [[NSMutableDictionary alloc] init];
    [bikeDic setValue:@"千米" forKey:@"units"];
    [bikeDic setValue:@"999" forKey:@"accumulation"];
    
    [self.runView loadViewData:runDic];
    [self.climbView loadViewData:climbDic];
    [self.bikeView loadViewData:bikeDic];
}

@end
