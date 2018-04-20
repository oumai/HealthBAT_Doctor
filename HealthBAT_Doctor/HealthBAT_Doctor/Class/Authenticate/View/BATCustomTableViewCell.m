//
//  BATCustomTableViewCell.m
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/15.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import "BATCustomTableViewCell.h"

@interface BATCustomTableViewCell () <UITextFieldDelegate>

@end

@implementation BATCustomTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
//        self.canInput = YES;
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
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//    
//    if (self.textClick) {
//        self.textClick(self.indexPath);
//    }
//    
//    return self.canInput;
//}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.textInput) {
        self.textInput(textField.text,self.indexPath);
    }
}

#pragma mark - pageLayout
- (void)pageLayout
{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.textField];
    [self.contentView addSubview:self.arrowImageView];
    
    WEAK_SELF(self);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.top.bottom.equalTo(self.contentView);
        make.width.mas_offset(100);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.left.greaterThanOrEqualTo(self.titleLabel.mas_right).offset(10);
        make.top.bottom.equalTo(self.contentView);
        make.width.mas_offset(150);
        make.right.equalTo(self.arrowImageView.mas_left).offset(-10);
    }];
    
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.size.mas_equalTo(CGSizeMake(7, 11));
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
}

- (NSMutableAttributedString *)setTitleString:(NSString *)title
{
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:title];
    [string addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:UIColorFromHEX(0x333333, 1)} range:NSMakeRange(0, title.length)];
    [string addAttribute:NSForegroundColorAttributeName value:UIColorFromHEX(0xff3b2f, 1) range:NSMakeRange(title.length - 1, 1)];
    
    return string;
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

- (UITextField *)textField
{
    if (_textField == nil) {
        _textField = [[UITextField alloc] init];
        _textField.font = [UIFont systemFontOfSize:14];
        _textField.textColor = UIColorFromHEX(0x999999, 1);
        _textField.textAlignment = NSTextAlignmentRight;
        _textField.delegate = self;
    }
    return _textField;
}

- (UIImageView *)arrowImageView
{
    if (_arrowImageView == nil) {
        _arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic-right"]];
    }
    return _arrowImageView;
}

@end
