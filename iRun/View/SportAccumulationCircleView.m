//
//  SportAccumulationCircleView.m
//  iRun
//
//  Created by izhangyb on 16/4/6.
//  Copyright © 2016年 izhangyb. All rights reserved.
//

#import "SportAccumulationCircleView.h"

#define PI 3.14159265358979323846

@implementation SportAccumulationCircleView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    //一个不透明类型的Quartz 2D绘画环境,相当于一个画布,你可以在上面任意绘画
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    /*画圆*/
    //边框圆
    CGContextSetRGBStrokeColor(context,0.875,0.875,0.875,0.6);//画笔线的颜色
    CGContextSetLineWidth(context, 3.0);//线的宽度
    //void CGContextAddArc(CGContextRef c,CGFloat x, CGFloat y,CGFloat radius,CGFloat startAngle,CGFloat endAngle, int clockwise)1弧度＝180°/π （≈57.3°） 度＝弧度×180°/π 360°＝360×π/180 ＝2π 弧度
    // x,y为圆点坐标，radius半径，startAngle为开始的弧度，endAngle为 结束的弧度，clockwise 0为顺时针，1为逆时针。
    CGContextAddArc(context, self.bounds.size.height*0.5, self.bounds.size.height*0.5, self.bounds.size.height*0.5-1.5, 0, 2*PI, 0); //添加一个圆
    CGContextDrawPath(context, kCGPathStroke); //绘制路径
}

@end
