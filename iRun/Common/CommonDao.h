//
//  CommonDao.h
//  iRun
//
//  Created by izhangyb on 15-6-7.
//  Copyright (c) 2015年 izhangyb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

typedef enum {
    SORT_TYPE_ASCEND = 1,
    SORT_TYPE_DECEND = 0
} SORT_TYPE;

typedef enum {
    RESULT_OK = 1,
    RESULT_NG = 0
} RESULT_TYPE;

static NSString * const FUNC_MIX = @"max:";
static NSString * const FUNC_MIN = @"min:";
static NSString * const FUNC_SUM = @"sum:";
static NSString * const FUNC_COUNT = @"count:";

@interface CommonDao : NSObject {
    NSManagedObjectContext *context;
}

- (id)initWithContext:(NSManagedObjectContext *)paramContext;


- (NSManagedObject *)createEntity:(Class)entityClass;

//无条件检索
- (BOOL)getEntities:(NSArray **)entities withEntityClass:(Class)entityClass;
- (BOOL)getEntities:(NSArray **)entities withEntityClass:(Class)entityClass orderBy:(NSArray *)orderBys asc:(SORT_TYPE)asc;

//有条件检索
- (BOOL)getEntities:(NSArray **)entities  withEntityClass:(Class)entityClass byConditions:(NSDictionary *)conditions;
//有条件检索 with Predicate
- (BOOL)getEntities:(NSArray **)entities withEntityClass:(Class)entityClass byConditionWithPredicate:(NSPredicate *)conditionsWithPredicate;
//有条件检索且排序
- (BOOL)getEntities:(NSArray **)entities withEntityClass:(Class)entityClass byConditions:(NSDictionary *)conditions orderBy:(NSArray *)orderBys asc:(SORT_TYPE)asc;
//有条件检索且排序 with Predicate
- (BOOL)getEntities:(NSArray **)entities withEntityClass:(Class)entityClass byConditionWithPredicate:(NSPredicate *)conditionsWithPredicate orderBy:(NSArray *)orderBys asc:(SORT_TYPE)asc;

- (BOOL)getEntities:(NSArray **)entities withEntityClass:(Class)entityClass byConditionWithPredicate:(NSPredicate *)conditionsWithPredicate orderBy:(NSArray *)orderBys asc:(SORT_TYPE)asc fetchOffset:(NSUInteger)offset fetchLimit:(NSUInteger)limit;

//fetching Specific Values
- (BOOL)getSpecificValues:(NSArray **)dicArray withEntityClass:(Class)entityClass byExpressionDescription:(NSExpressionDescription *)expressionDescription;
- (BOOL)getSpecificValues:(NSArray **)dicArray withEntityClass:(Class)entityClass byExpressionDescription:(NSExpressionDescription *)expressionDescription byConditions:(NSDictionary *)conditions;
- (BOOL)getSpecificValues:(NSArray **)dicArray withEntityClass:(Class)entityClass byExpressionDescription:(NSExpressionDescription *)expressionDescription byConditionWithPredicate:(NSPredicate *)conditionsWithPredicate;

//全部删除
- (BOOL)removeAllEntity:(Class)entityClass;
//条件删除
- (BOOL)removeEntity:(Class)entityClass byConditions:(NSDictionary *)conditions;
- (BOOL)removeEntity:(Class)entityClass byConditionWithPredicate:(NSPredicate *)conditionWithPredicate;
//删除一条数据
- (void)removeEntity:(NSManagedObject **)entity;

//保存
- (BOOL)saveAction;
//回滚
- (void)rollbackAction;

- (void)mergeChanges:(NSNotification *)notification;

- (NSExpressionDescription *)createExpressionDescription:(NSString *)predefinedFunc column:(NSString *)column descriptionName:(NSString *)name;

@end