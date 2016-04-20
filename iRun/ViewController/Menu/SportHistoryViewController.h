//
//  SportHistoryViewController.h
//  iRun
//
//  Created by izhangyb on 16/4/20.
//  Copyright © 2016年 izhangyb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SportHistoryViewController : UIViewController

// 背景图（做毛玻璃效果用）
@property (strong, nonatomic) UIImage *bgImage;

- (IBAction)trendAction:(id)sender;
- (IBAction)backAction:(id)sender;

@end
