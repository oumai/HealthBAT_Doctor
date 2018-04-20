//
//  BATContractContentTableViewCell.m
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/20.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import "BATContractContentTableViewCell.h"

@implementation BATContractContentTableViewCell

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
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.timeLabel];
    
    WEAK_SELF(self);
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.top.equalTo(self.contentView.mas_top).offset(20);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.top.equalTo(self.contentLabel.mas_bottom).offset(21);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-33);
    }];
}

#pragma mark - get & set
- (UILabel *)contentLabel
{
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:15];
        _contentLabel.textColor = UIColorFromHEX(0x333333, 1);
        _contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

- (UILabel *)timeLabel
{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:15];
        _timeLabel.textColor = UIColorFromHEX(0x333333, 1);
        _timeLabel.backgroundColor = [UIColor clearColor];
        _timeLabel.textAlignment = NSTextAlignmentRight;
    }
    return _timeLabel;
}
@end
