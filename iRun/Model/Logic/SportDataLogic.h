//
//  SportDataLogic.h
//  iRun
//
//  Created by izhangyb on 16/4/15.
//  Copyright © 2016年 izhangyb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SportDataDto.h"
#import "MonthSportDataInfo.h"

@interface SportDataLogic : NSObject

// 更新运动记录
+ (void)updateSportData:(SportDataDto *)data;
// 更新手环记录
+ (void)updatePedemoterData:(SportDataDto *)data;

// 获取运动记录列表数据
+ (void)loadSportHistory:(NSMutableArray **)historyArr withPageNo:(int)pageNo pageSize:(int)pageSize;

// 获取本月以及本周的运动记录，用来绘制趋势图
+ (void)loadWeekData:(NSMutableArray **)weekDataArr monthData:(NSMutableArray **)monthDataArr;

+ (void)loadMonthData:(MonthSportDataInfo **)dataInfo;

@end
