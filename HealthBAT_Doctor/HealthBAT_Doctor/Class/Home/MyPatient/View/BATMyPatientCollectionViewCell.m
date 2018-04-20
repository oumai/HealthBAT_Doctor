//
//  BATMyPatientCollectionViewCell.m
//  HealthBAT_Doctor
//
//  Created by cjl on 2017/6/20.
//  Copyright © 2017年 KM. All rights reserved.
//

#import "BATMyPatientCollectionViewCell.h"

@implementation BATMyPatientCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self pageLayout];
    }
    return self;
}


#pragma mark - pageLayout
- (void)pageLayout
{
    [self.contentView addSubview:self.avatarImageView];
    [self.contentView addSubview:self.familyStatusImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.sexLabel];
    [self.contentView addSubview:self.ageLabel];
    
    WEAK_SELF(self);
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.size.mas_offset(CGSizeMake(70, 70));
        make.top.equalTo(self.contentView.mas_top).offset(23.5);
        make.centerX.equalTo(self.contentView.mas_centerX);
    }];
    
    [self.familyStatusImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.size.mas_offset(CGSizeMake(56.5, 20));
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.centerY.equalTo(self.avatarImageView.mas_bottom).offset(-10);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.top.equalTo(self.familyStatusImageView.mas_bottom).offset(21);
    }];
    
    NSArray *temps = [NSArray arrayWithObjects:self.sexLabel,self.ageLabel, nil];
    [temps mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:20 leadSpacing:0 tailSpacing:0];
    [temps mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-23.5);
    }];
    
//    [self.sexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        STRONG_SELF(self);
//        make.left.equalTo(self.contentView.mas_left).offset(15);
//        make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
//        make.bottom.equalTo(self.contentView.mas_bottom).offset(-23.5);
//        make.width.mas_offset((SCREEN_WIDTH - 0.5) / 2);
//    }];
    
//    [self.ageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        STRONG_SELF(self);
//        make.left.equalTo(self.sexLabel.mas_right).offset(15);
//        make.top.equalTo(self.nameLabel.mas_bottom).offset(7);
//        make.right.equalTo(self.contentView.mas_right).offset(-15);
//    }];
    
}

#pragma mark - get & set
- (UIImageView *)avatarImageView
{
    if (_avatarImageView == nil) {
        _avatarImageView = [[UIImageView alloc] init];
        _avatarImageView.layer.cornerRadius = 70 / 2;
        _avatarImageView.layer.masksToBounds = YES;
    }
    return _avatarImageView;
}

- (UIImageView *)familyStatusImageView
{
    if (_familyStatusImageView == nil) {
        _familyStatusImageView = [[UIImageView alloc] init];
        _familyStatusImageView.hidden = YES;
    }
    return _familyStatusImageView;
}

- (UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:16];
        _nameLabel.textColor = STRING_DARK_COLOR;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLabel;
}

- (UILabel *)sexLabel
{
    if (_sexLabel == nil) {
        _sexLabel = [[UILabel alloc] init];
        _sexLabel.font = [UIFont systemFontOfSize:14];
        _sexLabel.textAlignment = NSTextAlignmentRight;
        _sexLabel.textColor = STRING_MID_COLOR;
    }
    return _sexLabel;
}

- (UILabel *)ageLabel
{
    if (_ageLabel == nil) {
        _ageLabel = [[UILabel alloc] init];
        _ageLabel.font = [UIFont systemFontOfSize:14];
        _ageLabel.textAlignment = NSTextAlignmentLeft;
        _ageLabel.textColor = STRING_MID_COLOR;
    }
    return _ageLabel;
}

- (void)setIsFamilyService:(BOOL)isFamilyService
{
    _isFamilyService = isFamilyService;
    
    self.familyStatusImageView.hidden = !_isFamilyService;
    
}

- (void)setIsExpire:(BOOL)isExpire
{
    _isExpire = isExpire;
    self.familyStatusImageView.image = _isExpire ? [UIImage imageNamed:@"img-jtfw"] : [UIImage imageNamed:@"img-jtfw-"];
}


@end
