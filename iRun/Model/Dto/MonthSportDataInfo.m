//
//  MonthSportDataInfo.m
//  iRun
//
//  Created by izhangyb on 16/6/2.
//  Copyright © 2016年 izhangyb. All rights reserved.
//

#import "MonthSportDataInfo.h"

@implementation MonthSportDataInfo

-(instancetype)init {
    self = [super init];
    
    if (self) {
        self.runDistance = 0.0f;
        self.runDistanceTip = @"距离(km)";
        
        self.climbAltitude = 0.0f;
        self.climbAltitudeTip = @"海拔(米)";
        
        self.bikeDistance = 0.0f;
        self.bikeDistanceTip = @"距离(km)";
    }
    
    return self;
}

@end
