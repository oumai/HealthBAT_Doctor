//
//  BATReservatonManageView.h
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/17.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BATReservationManageFooterView.h"
#import "BATReservationCountPickerView.h"
#import "BATScheduleModel.h"

typedef NS_ENUM(NSInteger,BATNextWeekType)
{
    BATNowWeek = 0,
    BATNextWeek = 1,
};

@interface BATReservationManageView : UIView

@property (nonatomic,strong) UIView *topView;

@property (nonatomic,strong) UIScrollView *scrollView;

@property (nonatomic,strong) UIView *contarinerView;

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) BATReservationManageFooterView *footerView;

@property (nonatomic,assign) NSInteger selectScheduleIndex;

@property (nonatomic,assign) NSInteger selectRegnumlistIndex;

@property (nonatomic,strong) BATReservationCountPickerView *countPickerView;

@property (nonatomic,strong) UIControl *control;

@property (nonatomic,strong) NSMutableArray *saveData;

- (void)configrationData:(BATScheduleModel *)data;

@end
