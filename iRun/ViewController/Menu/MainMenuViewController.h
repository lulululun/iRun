//
//  MainMenuViewController.h
//  iRun
//
//  Created by izhangyb on 16/4/8.
//  Copyright © 2016年 izhangyb. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef struct {
    __unsafe_unretained NSString *imageName;
    __unsafe_unretained NSString *itemName;
} MenuTableViewData;

@interface MainMenuViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

// 关闭按钮
@property (strong, nonatomic) IBOutlet UIBarButtonItem *closeButton;
// 菜单列表
@property (strong, nonatomic) IBOutlet UITableView *menuTableView;
// 背景图（做毛玻璃效果用）
@property (strong, nonatomic) UIImage *bgImage;

// 关闭按钮事件
- (IBAction)closeAction:(id)sender;

@end
