//
//  CommonDao.m
//  iRun
//
//  Created by izhangyb on 15-6-7.
//  Copyright (c) 2015年 izhangyb. All rights reserved.
//

#import "CommonDao.h"
#import "ContextManager.h"

@interface CommonDao(private)

- (NSString*)createCondition:(NSDictionary *)dics;

@end

@implementation CommonDao


- (id)initWithContext:(NSManagedObjectContext *)paramContext {
    
    self = [super init];
    
    context = paramContext;
    return self;
}


- (NSManagedObject *)createEntity:(Class)entityClass {
    
    NSManagedObject *entitty = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(entityClass) inManagedObjectContext:context];
    
    return entitty;
}

#pragma mark - get entities methods

//无条件检索
- (BOOL)getEntities:(NSArray **)entities withEntityClass:(Class)entityClass {
    return [self getEntities:entities withEntityClass:entityClass byConditions:nil orderBy:nil asc:SORT_TYPE_ASCEND];
}

- (BOOL)getEntities:(NSArray **)entities withEntityClass:(Class)entityClass orderBy:(NSArray *)orderBys asc:(SORT_TYPE)asc {
    return [self getEntities:entities withEntityClass:entityClass byConditions:nil orderBy:orderBys asc:asc];
}

//有条件检索
- (BOOL)getEntities:(NSArray **)entities withEntityClass:(Class)entityClass byConditions:(NSDictionary *)conditions {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:[self createCondition:conditions]];
    return [self getEntities:entities withEntityClass:entityClass byConditionWithPredicate:predicate orderBy:nil asc:SORT_TYPE_ASCEND fetchOffset:0 fetchLimit:0];
}

//有条件检索　with Predicate
- (BOOL)getEntities:(NSArray **)entities withEntityClass:(Class)entityClass byConditionWithPredicate:(NSPredicate *)conditionsWithPredicate {
    return [self getEntities:entities withEntityClass:entityClass byConditionWithPredicate:conditionsWithPredicate orderBy:nil asc:SORT_TYPE_ASCEND fetchOffset:0 fetchLimit:0];
}

//有条件检索且排序
- (BOOL)getEntities:(NSArray **)entities withEntityClass:(Class)entityClass byConditions:(NSDictionary *)conditions orderBy:(NSArray *)orderBys asc:(SORT_TYPE)asc{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:[self createCondition:conditions]];
    
    return [self getEntities:entities withEntityClass:entityClass byConditionWithPredicate:predicate orderBy:orderBys asc:asc fetchOffset:0 fetchLimit:0];
    
}

- (BOOL)getEntities:(NSArray **)entities withEntityClass:(Class)entityClass byConditionWithPredicate:(NSPredicate *)conditionsWithPredicate orderBy:(NSArray *)orderBys asc:(SORT_TYPE)asc {
    return [self getEntities:entities withEntityClass:entityClass byConditionWithPredicate:conditionsWithPredicate orderBy:orderBys asc:asc fetchOffset:0 fetchLimit:0];
}


//有条件检索且排序 with Predicate
- (BOOL)getEntities:(NSArray **)entities withEntityClass:(Class)entityClass byConditionWithPredicate:(NSPredicate *)conditionsWithPredicate orderBy:(NSArray *)orderBys asc:(SORT_TYPE)asc fetchOffset:(NSUInteger)offset fetchLimit:(NSUInteger)limit {
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    // 取得Entity
    NSEntityDescription *tempDescription = [NSEntityDescription entityForName:NSStringFromClass(entityClass) inManagedObjectContext:context];
    [request setEntity: tempDescription];
    
    if(conditionsWithPredicate){
        // 取得条件
        [request setPredicate:conditionsWithPredicate];
    }
    if (offset > 0) {
        [request setFetchOffset:offset];
    }
    if (limit > 0) {
        [request setFetchLimit:limit];
    }
    
    if ([orderBys count] > 0) {
        NSArray *sortDescriptors;
        NSMutableArray *sortKeys = [NSMutableArray arrayWithCapacity:[orderBys count]];
        for (int i = 0; i < [orderBys count]; i++) {
            NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:orderBys[i] ascending:asc];
            [sortKeys addObject:sortDescriptor];
        }
        sortDescriptors = (NSArray *)sortKeys;
        [request setSortDescriptors:sortDescriptors];
    }
    
    // 数据取得
    NSError *error;
    NSArray *arr = [context executeFetchRequest:request error:&error];
    
    if(error){
        NSLog(@"DB SELECT ERROR>>%@",error);
        return RESULT_NG;
    }
    *entities = arr;
    
    return RESULT_OK;
}

#pragma mark - get specific values methods

