//
//  BATServiceTableViewCell.m
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/16.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import "BATServiceTableViewCell.h"
#import "BATServiceItemCell.h"

@interface BATServiceTableViewCell () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) NSMutableArray *dataSource;

@property (nonatomic,strong) BATServiceSettingModel *serviceSettingModel;

@end

@implementation BATServiceTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _dataSource = [NSMutableArray arrayWithObjects:
                       @{@"nomal":[UIImage imageNamed:@"ic-spzx"],@"select":[UIImage imageNamed:@"ic-spzx_select"],@"name":@"视频咨询"},
                       @{@"nomal":[UIImage imageNamed:@"ic-yyzx"],@"select":[UIImage imageNamed:@"ic-yyzx_select"],@"name":@"语音咨询"},
                       @{@"nomal":[UIImage imageNamed:@"ic-twzx"],@"select":[UIImage imageNamed:@"ic-twzx_select"],@"name":@"图文咨询"},
                       @{@"nomal":[UIImage imageNamed:@"ic-smfw"],@"select":[UIImage imageNamed:@"ic-smfw_select"],@"name":@"上门服务"},nil];
        
        [self pageLayout];
        
        [self.collectionView registerClass:[BATServiceItemCell class] forCellWithReuseIdentifier:@"BATServiceItemCell"];
        
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

- (void)configData:(BATServiceSettingModel *)serviceSettingModel
{
    self.serviceSettingModel = serviceSettingModel;
    
    [self.collectionView reloadData];
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
    BATServiceItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BATServiceItemCell" forIndexPath:indexPath];
    
    NSDictionary *dic = _dataSource[indexPath.row];
    
    
    if (self.serviceSettingModel.Data.FamilyServiceList.count > 0) {
        BATFamilyServiceItem *item = self.serviceSettingModel.Data.FamilyServiceList[indexPath.row];
        
        [cell configData:dic select:item.TValue];
    }
    

    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.familyServiceClick) {
        if (self.serviceSettingModel.Data.FamilyServiceList.count > 0) {
            BATFamilyServiceItem *item = self.serviceSettingModel.Data.FamilyServiceList[indexPath.row];
            self.familyServiceClick(indexPath.row,item.TKey,!item.TValue);
        }
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_WIDTH/ 4, 100);
}

- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority
{
    self.collectionView.frame = CGRectMake(0, 0, targetSize.width, MAXFLOAT);
    return [self.collectionView.collectionViewLayout collectionViewContentSize];
}


#pragma mark - pageLayout
- (void)pageLayout
{
    
    [self.contentView addSubview:self.collectionView];
    
    WEAK_SELF(self);
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.edges.equalTo(self.contentView);
    }];
    
}

#pragma mark - get & set

- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.scrollEnabled = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
    }
    return _collectionView;
}

@end
