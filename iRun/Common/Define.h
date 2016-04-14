//
//  Define.h
//  iRun
//
//  Created by izhangyb on 16/4/7.
//  Copyright © 2016年 izhangyb. All rights reserved.
//

#ifndef Define_h
#define Define_h

// 应用API KEY
#define MAMAP_API_KEY @"ccd7b7623f60a5e1a1bb7fd2012a847e"

// 当前屏幕的宽度
#define CURREN_SCREEN_WIDTH CGRectGetWidth([[UIScreen mainScreen] bounds])
// 当前屏幕的高度
#define CURREN_SCREEN_HEIGHT CGRectGetHeight([[UIScreen mainScreen] bounds])

#define iOS9 [[[UIDevice currentDevice]systemVersion] floatValue] >= 9.0

#define USERDEFAULT [NSUserDefaults standardUserDefaults]

// 手环广播ID
#define BROAD_CAST_ID            @"broadCastid"

#define LS_DEVICE_INFO @"lsdeviceinfo"

#endif /* Define_h */
