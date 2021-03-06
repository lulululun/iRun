//
//  SportDataLogic.m
//  iRun
//
//  Created by izhangyb on 16/4/15.
//  Copyright © 2016年 izhangyb. All rights reserved.
//

#import "SportDataLogic.h"
#import "CommonDao.h"
#import "ContextManager.h"
#import "SportEntity+CoreDataProperties.h"
#import "BeanUtils.h"
#import "Define.h"

@implementation SportDataLogic

+ (void)updateSportData:(SportDataDto *)data {
    
    CommonDao *commonDao = [[CommonDao alloc] initWithContext:[[ContextManager instance] createNewContext]];
    SportEntity *entity = (SportEntity *)[commonDao createEntity:[SportEntity class]];
    
    [BeanUtils copyProperties:data dest:entity];
    [entity setSpeed:[self getSpeedWithData:data]];
    
    
    BOOL saveResult = [commonDao saveAction];
    
    if (saveResult) {
        NSLog(@"Upadte sport data successfully.");
    }
}

+ (void)updatePedemoterData:(SportDataDto *)data {
    NSArray *resultArr = [NSArray array];
    CommonDao *commonDao = [[CommonDao alloc] initWithContext:[[ContextManager instance] createNewContext]];
    
    NSDate *currentDate = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [formatter stringFromDate:currentDate];
    
    NSDate *firstMonthDay = [formatter dateFromString:dateStr];
    NSInteger interval = [[NSTimeZone systemTimeZone] secondsFromGMTForDate:currentDate];
    firstMonthDay = [firstMonthDay dateByAddingTimeInterval:interval];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"endDate >= %@ and sportType = %d", firstMonthDay, SportTypePedometer];
    [commonDao getEntities:&resultArr withEntityClass:[SportEntity class] byConditionWithPredicate:predicate];
    
    if (resultArr.count > 0) {
        [BeanUtils copyProperties:data dest:resultArr[0]];
    } else {
        SportEntity *entity = (SportEntity *)[commonDao createEntity:[SportEntity class]];
        
        [BeanUtils copyProperties:data dest:entity];
    }
    
    BOOL saveResult = [commonDao saveAction];
    
    if (saveResult) {
        NSLog(@"Upadte sport data successfully.");
    }
}

+ (void)loadSportHistory:(NSMutableArray **)historyArr withPageNo:(int)pageNo pageSize:(int)pageSize {
    NSArray *resultArr = [NSArray array];
    
    
    
    CommonDao *commonDao = [[CommonDao alloc] initWithContext:[[ContextManager instance] createNewContext]];
    [commonDao getEntities:&resultArr withEntityClass:[SportEntity class] byConditionWithPredicate:nil orderBy:[NSArray arrayWithObject:@"endDate"] asc:0 fetchOffset:pageNo * pageSize fetchLimit:pageSize];
    
    SportDataDto *data;
    for (SportEntity *entity in resultArr) {
        data = [[SportDataDto alloc] init];
        [BeanUtils copyProperties:entity dest:data];
        
        [*historyArr addObject:data];
    }
}

+ (void)loadWeekData:(NSMutableArray **)weekDataArr monthData:(NSMutableArray **)monthDataArr {
    
    NSArray *resultArr = [NSArray array];
    
    CommonDao *commonDao = [[CommonDao alloc] initWithContext:[[ContextManager instance] createNewContext]];
    
    // 获取当前月份的第一天
    NSDate *currentDate = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM"];
    NSString *dateStr = [formatter stringFromDate:currentDate];
    
    NSDate *firstMonthDay = [formatter dateFromString:dateStr];
    NSInteger interval = [[NSTimeZone systemTimeZone] secondsFromGMTForDate:currentDate];
    firstMonthDay = [firstMonthDay dateByAddingTimeInterval:interval];
    
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"endDate >= %@", firstMonthDay];
    
    [commonDao getEntities:&resultArr withEntityClass:[SportEntity class] byConditionWithPredicate:predicate];
    
    *weekDataArr = [self getWeekData:resultArr];
    *monthDataArr = [self getMonthData:resultArr];
}

