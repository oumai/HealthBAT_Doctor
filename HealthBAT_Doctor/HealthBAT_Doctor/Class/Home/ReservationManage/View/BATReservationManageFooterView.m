//
//  BATReservationManageFooterView.m
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/17.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import "BATReservationManageFooterView.h"
#import "BATReservationManageNoticeView.h"

@implementation BATReservationManageFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
//        BATReservationManageNoticeView *preNoticeView = nil;
        for (int i = 0; i < 1; i++) {
            BATReservationManageNoticeView *noticeView = [[BATReservationManageNoticeView alloc] init];
            if (i == 0) {
                noticeView.rightLabel.text = @"已排班";
            }
            
            [self addSubview:noticeView];
            
            WEAK_SELF(self);
            [noticeView mas_makeConstraints:^(MASConstraintMaker *make) {
                STRONG_SELF(self);
                make.top.equalTo(self.mas_top).offset(15);
                make.right.equalTo(self.mas_right).offset(10);
                make.width.mas_equalTo(80);
                make.height.mas_equalTo(30);
                
//                if (i != 0) {
//                    make.left.equalTo(preNoticeView.mas_right).offset(10);
//                    make.right.equalTo(self.mas_right).offset(10);
//                }
                
            }];
//            preNoticeView = noticeView;
            
            
        }
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
