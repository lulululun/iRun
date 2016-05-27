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
    [entity setCalorie:[self getCalorieWithData:data]];
    
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

#pragma mark - Pirvate Method

+ (NSNumber *)getSpeedWithData:(SportDataDto *)data {
    NSNumber *speed = [NSNumber numberWithFloat:data.distance.floatValue / data.timer.floatValue];
    return speed;
}

+ (NSNumber *)getCalorieWithData:(SportDataDto *)data {
    float weight = [USERDEFAULT stringForKey:USER_SETTING_WEIGHT].floatValue;
    
    float sportCPI = 30/((data.timer.floatValue/60)/(data.distance.floatValue/400));
    float sportTime = data.timer.floatValue/3600;
    
    //跑步热量（kcal）＝体重（kg）×运动时间（小时）×指数K
    //指数K＝30÷速度（分钟/400米）
    float calorie = weight*sportTime*sportCPI;
    return [NSNumber numberWithFloat:calorie];
    
    //    switch (self.sportType) {
    //        case SportTypeRun: {
    //            //跑步热量（kcal）＝体重（kg）×运动时间（小时）×指数K
    //            //指数K＝30÷速度（分钟/400米）
    //            CGFloat calorie = weight*sportTime*sportCPI;
    //            return [NSNumber numberWithFloat:calorie];
    //        }
    //            break;
    //
    //        case SportTypeClimb:
    //
    //            break;
    //
    //        default:
    //            break;
    //    }
    //
    //    return nil;
}

@end
