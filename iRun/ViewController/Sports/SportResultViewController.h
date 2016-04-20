//
//  SportResultViewController.h
//  iRun
//
//  Created by izhangyb on 16/4/18.
//  Copyright © 2016年 izhangyb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SportDataDto.h"

typedef struct {
    __unsafe_unretained NSString *leftItemImage;
    __unsafe_unretained NSString *leftItemValue;
    __unsafe_unretained NSString *leftItemTip;
    __unsafe_unretained NSString *rightItemImage;
    __unsafe_unretained NSString *rightItemValue;
    __unsafe_unretained NSString *rightItemTip;
} SportDataStruct;

@interface SportResultViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) SportDataDto *data;

@property (strong, nonatomic) IBOutlet UITableView *sportResultTableView;

- (IBAction)backToSportAction:(id)sender;

@end
