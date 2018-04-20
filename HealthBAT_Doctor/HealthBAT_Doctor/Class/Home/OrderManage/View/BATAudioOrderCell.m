//
//  BATAudioOrderCell.m
//  HealthBAT_Doctor
//
//  Created by cjl on 2017/5/13.
//  Copyright © 2017年 KM. All rights reserved.
//

#import "BATAudioOrderCell.h"

@implementation BATAudioOrderCell

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
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.orderType];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.statusLabel];
    
    
    WEAK_SELF(self);
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.top.equalTo(self.contentView.mas_top).offset(15);
    }];
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.left.equalTo(self.nameLabel.mas_right).offset(10).priorityLow();
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.contentView.mas_top).offset(15);
    }];
    
    [self.orderType mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(15);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.top.equalTo(self.orderType.mas_bottom).offset(15);
    }];
}

#pragma mark - get & set
- (UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:16];
        _nameLabel.textColor = UIColorFromHEX(0x333333, 1);
        _nameLabel.backgroundColor = [UIColor clearColor];
    }
    return _nameLabel;
}

- (UILabel *)orderType
{
    if (_orderType == nil) {
        _orderType = [[UILabel alloc] init];
        _orderType.font = [UIFont systemFontOfSize:16];
        _orderType.textColor = UIColorFromHEX(0x333333, 1);
        _orderType.backgroundColor = [UIColor clearColor];
    }
    return _orderType;
}

- (UILabel *)timeLabel
{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:16];
        _timeLabel.textColor = UIColorFromHEX(0x333333, 1);
        _timeLabel.backgroundColor = [UIColor clearColor];
    }
    return _timeLabel;
}

- (UILabel *)statusLabel
{
    if (_statusLabel == nil) {
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.font = [UIFont systemFontOfSize:16];
        _statusLabel.textColor = UIColorFromHEX(0x666666, 1);
        _statusLabel.backgroundColor = [UIColor clearColor];
        [_statusLabel sizeToFit];
    }
    return _statusLabel;
}

@end
