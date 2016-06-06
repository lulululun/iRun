//
//  ShareViewController.m
//  iRun
//
//  Created by izhangyb on 16/6/6.
//  Copyright © 2016年 izhangyb. All rights reserved.
//

#import "ShareViewController.h"
#import "UIImage+TintColor.h"

@interface ShareViewController ()

@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:self.bgImage]];
    
    [self.closeBtn setBackgroundImage:[[UIImage imageNamed:@"icon_main_setting_close"] imageWithTintColor:[UIColor colorWithRed:0.957 green:0.957 blue:0.957 alpha:1]] forState:UIControlStateNormal];
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

- (IBAction)closeAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
