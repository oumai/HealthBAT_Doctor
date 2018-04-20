//
//  BATDoctorStudioView.h
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/15.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BATDoctorInfoHeaderView.h"

@interface BATDoctorStudioView : UIView

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) BATDoctorInfoHeaderView *headerView;

@end
