//
//  BeanUtils.h
//  iRun
//
//  Created by wangtao on 16/4/25.
//  Copyright © 2016年 izhangyb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface BeanUtils : NSObject

+(void)copyProperties:(id)src dest:(id)dest;

@end