+ (void)loadMonthData:(MonthSportDataInfo **)dataInfo {
    NSArray *resultArr = [NSArray array];
    
    CommonDao *commonDao = [[CommonDao alloc] initWithContext:[[ContextManager instance] createNewContext]];
    
    // 获取当前月份的第一天
    NSDate *currentDate = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM"];
    NSString *dateStr = [formatter stringFromDate:currentDate];
    
    NSDate *firstMonthDay = [formatter dateFromString:dateStr];
    NSInteger interval = [[NSTimeZone systemTimeZone] secondsFromGMTForDate:currentDate];
    firstMonthDay = [firstMonthDay dateByAddingTimeInterval:interval];
    
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"endDate >= %@", firstMonthDay];
    
    [commonDao getEntities:&resultArr withEntityClass:[SportEntity class] byConditionWithPredicate:predicate];
    
    MonthSportDataInfo *tempDataInfo = [[MonthSportDataInfo alloc] init];
    
    for (int i=0; i<resultArr.count; i++) {
        SportEntity *entity = [resultArr objectAtIndex:i];
        if (entity.sportType.integerValue ==0 || entity.sportType.integerValue == 3) {
            tempDataInfo.runDistance += entity.distance.floatValue;
        } else if (entity.sportType.integerValue == 1) {
            tempDataInfo.climbAltitude += entity.distance.floatValue;
        } else {
            tempDataInfo.bikeDistance += entity.distance.floatValue;
        }
    }
    
    *dataInfo = tempDataInfo;
}

#pragma mark - Pirvate Method

+ (NSNumber *)getSpeedWithData:(SportDataDto *)data {
    NSNumber *speed = [NSNumber numberWithFloat:data.distance.floatValue / data.timer.floatValue];
    return speed;
}

+ (NSMutableArray *)getWeekData:(NSArray *)dataArr {
    NSMutableArray *dataArrResult = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *temp;
    
    NSDate *tempDate = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar componentsInTimeZone:[NSTimeZone systemTimeZone] fromDate:tempDate];
    
    tempDate = [tempDate dateByAddingTimeInterval:-24*60*60];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    NSString *dateStr = [formatter stringFromDate:tempDate];
    
    NSDate *firstWeekDayDate = [[formatter dateFromString:dateStr] dateByAddingTimeInterval:[[NSTimeZone systemTimeZone] secondsFromGMTForDate:tempDate]];
    
    NSMutableArray *tempArr = [[NSMutableArray alloc] init];
    for (int i=0; i<dataArr.count; i++) {
        if ([firstWeekDayDate earlierDate:((SportEntity *)dataArr[i]).endDate] == firstWeekDayDate) {
            [tempArr addObject:dataArr[i]];
        }
    }
    
    for (int i=1; i<=dateComponents.weekday; i++) {
        temp = [[NSMutableDictionary alloc] init];
        
        float calorie = 0.0;
        float distance = 0.0;
        
        for (int j=0; j<tempArr.count; j++) {
            if ([calendar componentsInTimeZone:[NSTimeZone systemTimeZone] fromDate:((SportEntity *)tempArr[j]).endDate].weekday == i) {
                calorie += ((SportEntity *)tempArr[j]).calorie.floatValue;
                distance += ((SportEntity *)tempArr[j]).distance.floatValue;
            }
        }
        
        [temp setValue:[NSString stringWithFormat:@"%f", calorie] forKey:@"calorie"];
        [temp setValue:[NSString stringWithFormat:@"%f", distance] forKey:@"distance"];
        
        if (i ==1) {
            [temp setValue:@"星期日" forKey:@"day"];
        } else {
            [temp setValue:[NSString stringWithFormat:@"%d", i-1] forKey:@"day"];
        }
        
        [dataArrResult addObject:temp];
    }
    
    
    return dataArrResult;
}

+ (NSMutableArray *)getMonthData:(NSArray *)dataArr {
    NSMutableArray *dataArrResult = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *temp;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar componentsInTimeZone:[NSTimeZone systemTimeZone] fromDate:[NSDate date]];
    
    for (int i=1; i<=dateComponents.day; i++) {
        temp = [[NSMutableDictionary alloc] init];
        
        float calorie = 0.0;
        float distance = 0.0;
        
        for (int j=0; j<dataArr.count; j++) {
            
            if ([calendar componentsInTimeZone:[NSTimeZone systemTimeZone] fromDate:((SportEntity *)dataArr[j]).endDate].day == i) {
                calorie += ((SportEntity *)dataArr[j]).calorie.floatValue;
                distance += ((SportEntity *)dataArr[j]).distance.floatValue;
            }
        }
        
        [temp setValue:[NSString stringWithFormat:@"%f", calorie] forKey:@"calorie"];
        [temp setValue:[NSString stringWithFormat:@"%f", distance] forKey:@"distance"];
        [temp setValue:[NSString stringWithFormat:@"%d", i] forKey:@"id"];
        
        if (i ==1) {
            [temp setValue:[NSString stringWithFormat:@"%ld.1", dateComponents.month] forKey:@"day"];
        } else {
            [temp setValue:[NSString stringWithFormat:@"%d", i] forKey:@"day"];
        }
        
        [dataArrResult addObject:temp];
    }
    
    
    return dataArrResult;
}

@end
