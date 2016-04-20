//
//  SettingViewController.h
//  iRun
//
//  Created by izhangyb on 16/4/15.
//  Copyright © 2016年 izhangyb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

// 背景图（做毛玻璃效果用）
@property (strong, nonatomic) UIImage *bgImage;
@property (strong, nonatomic) IBOutlet UITableView *settingTableView;
@property (strong, nonatomic) IBOutlet UISwitch *switchButton;
- (IBAction)switchAction:(id)sender;

- (IBAction)backToMenuAction:(id)sender;
@end
