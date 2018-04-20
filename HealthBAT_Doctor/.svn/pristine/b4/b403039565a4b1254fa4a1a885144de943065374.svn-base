//
//  BATTextImageOrderCell.m
//  HealthBAT_Doctor
//
//  Created by cjl on 2017/4/11.
//  Copyright © 2017年 KM. All rights reserved.
//

#import "BATTextImageOrderCell.h"

@implementation BATTextImageOrderCell

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
- (void)resetUI:(NSInteger)consultStatus
{
    if (consultStatus == 1 || consultStatus == 4) {
        //咨询中 未回复
        
        self.line.hidden = NO;
        self.replyBtn.hidden = NO;
        
        WEAK_SELF(self);
        [self.descLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            STRONG_SELF(self);
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            make.top.equalTo(self.consultTimeLabel.mas_bottom).offset(15);
        }];
        
        [self.line mas_remakeConstraints:^(MASConstraintMaker *make) {
            STRONG_SELF(self);
            make.left.equalTo(self.contentView.mas_left);
            make.right.equalTo(self.contentView.mas_right);
            make.top.equalTo(self.descLabel.mas_bottom).offset(15);
            make.height.mas_offset(1 / [UIScreen mainScreen].scale);
        }];
        
        [self.replyBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            STRONG_SELF(self);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            make.size.mas_offset(CGSizeMake(75, 28));
            make.top.equalTo(self.line.mas_bottom).offset(6);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-6);
        }];
        
    } else {
        //咨询完成
        
        self.line.hidden = YES;
        self.replyBtn.hidden = YES;
        
        WEAK_SELF(self);
        
        [self.line mas_remakeConstraints:^(MASConstraintMaker *make) {
            
        }];
        
        [self.replyBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            
        }];
        
        [self.descLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            STRONG_SELF(self);
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            make.top.equalTo(self.consultTimeLabel.mas_bottom).offset(15);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-15);
        }];
    }
    
//    [self.contentView setNeedsLayout];
//    [self.contentView layoutIfNeeded];
}

- (void)replyBtnAction
{
    if (self.replyBlock) {
        self.replyBlock();
    }
}

#pragma mark - pageLayout
- (void)pageLayout
{
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.consultTimeLabel];
    [self.contentView addSubview:self.descLabel];
    [self.contentView addSubview:self.line];
    [self.contentView addSubview:self.statusLabel];
    [self.contentView addSubview:self.replyBtn];
    
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
    
    [self.consultTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(15);
    }];
    
//    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        STRONG_SELF(self);
//        make.left.equalTo(self.contentView.mas_left).offset(10);
//        make.right.equalTo(self.contentView.mas_right).offset(-10);
//        make.top.equalTo(self.consultTimeLabel.mas_bottom).offset(15);
//    }];
//    
//    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
//        STRONG_SELF(self);
//        make.left.equalTo(self.contentView.mas_left);
//        make.right.equalTo(self.contentView.mas_right);
//        make.top.equalTo(self.descLabel.mas_bottom).offset(15);
//        make.height.mas_offset(1 / [UIScreen mainScreen].scale);
//    }];
//    
//    [self.replyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        STRONG_SELF(self);
//        make.right.equalTo(self.contentView.mas_right).offset(-10);
//        make.size.mas_offset(CGSizeMake(75, 28));
//        make.top.equalTo(self.line.mas_bottom).offset(6);
//        make.bottom.equalTo(self.contentView.mas_bottom).offset(-6);
//    }];
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

- (UILabel *)consultTimeLabel
{
    if (_consultTimeLabel == nil) {
        _consultTimeLabel = [[UILabel alloc] init];
        _consultTimeLabel.font = [UIFont systemFontOfSize:16];
        _consultTimeLabel.textColor = UIColorFromHEX(0x333333, 1);
        _consultTimeLabel.backgroundColor = [UIColor clearColor];
    }
    return _consultTimeLabel;
}

- (UILabel *)descLabel
{
    if (_descLabel == nil) {
        _descLabel = [[UILabel alloc] init];
        _descLabel.font = [UIFont systemFontOfSize:16];
        _descLabel.textColor = UIColorFromHEX(0x333333, 1);
        _descLabel.backgroundColor = [UIColor clearColor];
    }
    return _descLabel;
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

- (UILabel *)line
{
    if (_line == nil) {
        _line = [[UILabel alloc] init];
        _line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _line;
}

- (UIButton *)replyBtn
{
    if (_replyBtn == nil) {
        _replyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_replyBtn setTitle:@"立即回复" forState:UIControlStateNormal];
        [_replyBtn setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
        [_replyBtn addTarget:self action:@selector(replyBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
        _replyBtn.layer.cornerRadius = 6;
        _replyBtn.layer.masksToBounds = YES;
        _replyBtn.layer.borderColor = BLUE_COLOR.CGColor;
        _replyBtn.layer.borderWidth = 1 / [UIScreen mainScreen].scale;
        _replyBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _replyBtn;
}

@end
