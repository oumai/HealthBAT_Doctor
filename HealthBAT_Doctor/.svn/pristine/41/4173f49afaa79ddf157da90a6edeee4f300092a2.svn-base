//
//  BATFamilyOrderCell.m
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/20.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import "BATFamilyOrderCell.h"
#import <CoreText/CoreText.h>

@interface BATFamilyOrderCell ()

@end

@implementation BATFamilyOrderCell

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
    [self.contentView addSubview:self.orderPayTimeLabel];
    [self.contentView addSubview:self.lineLabel];
    [self.contentView addSubview:self.partyALabel];
    [self.contentView addSubview:self.serviceTimeLabel];
    [self.contentView addSubview:self.serviceContentLabel];
    
    WEAK_SELF(self);
    [self.orderPayTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.contentView.mas_top);
        make.height.mas_offset(35);
    }];
    
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(self.orderPayTimeLabel.mas_bottom);
        make.height.mas_offset(1/[UIScreen mainScreen].scale);
    }];
    
    [self.partyALabel mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.lineLabel.mas_bottom).offset(15);
    }];
    
    [self.serviceTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.partyALabel.mas_bottom).offset(15);
    }];
    
    [self.serviceContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.serviceTimeLabel.mas_bottom).offset(15);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15);
    }];
    
}

#pragma mark - get & set
- (UILabel *)orderPayTimeLabel
{
    if (_orderPayTimeLabel == nil) {
        _orderPayTimeLabel = [[UILabel alloc] init];
        _orderPayTimeLabel.font = [UIFont systemFontOfSize:15];
        _orderPayTimeLabel.textColor = UIColorFromHEX(0x666666, 1);
        _orderPayTimeLabel.backgroundColor = [UIColor clearColor];
    }
    return _orderPayTimeLabel;
}

- (UILabel *)lineLabel
{
    if (_lineLabel == nil) {
        _lineLabel = [[UILabel alloc] init];
        _lineLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _lineLabel;
}

- (UILabel *)partyALabel
{
    if (_partyALabel == nil) {
        _partyALabel = [[UILabel alloc] init];
        _partyALabel.font = [UIFont systemFontOfSize:16];
        _partyALabel.textColor = UIColorFromHEX(0x333333, 1);
        _partyALabel.backgroundColor = [UIColor clearColor];
    }
    return _partyALabel;
}

- (UILabel *)serviceTimeLabel
{
    if (_serviceTimeLabel == nil) {
        _serviceTimeLabel = [[UILabel alloc] init];
        _serviceTimeLabel.font = [UIFont systemFontOfSize:16];
        _serviceTimeLabel.textColor = UIColorFromHEX(0x333333, 1);
        _serviceTimeLabel.backgroundColor = [UIColor clearColor];
    }
    return _serviceTimeLabel;
}

- (UILabel *)serviceContentLabel
{
    if (_serviceContentLabel == nil) {
        _serviceContentLabel = [[UILabel alloc] init];
        _serviceContentLabel.font = [UIFont systemFontOfSize:16];
        _serviceContentLabel.textColor = UIColorFromHEX(0x333333, 1);
        _serviceContentLabel.backgroundColor = [UIColor clearColor];
    }
    return _serviceContentLabel;
}

@end
