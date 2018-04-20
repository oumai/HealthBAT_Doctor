//
//  BATFeeTableViewCell.m
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/16.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import "BATFeeTableViewCell.h"

@interface BATFeeTableViewCell () <UITextFieldDelegate>

@end

@implementation BATFeeTableViewCell

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

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.feeInput) {
        self.feeInput(textField.text,self.indexPath);
    }
}

#pragma mark - pageLayout
- (void)pageLayout
{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.textField];
    [self.contentView addSubview:self.unitLabel];
    
    WEAK_SELF(self);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.top.bottom.equalTo(self.contentView);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.left.equalTo(self.titleLabel.mas_right).offset(10);
        make.top.bottom.equalTo(self.contentView);
        make.width.mas_offset(100);
    }];
    
    [self.unitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.left.equalTo(self.textField.mas_right).offset(10);
        make.top.bottom.equalTo(self.contentView);
    }];
}


#pragma mark - get & set
- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = UIColorFromHEX(0x333333, 1);
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}

- (UITextField *)textField
{
    if (_textField == nil) {
        _textField = [[UITextField alloc] init];
        _textField.font = [UIFont systemFontOfSize:14];
        _textField.textColor = UIColorFromHEX(0x999999, 1);
        _textField.textAlignment = NSTextAlignmentCenter;
        _textField.delegate = self;
        _textField.keyboardType = UIKeyboardTypeDecimalPad;
    }
    return _textField;
}

- (UILabel *)unitLabel
{
    if (_unitLabel == nil) {
        _unitLabel = [[UILabel alloc] init];
        _unitLabel.font = [UIFont systemFontOfSize:14];
        _unitLabel.textColor = UIColorFromHEX(0x333333, 1);
        [_unitLabel sizeToFit];
    }
    return _unitLabel;
}

@end
