//
//  BATReservationCountPickerView.m
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/17.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import "BATReservationCountPickerView.h"

@interface BATReservationCountPickerView () <UIPickerViewDelegate,UIPickerViewDataSource>

@end

@implementation BATReservationCountPickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 10.0f;
        self.layer.masksToBounds = YES;
        
        [self pageLayout];
        
        _value = 0;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 101;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 50;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 100;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"%@",row < 10 ? [NSString stringWithFormat:@"0%ld",row] : [NSString stringWithFormat:@"%ld",row]];
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    
    CGFloat width = [self pickerView:pickerView widthForComponent:component];
    
    CGFloat height = [self pickerView:pickerView rowHeightForComponent:component];
    
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
    }
    
    NSString *selectString = [self pickerView:pickerView titleForRow:row forComponent:component];
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:selectString];
    [string addAttributes:@{NSForegroundColorAttributeName:UIColorFromHEX(0x000000, 1),NSFontAttributeName:[UIFont systemFontOfSize:21]} range:NSMakeRange(0, string.length)];
    
    pickerLabel.attributedText = string;
    
    return pickerLabel;
}

#pragma mark - UIPickerViewDelegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _value = row;
}


#pragma mark - Action
- (void)confirmBtnAction:(UIButton *)button
{
    if (self.confirmBlock) {
        self.confirmBlock(_value);
    }
}

#pragma mark - pageLayout
- (void)pageLayout
{
    [self addSubview:self.titleLabel];
    [self addSubview:self.pickerView];
    [self addSubview:self.confirmBtn];
    [self addSubview:self.unitLabel];
    
    WEAK_SELF(self);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.top.equalTo(self.mas_top).offset(35);
        make.height.mas_offset(30);
        make.left.right.equalTo(self);
    }];
    
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.left.right.equalTo(self);
    }];
    
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.bottom.equalTo(self.mas_bottom).offset(-35);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH - 40 - 20, 45));
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [self.unitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.centerX.equalTo(self.mas_centerX).offset(30);
        make.centerY.equalTo(self.pickerView.mas_centerY);
    }];
}

#pragma mark - get & set
- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.textColor = UIColorFromHEX(0x00000, 1);
        _titleLabel.text = @"设置挂号人数";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIPickerView *)pickerView
{
    if (_pickerView == nil) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}

- (UILabel *)unitLabel
{
    if (_unitLabel == nil) {
        _unitLabel = [[UILabel alloc] init];
        _unitLabel.font = [UIFont systemFontOfSize:15];
        _unitLabel.textColor = UIColorFromHEX(0x000000, 1);
        _unitLabel.textAlignment = NSTextAlignmentCenter;
        _unitLabel.text = @"人";
        [_unitLabel sizeToFit];
    }
    return _unitLabel;
}

- (UIButton *)confirmBtn
{
    if (_confirmBtn == nil) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
        [_confirmBtn setBackgroundImage:[Tools imageFromColor:BLUE_COLOR] forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:UIColorFromHEX(0xffffff, 1) forState:UIControlStateNormal];
        [_confirmBtn addTarget:self action:@selector(confirmBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        _confirmBtn.layer.cornerRadius = 6.0f;
        _confirmBtn.layer.masksToBounds = YES;
    }
    return _confirmBtn;
}

@end
