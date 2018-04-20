//
//  BATMeView.h
//  HealthBAT_Doctor
//
//  Created by cjl on 2017/5/11.
//  Copyright © 2017年 KM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BATMeHeaderView.h"

@interface BATMeView : UIView

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) BATMeHeaderView *headerView;

@end
