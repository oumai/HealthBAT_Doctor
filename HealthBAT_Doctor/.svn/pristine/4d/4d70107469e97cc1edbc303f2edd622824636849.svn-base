//
//  BATOpinionFooterView.m
//  HealthBAT_Pro
//
//  Created by cjl on 2016/11/3.
//  Copyright © 2016年 KMHealthCloud. All rights reserved.
//

#import "BATOpinionFooterView.h"

@implementation BATOpinionFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn setFrame:CGRectMake(10, 30.0f, SCREEN_WIDTH - 20.0f, 40)];
        [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_submitBtn setBackgroundImage:[Tools imageFromColor:UIColorFromHEX(0x45a0f0, 1)] forState:UIControlStateNormal];
        [_submitBtn setBackgroundImage:[Tools imageFromColor:UIColorFromHEX(0xcdcdcd, 1)] forState:UIControlStateDisabled];
        _submitBtn.layer.cornerRadius = 6.0f;
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.enabled = NO;
        [self addSubview:_submitBtn];
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

@end