- (BOOL)getSpecificValues:(NSArray **)dicArray withEntityClass:(Class)entityClass byExpressionDescription:(NSExpressionDescription *)expressionDescription {
    return [self getSpecificValues:dicArray withEntityClass:entityClass byExpressionDescription:expressionDescription byConditionWithPredicate:nil];
}

- (BOOL)getSpecificValues:(NSArray **)dicArray withEntityClass:(Class)entityClass byExpressionDescription:(NSExpressionDescription *)expressionDescription byConditions:(NSDictionary *)conditions {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:[self createCondition:conditions]];
    return [self getSpecificValues:dicArray withEntityClass:entityClass byExpressionDescription:expressionDescription byConditionWithPredicate:predicate];
}

- (BOOL)getSpecificValues:(NSArray **)dicArray withEntityClass:(Class)entityClass byExpressionDescription:(NSExpressionDescription *)expressionDescription byConditionWithPredicate:(NSPredicate *)conditionsWithPredicate {
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *tempDescription = [NSEntityDescription entityForName:NSStringFromClass(entityClass) inManagedObjectContext:context];
    [request setEntity: tempDescription];
    
    if(conditionsWithPredicate){
        [request setPredicate:conditionsWithPredicate];
    }
    
    // Specify that the request should return dictionaries.
    [request setResultType:NSDictionaryResultType];
    
    // Set the request's properties to fetch just the property represented by the expressions.
    [request setPropertiesToFetch:[NSArray arrayWithObject:expressionDescription]];
    
    // Execute the fetch.
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    if(error){
        NSLog(@"DB SELECT ERROR>>%@",error);
        return RESULT_NG;
    }
    *dicArray = objects;
    
    return RESULT_OK;
}


#pragma mark - remove methods
- (BOOL)removeAllEntity:(Class)entityClass {
    return [self removeEntity:entityClass byConditions:nil];
}

- (BOOL)removeEntity:(Class)entityClass byConditions:(NSDictionary *)conditions {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:[self createCondition:conditions]];
    return [self removeEntity:entityClass byConditionWithPredicate:predicate];
}

- (BOOL)removeEntity:(Class)entityClass byConditionWithPredicate:(NSPredicate *)conditionWithPredicate {
    
    NSArray *retEntities;
    if([self getEntities:&retEntities withEntityClass:entityClass byConditionWithPredicate:conditionWithPredicate]) {
        
        for (NSManagedObject *entity in retEntities) {
            [context deleteObject:entity];
        }
    } else {
        return RESULT_NG;
    }
    return RESULT_OK;
}


- (void)removeEntity:(NSManagedObject **)entity {
    [context deleteObject:*entity];
}

#pragma mark - Common Methods

- (BOOL)saveAction {
    NSError *error;
    
    NSNotificationCenter *notify = [NSNotificationCenter defaultCenter];
    [notify addObserver:self
               selector:@selector(mergeChanges:)
                   name:NSManagedObjectContextDidSaveNotification
                 object:context];
    
    [context save:&error];
    
    
    if (error) {
        NSLog(@"DB COMMIT ERROR>>%@",error);
        return RESULT_NG;
    }
    return RESULT_OK;
    
}

- (void)rollbackAction {
    [context rollback];
    return;
}


- (void)mergeChanges:(NSNotification *)notification
{
    ContextManager *contextManger = [ContextManager instance];
    [[contextManger managedObjectContext] performSelectorOnMainThread:@selector(mergeChangesFromContextDidSaveNotification:) withObject:notification waitUntilDone:YES];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (NSExpressionDescription *)createExpressionDescription:(NSString *)predefinedFunc column:(NSString *)column descriptionName:(NSString *)name {
    NSExpression *keyPathExpression = [NSExpression expressionForKeyPath:column];
    NSExpression *expression = [NSExpression expressionForFunction:predefinedFunc arguments:[NSArray arrayWithObject:keyPathExpression]];
    
    NSExpressionDescription *expressionDescription = [[NSExpressionDescription alloc] init];
    [expressionDescription setName:name];
    [expressionDescription setExpression:expression];
    [expressionDescription setExpressionResultType:NSDecimalAttributeType];
    
    return expressionDescription;
}


#pragma mark -
#pragma mark Private Methods.

- (NSString *)createCondition:(NSDictionary *)dics {
    
    NSString* retStr;
    
    if (dics) {
        retStr = @"";
        for (NSString* key in dics) {
            NSString *value = [dics objectForKey:key];
            
            retStr = [NSString stringWithFormat:@"%@%@=%@ and ",retStr, key,value];
        }
        
        NSInteger length = [retStr length];
        retStr = [retStr substringToIndex:(length-4)];
        
    }
    return retStr;
}

@end