//
//  BATDoctorInfoFooterView.m
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/17.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import "BATDoctorInfoFooterView.h"

@implementation BATDoctorInfoFooterView

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
- (void)confirmBtnAction:(UIButton *)button
{
    DDLogDebug(@"Test");
    
    if (self.doctorInfoFooterConfirmBlock) {
        self.doctorInfoFooterConfirmBlock();
    }
    
}

#pragma mark - pageLayout
- (void)pageLayout
{
    [self addSubview:self.confirmBtn];
    
    WEAK_SELF(self);
    
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.top.equalTo(self.mas_top).offset(35);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, 45));
        make.centerX.equalTo(self.mas_centerX);
    }];
    
}

#pragma mark - get & set

- (UIButton *)confirmBtn
{
    if (_confirmBtn == nil) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
        [_confirmBtn setBackgroundImage:[Tools imageFromColor:BLUE_COLOR] forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:UIColorFromHEX(0xffffff, 1) forState:UIControlStateNormal];
        [_confirmBtn addTarget:self action:@selector(confirmBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        _confirmBtn.layer.cornerRadius = 6.0f;
        _confirmBtn.layer.masksToBounds = YES;
    }
    return _confirmBtn;
}

@end
