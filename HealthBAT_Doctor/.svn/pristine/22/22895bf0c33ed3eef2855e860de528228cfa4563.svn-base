//
//  BATWithdrawAccountTableViewCell.m
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/20.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import "BATWithdrawAccountTableViewCell.h"

@implementation BATWithdrawAccountTableViewCell

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
//#warning 开发中...
//    [self addSubview:self.titleLabel];
//    [self addSubview:self.symbolLabel];
//    [self addSubview:self.textField];
//    
//    WEAK_SELF(self);
//    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        STRONG_SELF(self);
//    }];
}

#pragma mark - get & set
- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = UIColorFromHEX(0x333333, 1);
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}

- (UILabel *)symbolLabel
{
    if (_symbolLabel == nil) {
        _symbolLabel = [[UILabel alloc] init];
        _symbolLabel.font = [UIFont systemFontOfSize:36];
        _symbolLabel.textColor = UIColorFromHEX(0x333333, 1);
        [_symbolLabel sizeToFit];
    }
    return _symbolLabel;
}

- (UITextField *)textField
{
    if (_textField == nil) {
        _textField = [[UITextField alloc] init];
    }
    return _textField;
}

@end
