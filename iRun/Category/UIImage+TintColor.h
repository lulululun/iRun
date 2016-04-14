//
//  UIImage+TintColor.h
//  hbhealth
//
//  Created by Yunsung on 15/8/27.
//  Copyright (c) 2015年 NanjingYunsung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (TintColor)

- (UIImage *) imageWithTintColor:(UIColor *)tintColor;

- (UIImage *) imageWithGradientTintColor:(UIColor *)tintColor;

- (UIImage *) imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode;

@end
