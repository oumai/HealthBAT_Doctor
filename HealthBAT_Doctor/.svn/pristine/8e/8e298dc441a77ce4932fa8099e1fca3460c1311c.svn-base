//
//  BATDoctorInfoHeaderView.m
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/22.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import "BATDoctorInfoHeaderView.h"

@implementation BATDoctorInfoHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromHEX(0xf7f7f7, 1);
        [self pageLayout];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

#pragma mark - Action
- (void)tapHandle:(UITapGestureRecognizer *)tap
{
    if (self.doctorAvatarClickBlock) {
        self.doctorAvatarClickBlock();
    }
}

#pragma mark - pageLayout
- (void)pageLayout
{
    [self addSubview:self.avatarBgView];
    [self.avatarBgView addSubview:self.avatarImageView];
    [self addSubview:self.doctorNameLabel];
    [self addSubview:self.doctorTitleAndHospitalNameLabel];
    [self addSubview:self.consultingButton];
    [self addSubview:self.consultFinishButton];
    [self addSubview:self.myPatientButton];
    
    CGFloat offsetTop = 35;
    CGFloat offsetContentTop = 25;
    CGFloat offsetButtonTop = 54;
    if (iPhone4 || iPad || iPadAir) {
        offsetTop = 0;
        offsetButtonTop = 0;
        offsetContentTop = 0;
    } else if(iPhone5){
        offsetTop = 0;
        offsetButtonTop = 5;
        offsetContentTop = 5;
    }else if(iPhone6){
        offsetTop = 10;
        offsetButtonTop = 20;
        offsetContentTop = 5;
    }else if(iPhone6p){
        offsetTop = 35;
        offsetButtonTop = 54;
        offsetContentTop = 25;
    }else {
        offsetTop = 35;
        offsetButtonTop = 54;
        offsetContentTop = 25;
    }
    
    WEAK_SELF(self);
    [self.avatarBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.size.mas_offset(CGSizeMake(168, 168));
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(offsetTop);
    }];
    
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.size.mas_offset(CGSizeMake(158, 158));
        make.center.equalTo(self.avatarBgView);
    }];
    
    [self.doctorNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.centerX.equalTo(self.mas_centerX);
        make.width.mas_offset(SCREEN_WIDTH - 20);
        make.top.equalTo(self.avatarBgView.mas_bottom).offset(offsetContentTop);
    }];
    
    [self.doctorTitleAndHospitalNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.centerX.equalTo(self.mas_centerX);
        make.width.mas_offset(SCREEN_WIDTH - 20);
        make.top.equalTo(self.doctorNameLabel.mas_bottom).offset(offsetContentTop);
//        make.bottom.equalTo(self.mas_bottom).offset(-54);
    }];
    
    NSArray *temps = [NSArray arrayWithObjects:self.consultingButton,self.consultFinishButton,self.myPatientButton, nil];
    
    [temps mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [temps mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.top.equalTo(self.doctorTitleAndHospitalNameLabel.mas_bottom).offset(offsetButtonTop);
        make.bottom.equalTo(self.mas_bottom);
    }];

}

#pragma mark - get & set
- (UIImageView *)avatarBgView
{
    if (_avatarBgView == nil) {
        _avatarBgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home-bg"]];
        _avatarBgView.userInteractionEnabled = YES;
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
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandle:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [_avatarImageView addGestureRecognizer:tap];
        
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

- (BATDoctorServiceInfoButton *)consultingButton
{
    if (_consultingButton == nil) {
        _consultingButton = [[BATDoctorServiceInfoButton alloc] init];
        _consultingButton.countLabel.text = @"0";
        _consultingButton.titleLabel.text = @"咨询中";
        [_consultingButton sizeToFit];
    }
    return _consultingButton;
}

- (BATDoctorServiceInfoButton *)consultFinishButton
{
    if (_consultFinishButton == nil) {
        _consultFinishButton = [[BATDoctorServiceInfoButton alloc] init];
        _consultFinishButton.countLabel.text = @"0";
        _consultFinishButton.titleLabel.text = @"已咨询";
        [_consultFinishButton sizeToFit];
    }
    return _consultFinishButton;
}

- (BATDoctorServiceInfoButton *)myPatientButton
{
    if (_myPatientButton == nil) {
        _myPatientButton = [[BATDoctorServiceInfoButton alloc] init];
        _myPatientButton.countLabel.text = @"0";
        _myPatientButton.titleLabel.text = @"我的患者";
        [_myPatientButton sizeToFit];
    }
    return _myPatientButton;
}

@end
