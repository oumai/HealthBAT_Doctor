//
//  BATMyAccountHeaderView.m
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/20.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import "BATMyAccountHeaderView.h"

@implementation BATMyAccountHeaderView

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

#pragma mark - pageLayout
- (void)pageLayout
{
    [self addSubview:self.bgImageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.totalAmountLabel];
    
    WEAK_SELF(self);
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.top.left.right.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(20);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.titleLabel.mas_top).offset(-21);
    }];
    
    [self.totalAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.bgImageView.mas_bottom).offset(-58);
    }];
}

#pragma mark - get & set
- (UIImageView *)bgImageView
{
    if (_bgImageView == nil) {
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.backgroundColor = [UIColor blueColor];
    }
    return _bgImageView;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = UIColorFromHEX(0xffffff, 1);
        _titleLabel.backgroundColor = [UIColor clearColor];
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}

- (UILabel *)totalAmountLabel
{
    if (_totalAmountLabel == nil) {
        _totalAmountLabel = [[UILabel alloc] init];
        _totalAmountLabel.font = [UIFont systemFontOfSize:30];
        _totalAmountLabel.textColor = UIColorFromHEX(0xffffff, 1);
        _totalAmountLabel.backgroundColor = [UIColor clearColor];
        [_totalAmountLabel sizeToFit];
    }
    return _totalAmountLabel;
}

@end
