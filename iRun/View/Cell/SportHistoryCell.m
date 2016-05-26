//
//  SportHistoryCell.m
//  iRun
//
//  Created by izhangyb on 16/5/23.
//  Copyright © 2016年 izhangyb. All rights reserved.
//

#import "SportHistoryCell.h"
#import "SportDataDto.h"
#import "Define.h"

@implementation SportHistoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellData:(id)data {
    SportDataDto *dto = (SportDataDto *)data;
    
    [self.calorie setText:[NSString stringWithFormat:@"卡路里:%@千卡", dto.calorie]];
    
    NSString *distanceStr = [NSString stringWithFormat:@"距离:%@km", dto.distance];
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:distanceStr];
    [attributedStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:FONT_NAME size:12] range:NSMakeRange(distanceStr.length - 2, 2)];
//    [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(distanceStr.length - 2, 2)];
    [self.distance setAttributedText:attributedStr];
    
    NSString *calorieStr = [NSString stringWithFormat:@"卡路里:%@千卡", dto.calorie];
    NSMutableAttributedString *attributedStr1 = [[NSMutableAttributedString alloc] initWithString:calorieStr];
    [attributedStr1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:FONT_NAME size:10] range:NSMakeRange(calorieStr.length - 2, 2)];
    [self.calorie setAttributedText:attributedStr1];
    
    
    [self.endTime setText:@"2016-05-24"];
    
    switch (dto.sportType) {
        case SportTypeRun:
            [self.sportTypeLogo setImage:[UIImage imageNamed:@"icon_sport_type_run"]];
            break;
            
        case SportTypeClimb:
            [self.sportTypeLogo setImage:[UIImage imageNamed:@"icon_sport_type_climb"]];
            break;
            
        default:
            [self.sportTypeLogo setImage:[UIImage imageNamed:@"icon_sport_type_bike"]];
            break;
    }
    
}

@end
