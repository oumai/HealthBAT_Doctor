//
//  BATAuthenticateIndexView.m
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/15.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import "BATAuthenticateIndexView.h"

@implementation BATAuthenticateIndexView

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
- (void)startBtnAction:(UIButton *)button
{
    if (self.startBlock) {
        self.startBlock();
    }
}

#pragma mark - pageLayout
- (void)pageLayout
{
    [self addSubview:self.imageView];
    [self addSubview:self.contentLabel];
    [self addSubview:self.startBtn];
    
    WEAK_SELF(self);
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(80);
        make.size.mas_equalTo(CGSizeMake(180.5, 167.5));
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.left.equalTo(self.mas_left).offset(28);
        make.right.equalTo(self.mas_right).offset(-28);
        make.top.equalTo(self.imageView.mas_bottom).offset(45);
    }];
    
    float startBtnOffset = 110;
    if (iPhone4) {
        startBtnOffset = 20;
    } else if (iPhone5) {
        startBtnOffset = 50;
    }
    
    [self.startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.top.equalTo(self.contentLabel.mas_bottom).offset(startBtnOffset);
        make.centerX.equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(250, 45));
    }];
}

#pragma mark - get & set
- (UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img-ysgzs"]];
    }
    return _imageView;
}

- (YYLabel *)contentLabel
{
    if (_contentLabel == nil) {
        _contentLabel = [[YYLabel alloc] init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.preferredMaxLayoutWidth = SCREEN_WIDTH - 28 * 2;
        
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"注册签约康美医院网络医生，为全国用户提供专业化、个性化、一站式的医疗服务"];
        string.yy_font = [UIFont systemFontOfSize:15];
        string.yy_color = [UIColor blackColor];
        string.yy_lineSpacing = 15;
        
        _contentLabel.attributedText = string;
        [_contentLabel sizeToFit];
    }
    return _contentLabel;
}

- (UIButton *)startBtn
{
    if (_startBtn == nil) {
        _startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_startBtn setTitle:@"立即开通工作室" forState:UIControlStateNormal];
        [_startBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_startBtn setBackgroundImage:[Tools imageFromColor:UIColorFromHEX(0x45a0f0, 1)] forState:UIControlStateNormal];
        [_startBtn addTarget:self action:@selector(startBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        _startBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        _startBtn.layer.cornerRadius = 50 / 2;
        _startBtn.layer.masksToBounds = YES;
    }
    return _startBtn;
}

@end
