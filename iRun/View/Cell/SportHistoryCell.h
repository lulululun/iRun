//
//  SportHistoryCell.h
//  iRun
//
//  Created by izhangyb on 16/5/23.
//  Copyright © 2016年 izhangyb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SportHistoryCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *sportTypeLogo;
@property (strong, nonatomic) IBOutlet UILabel *distance;
@property (strong, nonatomic) IBOutlet UILabel *calorie;
@property (strong, nonatomic) IBOutlet UILabel *endTime;

- (void)setCellData:(id)data;

@end
