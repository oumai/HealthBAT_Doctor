//
//  BATDoctorStudioConsultingRoomView.m
//  HealthBAT_Doctor
//
//  Created by cjl on 2017/5/11.
//  Copyright © 2017年 KM. All rights reserved.
//

#import "BATDoctorStudioConsultingRoomView.h"

@implementation BATDoctorStudioConsultingRoomView

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
    [self addSubview:self.topSlideView];
    
    WEAK_SELF(self);
    [self.topSlideView mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.edges.equalTo(self);
        
    }];
}

#pragma mark - get & set
- (DLTabedSlideView *)topSlideView
{
    if (!_topSlideView) {
        _topSlideView = [[DLTabedSlideView alloc] initWithFrame:CGRectMake(0, 1, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
        _topSlideView.tabItemNormalColor = [UIColor blackColor];
        _topSlideView.tabItemSelectedColor = BLUE_COLOR;
        _topSlideView.backgroundColor = [UIColor whiteColor];
        _topSlideView.tabbarTrackColor = BLUE_COLOR;
        _topSlideView.tabbarBottomSpacing = 0.0;
        _topSlideView.tabbarBottomLineSpaceX = 30;
        DLTabedbarItem *item1 = [DLTabedbarItem itemWithTitle:@"咨询中" image:nil selectedImage:nil];
        DLTabedbarItem *item2 = [DLTabedbarItem itemWithTitle:@"已咨询" image:nil selectedImage:nil];
        _topSlideView.tabbarItems = @[item1, item2];
        [_topSlideView buildTabbar];
    }
    return _topSlideView;
}


@end
