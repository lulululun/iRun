//
//  Define.h
//  iRun
//
//  Created by izhangyb on 16/4/7.
//  Copyright © 2016年 izhangyb. All rights reserved.
//

#ifndef Define_h
#define Define_h

// 地图应用API KEY
#define MAMAP_API_KEY @"ccd7b7623f60a5e1a1bb7fd2012a847e"

// 当前屏幕的宽度
#define CURREN_SCREEN_WIDTH CGRectGetWidth([[UIScreen mainScreen] bounds])
// 当前屏幕的高度
#define CURREN_SCREEN_HEIGHT CGRectGetHeight([[UIScreen mainScreen] bounds])

#define iOS9 [[[UIDevice currentDevice]systemVersion] floatValue] >= 9.0

#define USERDEFAULT [NSUserDefaults standardUserDefaults]

#define TABLEVIEW_TEXT_COLOR [UIColor colorWithRed:0.965 green:0.965 blue:0.965 alpha:1]
#define TABLEVIEW_LINE_COLOR [UIColor colorWithRed:0.753 green:0.757 blue:0.776 alpha:1]

// 手环广播ID
#define BROAD_CAST_ID            @"broadCastid"

#define LS_DEVICE_INFO           @"lsdeviceinfo"

// 用户设置
#define USER_SETTING_AGE         @"usersettingage"
#define USER_SETTING_BIRTHDAY    @"usersettingbirthday"
#define USER_SETTING_SEX         @"usersettingsex"
#define USER_SETTING_HEIGHT      @"usersettingheight"
#define USER_SETTING_WEIGHT      @"usersettingwight"

typedef enum {
    SportTypeRun = 0,
    SportTypeClimb = 1,
    SportTypeBike = 2
} SportTypes;

#endif /* Define_h */
