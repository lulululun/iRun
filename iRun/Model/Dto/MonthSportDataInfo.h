//
//  MonthSportDataInfo.h
//  iRun
//
//  Created by izhangyb on 16/6/2.
//  Copyright © 2016年 izhangyb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MonthSportDataInfo : NSObject

@property (nonatomic, assign) double runDistance;
@property (nonatomic, assign) NSString *runDistanceTip;

@property (nonatomic, assign) double climbAltitude;
@property (nonatomic, assign) NSString *climbAltitudeTip;

@property (nonatomic, assign) double bikeDistance;
@property (nonatomic, assign) NSString *bikeDistanceTip;

-(instancetype)init;

@end
