//
//  SportHistoryViewController.m
//  iRun
//
//  Created by izhangyb on 16/4/20.
//  Copyright © 2016年 izhangyb. All rights reserved.
//

#import "SportHistoryViewController.h"
#import "SportTrendViewController.h"

@interface SportHistoryViewController ()

@end

@implementation SportHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:self.bgImage]];
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

- (IBAction)trendAction:(id)sender {
    [self performSegueWithIdentifier:@"toSportTrendSegue" sender:self];
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
