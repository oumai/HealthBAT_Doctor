//
//  BATMyPatientTableViewCell.m
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/21.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import "BATMyPatientTableViewCell.h"

@implementation BATMyPatientTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self pageLayout];
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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
        make.size.mas_offset(CGSizeMake(40, 40));
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    [self.familyStatusImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.size.mas_offset(CGSizeMake(40, 14));
        make.centerX.equalTo(self.avatarImageView.mas_centerX);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-7.5);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.left.equalTo(self.avatarImageView.mas_right).offset(15);
        make.top.equalTo(self.avatarImageView.mas_top).offset(5);
    }];
    
    [self.sexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.left.equalTo(self.avatarImageView.mas_right).offset(15);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(7);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
    
    [self.ageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.left.equalTo(self.sexLabel.mas_right).offset(15);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(7);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
    
}

#pragma mark - get & set
- (UIImageView *)avatarImageView
{
    if (_avatarImageView == nil) {
        _avatarImageView = [[UIImageView alloc] init];
        _avatarImageView.layer.cornerRadius = 40 / 2;
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
        _nameLabel.textColor = UIColorFromHEX(0x333333, 1);
        [_nameLabel sizeToFit];
    }
    return _nameLabel;
}

- (UILabel *)sexLabel
{
    if (_sexLabel == nil) {
        _sexLabel = [[UILabel alloc] init];
        _sexLabel.font = [UIFont systemFontOfSize:14];
        _sexLabel.textColor = UIColorFromHEX(0x666666, 1);
        [_sexLabel sizeToFit];
    }
    return _sexLabel;
}

- (UILabel *)ageLabel
{
    if (_ageLabel == nil) {
        _ageLabel = [[UILabel alloc] init];
        _ageLabel.font = [UIFont systemFontOfSize:14];
        _ageLabel.textColor = UIColorFromHEX(0x666666, 1);
        [_ageLabel sizeToFit];
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
