//
//  BATMeTableViewCell.m
//  HealthBAT_Doctor
//
//  Created by cjl on 2017/5/11.
//  Copyright © 2017年 KM. All rights reserved.
//

#import "BATMeTableViewCell.h"

@implementation BATMeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundView = nil;
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self pageLayout];
        
//        [self setBottomBorderWithColor:UIColorFromHEX(0xe0e0e0, 1) width:SCREEN_WIDTH height:0];
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
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.titleLabel];
//    [self.contentView addSubview:self.arrowImageView];
    
    WEAK_SELF(self);
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.size.mas_offset(CGSizeMake(23, 23));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.left.equalTo(self.iconImageView.mas_right).offset(19);
        make.top.bottom.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
    }];
    
//    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        STRONG_SELF(self);
//        make.size.mas_equalTo(CGSizeMake(7, 11));
//        make.right.equalTo(self.contentView.mas_right).offset(-10);
//        make.centerY.equalTo(self.contentView.mas_centerY);
//    }];
}

#pragma mark - get & set

- (UIImageView *)iconImageView
{
    if (_iconImageView == nil) {
        _iconImageView = [[UIImageView alloc] init];
    }
    return _iconImageView;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = UIColorFromHEX(0xffffff, 1);
    }
    return _titleLabel;
}

- (UIImageView *)arrowImageView
{
    if (_arrowImageView == nil) {
        _arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic-right"]];
    }
    return _arrowImageView;
}

@end
