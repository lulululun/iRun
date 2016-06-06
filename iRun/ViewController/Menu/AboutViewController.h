//
//  AboutViewController.h
//  iRun
//
//  Created by izhangyb on 16/6/6.
//  Copyright © 2016年 izhangyb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutViewController : UIViewController

@property (strong, nonatomic) UIImage *bgImage;
@property (strong, nonatomic) IBOutlet UILabel *tipLabel;

@property (strong, nonatomic) IBOutlet UILabel *textLabel;
@property (strong, nonatomic) IBOutlet UIButton *clostBtn;
- (IBAction)closeActon:(id)sender;

@end
