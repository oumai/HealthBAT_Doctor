//
//  BATReservationManageOptionCell.m
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/17.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import "BATReservationManageOptionCell.h"

@implementation BATReservationManageOptionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _borderView = [[UIView alloc] init];
        _borderView.backgroundColor = BLUE_COLOR;
        _borderView.hidden = YES;
        [self.contentView addSubview:_borderView];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor whiteColor];
        _titleLabel.textColor = BLUE_COLOR;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_titleLabel];
        
        [self setupConstraints];
        
    }
    return self;
}

- (void)setupConstraints
{
    
    WEAK_SELF(self);
    [_borderView mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(-1, -1, -1, -1));
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.edges.equalTo(self);
    }];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
//    _titleLabel.textColor = UIColorFromHEX(0x45a0f0, 1);
//    _titleLabel.backgroundColor = [UIColor whiteColor];
    
//    if (![_regNumList.DoctorScheduleID isEqualToString:@"0"]) {
//        if (self.selected) {
//            _titleLabel.textColor = [UIColor whiteColor];
//            _titleLabel.backgroundColor = UIColorFromHEX(0x45a0f0, 1);
//        } else {
//            _titleLabel.textColor = UIColorFromHEX(0x45a0f0, 1);
//            _titleLabel.backgroundColor = [UIColor whiteColor];
//        }
//    }
    
    
}


@end
