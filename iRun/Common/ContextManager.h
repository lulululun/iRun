//
//  ContextManager.h
//  iRun
//
//  Created by izhangyb on 15-6-7.
//  Copyright (c) 2015年 izhangyb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface ContextManager : NSObject
{
    NSManagedObjectContext *__managedObjectContext;
    NSManagedObjectModel *__managedObjectModel;
    NSPersistentStoreCoordinator *__persistentStoreCoordinator;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (ContextManager *)instance;
- (NSManagedObjectContext *)createNewContext;
- (void)saveContext;

@end
