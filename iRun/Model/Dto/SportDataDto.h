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

@property (nonatomic) SportTypes sportType;
@property (nonatomic, retain) NSDate *startDate;
@property (nonatomic, retain) NSDate *endDate;
@property (nonatomic, retain) NSNumber *distance;
@property (nonatomic, retain) NSNumber *speed;
@property (nonatomic, retain) NSNumber *calorie;
@property (nonatomic, retain) NSNumber *timer;
@property (nonatomic, retain) NSNumber *maxSpeed;
@property (nonatomic, strong) NSNumber *altitude;

@end
