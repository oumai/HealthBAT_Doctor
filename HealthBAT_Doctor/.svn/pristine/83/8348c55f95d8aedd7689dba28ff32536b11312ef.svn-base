//
//  BATServiceItemCell.m
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/16.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import "BATServiceItemCell.h"

@implementation BATServiceItemCell

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
//    self.iconBtn.selected = !self.iconBtn.selected;
}

- (void)configData:(NSDictionary *)dic select:(BOOL)select
{
    UIImage *nomalImage = dic[@"nomal"];
    
    UIImage *selectImage = dic[@"select"];
    
    self.iconImageView.image = select ? selectImage : nomalImage;
    
    [self.iconImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(nomalImage.size);
    }];
    
//    [self.iconBtn setBackgroundImage:nomalImage forState:UIControlStateNormal];
//    [self.iconBtn setBackgroundImage:selectImage forState:UIControlStateSelected];
//    
//    [self.iconBtn mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(nomalImage.size);
//    }];
    
    
    self.titleLabel.text = dic[@"name"];
}

#pragma mark - pageLayout
- (void)pageLayout
{
//    [self addSubview:self.iconBtn];
    [self addSubview:self.iconImageView];
    [self addSubview:self.titleLabel];
    
    WEAK_SELF(self);
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.size.mas_offset(CGSizeMake(15, 20));
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.top.equalTo(self.contentView.mas_top).offset(15);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(self.iconImageView.mas_bottom).offset(15);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-20);
    }];
    
//    WEAK_SELF(self);
//    [self.iconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        STRONG_SELF(self);
//        make.size.mas_offset(CGSizeMake(15, 20));
//        make.left.equalTo(self.mas_left).offset(10);
//        make.top.equalTo(self.contentView.mas_top).offset(11.5);
//    }];
//    
//    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        STRONG_SELF(self);
//        make.left.equalTo(self.iconBtn.mas_right).offset(14);
//        make.right.equalTo(self.mas_right);
//        make.centerY.equalTo(self.iconBtn);
//    }];
}

#pragma mark - get & set

//- (UIButton *)iconBtn
//{
//    if (_iconBtn == nil) {
//        _iconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_iconBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _iconBtn;
//}

- (UIImageView *)iconImageView
{
    if (_iconImageView == nil) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.userInteractionEnabled = YES;
    }
    return _iconImageView;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = STRING_DARK_COLOR;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end
