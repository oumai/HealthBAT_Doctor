//
//  BATReservationManageTitleCell.m
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/17.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import "BATReservationManageTitleCell.h"

@implementation BATReservationManageTitleCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = STRING_MID_COLOR;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = [UIFont systemFontOfSize:12];
        //        _titleLabel.layer.borderColor = UIColorFromHEX(0xf6f6f6, 1).CGColor;
        //        _titleLabel.layer.borderWidth = 0.5f;
        [self.contentView addSubview:_titleLabel];
        
        [self setupConstraints];
        
    }
    return self;
}

- (void)setupConstraints
{
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

@end
