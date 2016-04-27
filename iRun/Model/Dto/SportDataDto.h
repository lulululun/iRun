//
//  SportDataDto.h
//  iRun
//
//  Created by izhangyb on 16/4/15.
//  Copyright © 2016年 izhangyb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Define.h"

@interface SportDataDto : NSObject

// 运动类型
@property (nonatomic) SportTypes sportType;
// 运动开始时间
@property (nonatomic, retain) NSDate *startDate;
// 运动结束时间
@property (nonatomic, retain) NSDate *endDate;
// 运动距离
@property (nonatomic, retain) NSNumber *distance;
// 平均速度
@property (nonatomic, retain) NSNumber *speed;
// 消耗的卡路里
@property (nonatomic, retain) NSNumber *calorie;
// 运动时间
@property (nonatomic, retain) NSNumber *timer;
// 最大速度
@property (nonatomic, retain) NSNumber *maxSpeed;
// 海拔高度
@property (nonatomic, strong) NSNumber *altitude;

@end
