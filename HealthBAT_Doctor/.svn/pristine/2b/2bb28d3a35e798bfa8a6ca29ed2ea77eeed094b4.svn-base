//
//  BATDoctorServiceInfoButton.m
//  HealthBAT_Doctor
//
//  Created by cjl on 2017/5/10.
//  Copyright © 2017年 KM. All rights reserved.
//

#import "BATDoctorServiceInfoButton.h"

@implementation BATDoctorServiceInfoButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self pageLayout];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - Action
- (void)buttonAction:(UIButton *)button
{
    if (self.doctorServiceInfoButtonBlock) {
        self.doctorServiceInfoButtonBlock();
    }
}

#pragma mark - pageLayout
- (void)pageLayout
{
    [self addSubview:self.titleLabel];
    [self addSubview:self.countLabel];
    [self addSubview:self.button];
    
    WEAK_SELF(self);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(14);
        make.width.equalTo(self.mas_width);
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(2);
        make.width.equalTo(self.mas_width);
        make.bottom.equalTo(self.mas_bottom).offset(-14);
    }];
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.edges.equalTo(self);
    }];
}

#pragma mark - get & set
- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = STRING_MID_COLOR;
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UILabel *)countLabel
{
    if (_countLabel == nil) {
        _countLabel = [[UILabel alloc] init];
        _countLabel.textColor = STRING_DARK_COLOR;
        _countLabel.font = [UIFont systemFontOfSize:24];
        _countLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _countLabel;
}

- (UIButton *)button
{
    if (_button == nil) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

@end
