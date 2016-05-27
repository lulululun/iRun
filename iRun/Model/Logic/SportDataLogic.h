//
//  SportDataLogic.h
//  iRun
//
//  Created by izhangyb on 16/4/15.
//  Copyright © 2016年 izhangyb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SportDataDto.h"

@interface SportDataLogic : NSObject

+ (void)updateSportData:(SportDataDto *)data;

+ (void)loadSportHistory:(NSMutableArray **)historyArr withPageNo:(int)pageNo pageSize:(int)pageSize;

@end
