//
//  BATCustomSwitchTableViewCell.m
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/16.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import "BATCustomSwitchTableViewCell.h"

@implementation BATCustomSwitchTableViewCell

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

- (void)switchOnAction:(UISwitch *)switchOn
{
    if (self.switchAction) {
        self.switchAction(switchOn.on);
    }
}

#pragma mark - pageLayout
- (void)pageLayout
{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.switchOn];
    
    WEAK_SELF(self);
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.top.bottom.equalTo(self.contentView);
    }];
    
    [self.switchOn mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
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

- (UISwitch *)switchOn
{
    if (_switchOn == nil) {
        _switchOn = [[UISwitch alloc] init];
        _switchOn.onTintColor = UIColorFromHEX(0xff8c28, 1);
        [_switchOn addTarget:self action:@selector(switchOnAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _switchOn;
}


@end
