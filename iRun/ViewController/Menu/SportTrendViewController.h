//
//  SportTrendViewController.h
//  iRun
//
//  Created by izhangyb on 16/4/20.
//  Copyright © 2016年 izhangyb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LPLineChartView.h"
#import "LPLineChartViewCustomLayout.h"

@interface SportTrendViewController : UIViewController

// 背景图（做毛玻璃效果用）
@property (strong, nonatomic) UIImage *bgImage;

@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

- (IBAction)backAction:(id)sender;

@end
