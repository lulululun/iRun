//
//  SportResultViewController.h
//  iRun
//
//  Created by izhangyb on 16/4/18.
//  Copyright © 2016年 izhangyb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SportDataDto.h"
#import "Define.h"

typedef struct {
    __unsafe_unretained NSString *leftItemImage;
    __unsafe_unretained NSString *leftItemValue;
    __unsafe_unretained NSString *leftItemTip;
    __unsafe_unretained NSString *rightItemImage;
    __unsafe_unretained NSString *rightItemValue;
    __unsafe_unretained NSString *rightItemTip;
} SportDataStruct;

@interface SportResultViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

// 背景图（做毛玻璃效果用）
@property (strong, nonatomic) UIImage *bgImage;

@property (strong, nonatomic) SportDataDto *data;
@property (nonatomic) SportTypes sportType;

@property (nonatomic, assign) int preVCTag;

@property (strong, nonatomic) IBOutlet UITableView *sportResultTableView;

- (IBAction)backToSportAction:(id)sender;

@end
