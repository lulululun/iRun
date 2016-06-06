//
//  ShareViewController.h
//  iRun
//
//  Created by izhangyb on 16/6/6.
//  Copyright © 2016年 izhangyb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareViewController : UIViewController

// 背景图（做毛玻璃效果用）
@property (strong, nonatomic) UIImage *bgImage;
@property (strong, nonatomic) IBOutlet UIButton *closeBtn;
- (IBAction)closeAction:(id)sender;

@end
