//
//  BATMyPatientView.m
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/21.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import "BATMyPatientView.h"

@implementation BATMyPatientView

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
    [self addSubview:self.collectionView];
    
    WEAK_SELF(self);
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.edges.equalTo(self);
    }];
}

#pragma mark - get & set
//- (UITableView *)tableView
//{
//    if (_tableView == nil) {
//        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
//    }
//    return _tableView;
//}

- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = 0.5;
        layout.minimumLineSpacing = 0.5;
        layout.itemSize = CGSizeMake((SCREEN_WIDTH - 0.5) / 2, 187.5);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = BASE_BACKGROUND_COLOR;
    }
    return _collectionView;
}

@end
