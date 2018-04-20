//
//  BATContractConfirmFooterView.m
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/20.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import "BATContractConfirmFooterView.h"

@implementation BATContractConfirmFooterView

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
- (void)confirmBtnAction:(UIButton *)button
{
    if (self.confirmContractBlock) {
        self.confirmContractBlock();
    }
}

- (void)cancelBtnAction:(UIButton *)button
{
    if (self.cancelContractBlock) {
        self.cancelContractBlock();
    }
}

#pragma mark - pageLayout
- (void)pageLayout
{
    [self addSubview:self.noticeLabel];
    [self addSubview:self.cancelBtn];
    [self addSubview:self.confirmBtn];
    
    WEAK_SELF(self);
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.centerX.equalTo(self.mas_centerX).offset(-75);
        make.top.equalTo(self.mas_top).offset(27.5);
        make.size.mas_offset(CGSizeMake(100, 50));
    }];
    
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.centerX.equalTo(self.mas_centerX).offset(75);
        make.top.equalTo(self.mas_top).offset(27.5);
        make.size.mas_offset(CGSizeMake(100, 50));
    }];
    
    [self.noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.centerX.equalTo(self.mas_centerX);
        make.width.mas_offset(SCREEN_WIDTH - 20);
        make.top.equalTo(self.confirmBtn.mas_bottom).offset(27.5);
    }];
    
    
}

#pragma mark - get & set
- (UILabel *)noticeLabel
{
    if (_noticeLabel == nil) {
        _noticeLabel = [[UILabel alloc] init];
        _noticeLabel.font = [UIFont systemFontOfSize:14];
        _noticeLabel.textColor = STRING_LIGHT_COLOR;
        _noticeLabel.backgroundColor = [UIColor clearColor];
        _noticeLabel.numberOfLines = 0;
        _noticeLabel.text = @"医生在收到申请24小时内未处理合同确认，默认设置取消合同";
    }
    return _noticeLabel;
}

- (UIButton *)cancelBtn
{
    if (_cancelBtn == nil) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setBackgroundImage:[Tools imageFromColor:STRING_LIGHT_COLOR] forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:UIColorFromHEX(0xffffff, 1) forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        _cancelBtn.layer.cornerRadius = 6.0f;
        _cancelBtn.layer.masksToBounds = YES;
        
        [_cancelBtn addTarget:self action:@selector(cancelBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIButton *)confirmBtn
{
    if (_confirmBtn == nil) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
        [_confirmBtn setBackgroundImage:[Tools imageFromColor:BLUE_COLOR] forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:UIColorFromHEX(0xffffff, 1) forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        _confirmBtn.layer.cornerRadius = 6.0f;
        _confirmBtn.layer.masksToBounds = YES;
        
        [_confirmBtn addTarget:self action:@selector(confirmBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}

@end
