//
//  MainSportViewController.h
//  iRun
//
//  Created by izhangyb on 16/3/31.
//  Copyright © 2016年 izhangyb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SportAccumulationView.h"

@interface MainSportViewController : UIViewController<UIScrollViewDelegate>

// 跑步背景图
@property (strong, nonatomic) IBOutlet UIImageView *runBackgroundImageView;
// 爬山背景图
@property (strong, nonatomic) IBOutlet UIImageView *climbBackgroundImageView;
// 骑行背景图
@property (strong, nonatomic) IBOutlet UIImageView *bikeBackgroundImageView;

// 更多按钮
@property (strong, nonatomic) IBOutlet UIButton *menuButton;
// 开始运动按钮
@property (strong, nonatomic) IBOutlet UIButton *startSportButton;
// 运动选择滑动内容视图宽度约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *contentViewConstraint;
// 爬山视图头部约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *climbViewLeading;
// 骑行视图头部约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bikeViewLeading;
// 运动选择滑动视图
@property (strong, nonatomic) IBOutlet UIScrollView *sportChooseScrollView;
@property (strong, nonatomic) IBOutlet UIPageControl *sportPageControl;

// 跑步数据累计视图
@property (strong, nonatomic) IBOutlet SportAccumulationView *runView;
// 爬山数据累计视图
@property (strong, nonatomic) IBOutlet SportAccumulationView *climbView;
// 骑行数据累计视图
@property (strong, nonatomic) IBOutlet SportAccumulationView *bikeView;

@property (strong, nonatomic) NSString *sportIdentifierStr;

// 菜单按钮点击事件
- (IBAction)menuAction:(id)sender;
// 开始运动按钮点击事件
- (IBAction)startSportAction:(id)sender;
@end
