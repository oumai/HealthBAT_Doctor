//
//  BATAuthenticatePicTableViewCell.m
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/15.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import "BATAuthenticatePicTableViewCell.h"

@implementation BATAuthenticatePicTableViewCell

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
- (void)addBtnAction:(UIButton *)button
{
    if (self.addPicBlock) {
        self.addPicBlock();
    }
}

- (void)deleteBtnAction:(UIButton *)button
{
    if (self.deletePicBlock) {
        self.deletePicBlock();
    }
}

#pragma mark - pageLayout
- (void)pageLayout
{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.picView];
    [self.contentView addSubview:self.deleteBtn];
    [self.contentView addSubview:self.addBtn];
    
    WEAK_SELF(self);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.top.bottom.equalTo(self.contentView);
        make.width.mas_offset(80);
    }];
    
    [self.picView mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.left.equalTo(self.titleLabel.mas_right).offset(10);
        make.size.mas_offset(CGSizeMake(120, 80));
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.size.mas_offset(CGSizeMake(20, 20));
        make.centerY.equalTo(self.picView.mas_top);
        make.centerX.equalTo(self.picView.mas_right);
    }];
    
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.size.mas_offset(CGSizeMake(60, 60));
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
}

#pragma mark - get & set
- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}

- (UIImageView *)picView
{
    if (_picView == nil) {
        _picView = [[UIImageView alloc] init];
    }
    return _picView;
}

- (UIButton *)deleteBtn
{
    if (_deleteBtn == nil) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setTitle:@"x" forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(deleteBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _deleteBtn.hidden = YES;
    }
    return _deleteBtn;
}

- (UIButton *)addBtn
{
    if (_addBtn == nil) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn setBackgroundImage:[UIImage imageNamed:@"img-add-zp"] forState:UIControlStateNormal];
        [_addBtn addTarget:self action:@selector(addBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}

@end
