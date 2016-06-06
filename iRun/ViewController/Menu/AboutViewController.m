//
//  AboutViewController.m
//  iRun
//
//  Created by izhangyb on 16/6/6.
//  Copyright © 2016年 izhangyb. All rights reserved.
//

#import "AboutViewController.h"
#import "UIImage+TintColor.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:self.bgImage]];
    
    [self.textLabel setText:@"在操场上\n在空明的大山中\n在笔直的公路上\n\n在喧嚣\n在当下\n在四下无人\n\n在日出\n在夜晚\n在太阳底下\n\n此时此刻\n打开爱跑，遇见心流"];
    
    [self.tipLabel setText:@"Verson 1.0.1\nCreate by zhangyb."];
    
    [self.clostBtn setBackgroundImage:[[UIImage imageNamed:@"icon_main_setting_close"] imageWithTintColor:[UIColor colorWithRed:0.957 green:0.957 blue:0.957 alpha:1]] forState:UIControlStateNormal];
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

- (IBAction)closeActon:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
