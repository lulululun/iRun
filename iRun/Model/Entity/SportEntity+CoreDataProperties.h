//
//  SportEntity+CoreDataProperties.h
//  iRun
//
//  Created by izhangyb on 16/4/15.
//  Copyright © 2016年 izhangyb. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "SportEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface SportEntity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *sportType;
@property (nullable, nonatomic, retain) NSDate *startDate;
@property (nullable, nonatomic, retain) NSDate *endDate;
@property (nullable, nonatomic, retain) NSNumber *distance;
@property (nullable, nonatomic, retain) NSNumber *speed;
@property (nullable, nonatomic, retain) NSNumber *calorie;
@property (nullable, nonatomic, retain) NSNumber *timer;

@end

NS_ASSUME_NONNULL_END
