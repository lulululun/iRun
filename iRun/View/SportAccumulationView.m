//
//  SportAccumulationView.m
//  iRun
//
//  Created by izhangyb on 16/4/5.
//  Copyright © 2016年 izhangyb. All rights reserved.
//

#import "SportAccumulationView.h"

//IB_DESIGNABLE
@implementation SportAccumulationView

- (instancetype)init {
    return [super init];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    return self;
}

- (void)awakeFromNib {
    self.view = [[[NSBundle mainBundle] loadNibNamed:@"SportAccumulationView" owner:self options:nil] lastObject];
    [self addSubview:self.view];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self addGestureRecognizer:tapRecognizer];
}

#pragma mark - Load data

- (void)loadViewData:(id)data {
    [self.accumulationLabel setText:[data valueForKey:@"accumulation"]];
    [self.accumulationUnits setText:[data valueForKey:@"units"]];
}

- (void)tapAction {
    [self.delegate accumulationViewTap:self];
}

@end
