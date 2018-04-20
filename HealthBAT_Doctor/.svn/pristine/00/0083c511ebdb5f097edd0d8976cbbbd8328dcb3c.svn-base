//
//  BATDoctorInfoAvatarTableViewCell.m
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/17.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import "BATDoctorInfoAvatarTableViewCell.h"

@implementation BATDoctorInfoAvatarTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
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

#pragma mark - Action

#pragma mark - pageLayout
- (void)pageLayout
{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.avatarImageView];
    [self.contentView addSubview:self.arrowImageView];
    
    WEAK_SELF(self);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.width.mas_offset(80);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.right.equalTo(self.arrowImageView.mas_left).offset(-10);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(55, 55));
    }];
    
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.size.mas_equalTo(CGSizeMake(7, 11));
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
}

#pragma mark - get & set
- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = UIColorFromHEX(0x333333, 1);
    }
    return _titleLabel;
}

- (UIImageView *)avatarImageView
{
    if (_avatarImageView == nil) {
        _avatarImageView = [[UIImageView alloc] init];
        _avatarImageView.backgroundColor = [UIColor clearColor];
        _avatarImageView.layer.cornerRadius = 55 / 2;
        _avatarImageView.layer.masksToBounds = YES;
    }
    return _avatarImageView;
}

- (UIImageView *)arrowImageView
{
    if (_arrowImageView == nil) {
        _arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic-right"]];
    }
    return _arrowImageView;
}

@end
