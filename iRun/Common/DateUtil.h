//
//  DateUtil.h
//  hbhealth
//
//  Created by Yunsung on 15/7/3.
//  Copyright (c) 2015年 NanjingYunsung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateUtil : NSObject

+ (NSDate *)getFormattedDateFromStr:(NSString *)dateStr;
+ (NSString *)getFormattedStrFromDate:(NSDate *)date;
+ (NSInteger)ageWithDateOfBirth:(NSDate *)date;

@end
