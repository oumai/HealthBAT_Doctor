//
//  BATDoctorServiceInfoTableViewCell.m
//  HealthBAT_Doctor
//
//  Created by cjl on 2017/5/10.
//  Copyright © 2017年 KM. All rights reserved.
//

#import "BATDoctorServiceInfoTableViewCell.h"

@implementation BATDoctorServiceInfoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        self.backgroundView = nil;
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
    [self.contentView addSubview:self.consultingButton];
    [self.contentView addSubview:self.consultFinishButton];
    [self.contentView addSubview:self.myPatientButton];
    
    NSArray *temps = [NSArray arrayWithObjects:self.consultingButton,self.consultFinishButton,self.myPatientButton, nil];
    
    [temps mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    WEAK_SELF(self);
    [temps mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-20);
    }];
}

#pragma mark - get & set
- (BATDoctorServiceInfoButton *)consultingButton
{
    if (_consultingButton == nil) {
        _consultingButton = [[BATDoctorServiceInfoButton alloc] init];
        _consultingButton.countLabel.text = @"0";
        _consultingButton.titleLabel.text = @"咨询中";
    }
    return _consultingButton;
}

- (BATDoctorServiceInfoButton *)consultFinishButton
{
    if (_consultFinishButton == nil) {
        _consultFinishButton = [[BATDoctorServiceInfoButton alloc] init];
        _consultFinishButton.countLabel.text = @"0";
        _consultFinishButton.titleLabel.text = @"已咨询";
    }
    return _consultFinishButton;
}

- (BATDoctorServiceInfoButton *)myPatientButton
{
    if (_myPatientButton == nil) {
        _myPatientButton = [[BATDoctorServiceInfoButton alloc] init];
        _myPatientButton.countLabel.text = @"0";
        _myPatientButton.titleLabel.text = @"我的患者";
    }
    return _myPatientButton;
}

@end
