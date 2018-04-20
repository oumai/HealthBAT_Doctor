//
//  BATMeHeaderView.m
//  HealthBAT_Doctor
//
//  Created by cjl on 2017/6/20.
//  Copyright © 2017年 KM. All rights reserved.
//

#import "BATMeHeaderView.h"

@implementation BATMeHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
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
    [self addSubview:self.avatarBgView];
    [self.avatarBgView addSubview:self.avatarImageView];
    
    WEAK_SELF(self);
    [self.avatarBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.size.mas_offset(CGSizeMake(88, 88));
        make.left.equalTo(self.mas_left).offset(68);
        make.bottom.equalTo(self);
    }];
    
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.size.mas_offset(CGSizeMake(83, 83));
        make.center.equalTo(self.avatarBgView);
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
        _avatarImageView.layer.cornerRadius = 83 / 2;
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.userInteractionEnabled = YES;
        
        WEAK_SELF(self);
        [_avatarBgView bk_whenTapped:^{
            STRONG_SELF(self);
            if (self.avatarBlock) {
                self.avatarBlock();
            }
        }];
        
    }
    return _avatarImageView;
}


@end
