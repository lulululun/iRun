//
//  SportViewController.h
//  iRun
//
//  Created by izhangyb on 16/4/7.
//  Copyright © 2016年 izhangyb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CountdownView.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "Define.h"

typedef enum {
    SportTypeRun,
    SportTypeClimb,
    SportTypeBike
} SportType;

@interface SportViewController : UIViewController<MAMapViewDelegate>

@property (nonatomic) SportType sportType;

// 倒计时视图
@property (strong, nonatomic) IBOutlet CountdownView *countdownView;
// 地图视图
@property (strong, nonatomic) IBOutlet MAMapView *mapView;
// 运动状态视图
@property (strong, nonatomic) IBOutlet UIView *sportStateView;

// 运动状态视图是否被隐藏（初始化为NO）
@property (nonatomic) BOOL sportStateViewHidden;

// 运动状态视图约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *sportStateViewHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *sportStateViewBottom;
// 地图视图约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *mapViewTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *mapViewHeight;

// 数据展示视图
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomViewHeight;
@property (strong, nonatomic) IBOutlet UIView *dataDisplayView;
@property (strong, nonatomic) IBOutlet UIView *controlView;

// 运动主参数
@property (strong, nonatomic) IBOutlet UILabel *sportMainArg;
// 运动主参数说明
@property (strong, nonatomic) IBOutlet UILabel *sportMainArgTip;
// 运动左边辅参数
@property (strong, nonatomic) IBOutlet UILabel *sportLeftAuxiliaryArg;
// 运动左边辅参数说明
@property (strong, nonatomic) IBOutlet UILabel *sportLeftAuxiliaryArgTip;
// 运动右边辅参数
@property (strong, nonatomic) IBOutlet UILabel *sportRightAuxiliaryArg;
// 运动右边辅参数说明
@property (strong, nonatomic) IBOutlet UILabel *sportRightAuxiliaryArgTip;

// 隐藏状态下运动参数
@property (strong, nonatomic) IBOutlet UILabel *bottomLeftArg;
@property (strong, nonatomic) IBOutlet UILabel *bottomRightArg;
@property (strong, nonatomic) IBOutlet UILabel *bottomLeftArgTip;

// 结束运动按钮
@property (strong, nonatomic) IBOutlet UIButton *stopButton;
// 拍照按钮
@property (strong, nonatomic) IBOutlet UIButton *cameraButton;
// 锁定／解锁按钮
@property (strong, nonatomic) IBOutlet UIButton *lockButton;
// 设置按钮
@property (strong, nonatomic) IBOutlet UIButton *setting;
@property (strong, nonatomic) IBOutlet UIView *circleView;
@property (strong, nonatomic) IBOutlet UIView *unlockView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *circleRadiu;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *unlockButtonBottom;
@property (strong, nonatomic) IBOutlet UILabel *doubleClickLabel;


// 结束运动
- (IBAction)sportStopAction:(id)sender;
- (IBAction)unlockAction:(id)sender;
- (IBAction)lockAction:(id)sender;
@end
