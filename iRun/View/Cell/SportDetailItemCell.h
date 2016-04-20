//
//  SportDetailItemCell.h
//  iRun
//
//  Created by izhangyb on 16/4/19.
//  Copyright © 2016年 izhangyb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SportDetailItemCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *leftImageView;
@property (strong, nonatomic) IBOutlet UILabel *leftValueLabel;
@property (strong, nonatomic) IBOutlet UILabel *leftTipLabel;
@property (strong, nonatomic) IBOutlet UIImageView *rightImageView;
@property (strong, nonatomic) IBOutlet UILabel *rightValueLabel;
@property (strong, nonatomic) IBOutlet UILabel *rightTipLabel;

@end
