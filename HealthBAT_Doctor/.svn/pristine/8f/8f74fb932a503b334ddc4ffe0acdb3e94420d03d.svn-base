//
//  BATAuthenticateResultView.m
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/16.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import "BATAuthenticateResultView.h"

@implementation BATAuthenticateResultView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
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
- (void)resetBtnAction:(UIButton *)button
{
    if (self.resetBlock) {
        self.resetBlock();
    }
}

#pragma mark - pageLayout
- (void)pageLayout
{
    [self addSubview:self.imageView];
    [self addSubview:self.resultLabel];
    [self addSubview:self.contentLabel];
    [self addSubview:self.resetBtn];
    
    WEAK_SELF(self);
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(60);
        make.size.mas_equalTo(CGSizeMake(183.5, 186.5));
    }];
    
    [self.resultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.left.equalTo(self.mas_left).offset(20);
        make.right.equalTo(self.mas_right).offset(-20);
        make.top.equalTo(self.imageView.mas_bottom).offset(50);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.top.equalTo(self.resultLabel.mas_bottom).offset(18);
    }];
    
    float resetBtnOffset = 75;
    if (iPhone4) {
        resetBtnOffset = 20;
    } else if (iPhone5) {
        resetBtnOffset = 50;
    }
    
    [self.resetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.top.equalTo(self.contentLabel.mas_bottom).offset(resetBtnOffset);
        make.centerX.equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(250, 45));
    }];
}

#pragma mark - get & set
- (UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img-shz"]];
    }
    return _imageView;
}

- (UILabel *)resultLabel
{
    if (_resultLabel == nil) {
        _resultLabel = [[UILabel alloc] init];
        _resultLabel.font = [UIFont systemFontOfSize:20];
        _resultLabel.textColor = UIColorFromHEX(0x333333, 1);
        _resultLabel.numberOfLines = 0;
        _resultLabel.text = @"提交成功，请等待管理员审核！";
        _resultLabel.textAlignment = NSTextAlignmentCenter;
        [_resultLabel sizeToFit];
    }
    return _resultLabel;
}

- (UILabel *)contentLabel
{
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:15];
        _contentLabel.textColor = UIColorFromHEX(0x999999, 1);
        _contentLabel.numberOfLines = 0;
        _contentLabel.text = @"预计3个工作日内审核完毕，审核结果会短信通知到您的注册手机上";
        [_contentLabel sizeToFit];
    }
    return _contentLabel;
}

- (UIButton *)resetBtn
{
    if (_resetBtn == nil) {
        _resetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_resetBtn setTitle:@"重新认证" forState:UIControlStateNormal];
        [_resetBtn setTitleColor:UIColorFromHEX(0xffffff, 1) forState:UIControlStateNormal];
        [_resetBtn setBackgroundImage:[Tools imageFromColor:UIColorFromHEX(0x45a0f0, 1)] forState:UIControlStateNormal];
        [_resetBtn addTarget:self action:@selector(resetBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        _resetBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        _resetBtn.layer.cornerRadius = 50 / 2;
        _resetBtn.layer.masksToBounds = YES;
    }
    return _resetBtn;
}


@end
