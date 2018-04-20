//
//  BATMyPatientSectionHeaderView.m
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/21.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import "BATMyPatientSectionHeaderView.h"

@implementation BATMyPatientSectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        [self pageLayout];
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

#pragma mark - pageLayout
- (void)pageLayout
{
    [self addSubview:self.sectionIndexLabel];
    
    WEAK_SELF(self);
    [self.sectionIndexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
}

#pragma mark - get & set
- (UILabel *)sectionIndexLabel
{
    if (_sectionIndexLabel == nil) {
        _sectionIndexLabel = [[UILabel alloc] init];
        _sectionIndexLabel.font = [UIFont systemFontOfSize:18];
        _sectionIndexLabel.textColor = UIColorFromHEX(0x333333, 1);
        _sectionIndexLabel.backgroundColor = [UIColor clearColor];
    }
    return _sectionIndexLabel;
}

@end
