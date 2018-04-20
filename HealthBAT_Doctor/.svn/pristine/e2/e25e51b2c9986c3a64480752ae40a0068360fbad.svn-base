//
//  BATReservationManageNoticeView.m
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/17.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import "BATReservationManageNoticeView.h"

@implementation BATReservationManageNoticeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _leftLabel = [[UILabel alloc] init];
        _leftLabel.layer.borderColor = BLUE_COLOR.CGColor;
        _leftLabel.layer.borderWidth = 0.5f;
        [self addSubview:_leftLabel];
        
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.backgroundColor = [UIColor whiteColor];
        _rightLabel.font = [UIFont systemFontOfSize:14];
        _rightLabel.textColor = STRING_MID_COLOR;
        [self addSubview:_rightLabel];
        
        [self setupConstraints];
    }
    return self;
}

- (void)setupConstraints
{
    WEAK_SELF(self);
    [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.left.equalTo(self.mas_left);
        make.size.mas_equalTo(CGSizeMake(16, 16));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.left.equalTo(_leftLabel.mas_right).offset(5);
        make.top.equalTo(_leftLabel.mas_top);
        make.bottom.equalTo(_leftLabel.mas_bottom);
        make.right.equalTo(self.mas_right);
    }];
}

@end
