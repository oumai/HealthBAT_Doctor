//
//  BATDoctorStudioMenuItemCell.m
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/15.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import "BATDoctorStudioMenuItemCell.h"

@implementation BATDoctorStudioMenuItemCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self pageLayout];
    }
    return self;
}

#pragma mark - Action
- (void)configData:(NSDictionary *)dic
{
    
    UIImage *image = dic[@"image"];
    
    self.imageView.image = image;
    
//    [self.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(image.size);
//    }];
    
    
    self.titleLabel.text = dic[@"name"];
}

#pragma mark - pageLayout
- (void)pageLayout
{
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.titleLabel];
    
    CGFloat offset = 55;
    if (iPhone4 || iPad || iPadAir) {
        offset = 5;
    }
    
    
    WEAK_SELF(self);
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.top.equalTo(self.contentView.mas_top).offset(offset);
        make.size.mas_equalTo(CGSizeMake(65, 65));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.imageView.mas_bottom).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-offset);
    }];
}

#pragma mark - get & set
- (UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
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
