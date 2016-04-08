//
//  MainSportViewController.m
//  iRun
//
//  Created by izhangyb on 16/3/31.
//  Copyright © 2016年 izhangyb. All rights reserved.
//

#import "MainSportViewController.h"
#import "MainMenuViewController.h"

@interface MainSportViewController () {
    float willEndContentOffsetX;
    float startContentOffsetX;
    float endContentOffsetX;
    BOOL scrollToRight;
}

@end

@implementation MainSportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.sportChooseScrollView setDelegate:self];
    [self.startSportButton.layer setCornerRadius:20.f];
    
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
            break;
        case 1:
            [self.startSportButton setTitle:@"开始爬山" forState:UIControlStateNormal];
            break;
        default:
            [self.startSportButton setTitle:@"开始骑行" forState:UIControlStateNormal];
            break;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self.startSportButton setEnabled:YES];
}

#pragma mark - Action & Private method

- (IBAction)menuAction:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MainMenuViewController *settingVC = [storyboard instantiateViewControllerWithIdentifier:@"mainMenuViewController"];
    [self presentViewController:settingVC animated:YES completion:nil];
}

- (IBAction)startSportAction:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *sportVC = [storyboard instantiateViewControllerWithIdentifier:@"@sportViewController"];
    [self presentViewController:sportVC animated:YES completion:nil];
}

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
