//
//  BATAuthenticateFooterView.m
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/15.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import "BATAuthenticateFooterView.h"
#import "YYText.h"

@implementation BATAuthenticateFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
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
- (void)submitButtonAction:(UIButton *)button
{
    DDLogDebug(@"Test");
    if (self.submitAction) {
        self.submitAction();
    }
}

#pragma mark - pageLayout
- (void)pageLayout
{
    [self addSubview:self.titleLabel];
    [self addSubview:self.contentLabel];
    [self addSubview:self.submitButton];
    
    WEAK_SELF(self);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.top.equalTo(self.mas_top).offset(17);
        make.width.mas_equalTo(SCREEN_WIDTH - 20);
        make.height.mas_offset(14);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.width.mas_equalTo(SCREEN_WIDTH - 20);
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
    }];
    
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.top.equalTo(self.contentLabel.mas_bottom).offset(35);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, 45));
        make.centerX.equalTo(self.mas_centerX);
    }];
    
}

#pragma mark - get & set
- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = UIColorFromHEX(0x333333, 1);
        _titleLabel.text = @"认证说明：";
    }
    return _titleLabel;
}

- (UILabel *)contentLabel
{
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.numberOfLines = 0;
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"1、请确保证书姓名、照片、编号、执业范围等清晰可见； \n2、职业医生资格证书图片，请确保飘红部分信息总能完全展示；"];
        string.yy_font = [UIFont systemFontOfSize:14];
        string.yy_lineSpacing = 6;
        string.yy_color = UIColorFromHEX(0x666666, 1);
        _contentLabel.attributedText = string;
    }
    return _contentLabel;
}

- (UIButton *)submitButton
{
    if (_submitButton == nil) {
        _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitButton setTitle:@"提交" forState:UIControlStateNormal];
        [_submitButton setBackgroundImage:[Tools imageFromColor:UIColorFromHEX(0x45a0f0, 1)] forState:UIControlStateNormal];
        [_submitButton setTitleColor:UIColorFromHEX(0xffffff, 1) forState:UIControlStateNormal];
        [_submitButton addTarget:self action:@selector(submitButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        _submitButton.titleLabel.font = [UIFont systemFontOfSize:18];
        _submitButton.layer.cornerRadius = 6.0f;
        _submitButton.layer.masksToBounds = YES;
    }
    return _submitButton;
}

@end
