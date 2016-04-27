//
//  BeanUtils.m
//  iRun
//
//  Created by wangtao on 16/4/25.
//  Copyright © 2016年 izhangyb. All rights reserved.
//

#import "BeanUtils.h"

@implementation BeanUtils

+(void)copyProperties:(id)src dest:(id)dest {
    
    NSLog(@"classeSrc=%@ dst=%@", [src class], [dest class]);
    if(src == NULL || dest == NULL) {
        return;
    }
    
    Class clazz = [src class];
    u_int count;
    
    objc_property_t* properties = class_copyPropertyList(clazz, &count);
    NSMutableArray* propertyArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count ; i++)
    {
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(properties[i])];
        [propertyArray addObject:propertyName];
        
        //on verifie que la prop existe dans la classe dest
        objc_property_t prop = class_getProperty([dest class], [propertyName UTF8String]);
        if(prop != NULL) {
            id result = [src valueForKey:propertyName];
            [dest setValue:result forKey: propertyName];
        }
    }
    free(properties);
}


@end
