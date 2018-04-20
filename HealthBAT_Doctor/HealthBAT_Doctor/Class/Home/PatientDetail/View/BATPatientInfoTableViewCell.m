//
//  BATPatientInfoTableViewCell.m
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/23.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import "BATPatientInfoTableViewCell.h"

@implementation BATPatientInfoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self pageLayout];
        
        [self setBottomBorderWithColor:UIColorFromHEX(0xf7f7f7, 1) width:SCREEN_WIDTH height:0];
        
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
- (void)chatRecordBtnAction:(UIButton *)button
{
    if (self.chatRecordBlock) {
        self.chatRecordBlock();
    }
}

#pragma mark - pageLayout
- (void)pageLayout
{
    [self.contentView addSubview:self.avatarImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.ageLabel];
    [self.contentView addSubview:self.marriageLabel];
    [self.contentView addSubview:self.chatRecordBtn];
    
    WEAK_SELF(self);
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.size.mas_offset(CGSizeMake(40, 40));
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.left.equalTo(self.avatarImageView.mas_right).offset(15);
        make.top.equalTo(self.avatarImageView.mas_top);
    }];
    
    [self.ageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.left.equalTo(self.avatarImageView.mas_right).offset(15);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(7);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15);
    }];
    
    [self.marriageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.left.equalTo(self.ageLabel.mas_right).offset(15);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(7);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15);
    }];
    
    [self.chatRecordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.centerY.equalTo(self.contentView.mas_centerY);
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

- (UILabel *)marriageLabel
{
    if (_marriageLabel == nil) {
        _marriageLabel = [[UILabel alloc] init];
        _marriageLabel.font = [UIFont systemFontOfSize:14];
        _marriageLabel.textColor = UIColorFromHEX(0x666666, 1);
        [_marriageLabel sizeToFit];
    }
    return _marriageLabel;
}

- (UIButton *)chatRecordBtn
{
    if (_chatRecordBtn == nil) {
        _chatRecordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_chatRecordBtn setTitle:@"查看聊天记录" forState:UIControlStateNormal];
        [_chatRecordBtn setTitleColor:UIColorFromHEX(0x0182eb, 1) forState:UIControlStateNormal];
        _chatRecordBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_chatRecordBtn sizeToFit];
        [_chatRecordBtn addTarget:self action:@selector(chatRecordBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        _chatRecordBtn.hidden = YES;
    }
    return _chatRecordBtn;
}

@end
