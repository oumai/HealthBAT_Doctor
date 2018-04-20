//
//  BATDoctorStudioMenuTableViewCell.m
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/16.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import "BATDoctorStudioMenuTableViewCell.h"
#import "BATDoctorStudioMenuItemCell.h"

@interface BATDoctorStudioMenuTableViewCell () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) NSMutableArray *dataSource;

@end

@implementation BATDoctorStudioMenuTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundView = nil;
        self.backgroundColor = [UIColor clearColor];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _dataSource = [NSMutableArray arrayWithObjects:
                       @{@"image":[UIImage imageNamed:@"ic-wdzs"],@"name":@"我的诊室"},
                       @{@"image":[UIImage imageNamed:@"ic-wdhz"],@"name":@"我的患者"},
                       @{@"image":[UIImage imageNamed:@"ic-yygl"],@"name":@"预约管理"},
                       @{@"image":[UIImage imageNamed:@"home-ic-ysq"],@"name":@"医生圈"},
//                       @{@"image":[UIImage imageNamed:@"ic-ddgl"],@"name":@"订单管理"},
//                       @{@"image":[UIImage imageNamed:@"ic-fwsz"],@"name":@"服务设置"},
                       //@{@"image":[UIImage imageNamed:@"ic-tjhz"],@"name":@"添加患者"},
                       //@{@"image":[UIImage imageNamed:@"ic-grxx"],@"name":@"个人信息"},
                       nil];
        
        [self pageLayout];
        
        [self.collectionView registerClass:[BATDoctorStudioMenuItemCell class] forCellWithReuseIdentifier:@"BATDoctorStudioMenuItemCell"];
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BATDoctorStudioMenuItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BATDoctorStudioMenuItemCell" forIndexPath:indexPath];
    
    NSDictionary *dic = _dataSource[indexPath.row];
    
    [cell configData:dic];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.clickMenuAction) {
        self.clickMenuAction(indexPath);
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((SCREEN_WIDTH - 50) / 4, (iPhone4 || iPad || iPadAir) ? 100 : 217);
}

- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority
{
    self.collectionView.frame = CGRectMake(0, 0, targetSize.width, MAXFLOAT);
    return [self.collectionView.collectionViewLayout collectionViewContentSize];
}

#pragma makr - Layout
- (void)pageLayout
{
    [self.contentView addSubview:self.collectionView];
    
    WEAK_SELF(self);
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.edges.equalTo(self.contentView);
    }];
}

#pragma mark - get&set
- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
//        flowLayout.sectionInset = UIEdgeInsetsMake(0, 25, 0, 25);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.scrollEnabled = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
    }
    return _collectionView;
}


@end
