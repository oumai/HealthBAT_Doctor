//
//  BATMessageCenterTableViewCell.m
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/16.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import "BATMessageCenterTableViewCell.h"

@implementation BATMessageCenterTableViewCell

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

#pragma mark - pageLayout
- (void)pageLayout
{
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.pointImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.timeLabel];
    
    WEAK_SELF(self);
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.size.mas_offset(CGSizeMake(48.5, 48.5));
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView.mas_left).offset(10);
    }];
    
    [self.pointImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.top.equalTo(self.iconImageView.mas_top).offset(0);
        make.size.mas_offset(CGSizeMake(10, 10));
        make.right.equalTo(self.iconImageView.mas_right).offset(-5);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.left.equalTo(self.iconImageView.mas_right).offset(9);
        make.top.equalTo(self.iconImageView.mas_top);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.left.greaterThanOrEqualTo(self.titleLabel).offset(10);
        make.centerY.equalTo(self.titleLabel.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.equalTo(self.titleLabel.mas_left);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-20);
    }];
}

#pragma mark - get & set
- (UIImageView *)iconImageView
{
    if (_iconImageView == nil) {
        _iconImageView = [[UIImageView alloc] init];
    }
    return _iconImageView;
}

- (UIImageView *)pointImageView
{
    if (_pointImageView == nil) {
        _pointImageView = [[UIImageView alloc] init];
        _pointImageView.backgroundColor = [UIColor redColor];
        _pointImageView.layer.cornerRadius = 5.0f;
        _pointImageView.layer.masksToBounds = YES;
        _pointImageView.hidden = YES;
    }
    return _pointImageView;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = UIColorFromHEX(0x333333, 1);
    }
    return _titleLabel;
}

- (UILabel *)contentLabel
{
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.textColor = UIColorFromHEX(0x999999, 1);
    }
    return _contentLabel;
}

- (UILabel *)timeLabel
{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:14];
        _timeLabel.textColor = UIColorFromHEX(0x999999, 1);
        _timeLabel.textAlignment = NSTextAlignmentRight;
    }
    return _timeLabel;
}

@end
