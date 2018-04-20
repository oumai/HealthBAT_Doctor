//
//  BATDoctorStudioMenuTableViewCell.h
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/16.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickMenuAction)(NSIndexPath *indexPath);

@interface BATDoctorStudioMenuTableViewCell : UITableViewCell

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) ClickMenuAction clickMenuAction;

@end
