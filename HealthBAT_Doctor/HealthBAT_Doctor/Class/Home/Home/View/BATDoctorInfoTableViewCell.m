//
//  BATDoctorInfoTableViewCell.m
//  HealthBAT_Doctor
//
//  Created by cjl on 2017/5/10.
//  Copyright © 2017年 KM. All rights reserved.
//

#import "BATDoctorInfoTableViewCell.h"

@implementation BATDoctorInfoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        self.backgroundView = nil;
        [self pageLayout];
        
//        [self setBottomBorderWithColor:UIColorFromHEX(0xeeeeee, 1) width:SCREEN_WIDTH height:0.5];
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
    [self.contentView addSubview:self.avatarBgView];
    [self.avatarBgView addSubview:self.avatarImageView];
    [self.contentView addSubview:self.doctorNameLabel];
    [self.contentView addSubview:self.doctorTitleAndHospitalNameLabel];
//    [self.contentView addSubview:self.hospitalAndDepartmentNameLabel];
    
    WEAK_SELF(self);
    
    [self.avatarBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.size.mas_offset(CGSizeMake(168, 168));
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.top.equalTo(self.contentView.mas_top).offset(35);
    }];
    
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.size.mas_offset(CGSizeMake(158, 158));
        make.center.equalTo(self.avatarBgView);
    }];
    
    [self.doctorNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.avatarBgView.mas_bottom).offset(25);
    }];
    
    [self.doctorTitleAndHospitalNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.doctorNameLabel.mas_bottom).offset(24);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-54);
    }];
    
//    [self.hospitalAndDepartmentNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        STRONG_SELF(self);
//        make.left.equalTo(self.avatarImageView.mas_right).offset(10);
//        make.top.equalTo(self.doctorNameLabel.mas_bottom).offset(10);
//    }];
}

#pragma mark - get & set
- (UIImageView *)avatarBgView
{
    if (_avatarBgView == nil) {
        _avatarBgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home-bg"]];
    }
    return _avatarBgView;
}

- (UIImageView *)avatarImageView
{
    if (_avatarImageView == nil) {
        _avatarImageView = [[UIImageView alloc] init];
        _avatarImageView.layer.cornerRadius = 158 / 2;
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.userInteractionEnabled = YES;
    }
    return _avatarImageView;
}

- (UILabel *)doctorNameLabel
{
    if (_doctorNameLabel == nil) {
        _doctorNameLabel = [[UILabel alloc] init];
        _doctorNameLabel.font = [UIFont systemFontOfSize:18];
        _doctorNameLabel.textColor = STRING_DARK_COLOR;
        _doctorNameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _doctorNameLabel;
}

- (UILabel *)doctorTitleAndHospitalNameLabel
{
    if (_doctorTitleAndHospitalNameLabel == nil) {
        _doctorTitleAndHospitalNameLabel = [[UILabel alloc] init];
        _doctorTitleAndHospitalNameLabel.font = [UIFont systemFontOfSize:14];
        _doctorTitleAndHospitalNameLabel.textColor = STRING_MID_COLOR;
        _doctorTitleAndHospitalNameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _doctorTitleAndHospitalNameLabel;
}

//- (UILabel *)doctorTitleLabel
//{
//    if (_doctorTitleLabel == nil) {
//        _doctorTitleLabel = [[UILabel alloc] init];
//        _doctorTitleLabel.font = [UIFont systemFontOfSize:14];
//        _doctorTitleLabel.textColor = UIColorFromHEX(0x666666, 1);
//    }
//    return _doctorTitleLabel;
//}

//- (UILabel *)hospitalAndDepartmentNameLabel
//{
//    if (_hospitalAndDepartmentNameLabel == nil) {
//        _hospitalAndDepartmentNameLabel = [[UILabel alloc] init];
//        _hospitalAndDepartmentNameLabel.font = [UIFont systemFontOfSize:14];
//        _hospitalAndDepartmentNameLabel.textColor = UIColorFromHEX(0x666666, 1);
//    }
//    return _hospitalAndDepartmentNameLabel;
//}

@end
