//
//  BATHealthCircleImageCollectionView.m
//  HealthBAT_Pro
//
//  Created by cjl on 16/8/24.
//  Copyright © 2016年 KMHealthCloud. All rights reserved.
//

#import "BATHealthCircleImageCollectionView.h"
#import "BATHealthCircleImageCollectionViewCell.h"
//#import "BATMomentsModel.h"
#import "SDPhotoBrowser.h"

#define itemWidth (SCREEN_WIDTH - 60.0f - 20.0f - 2 * 5) / 3
#define itemHeight itemWidth

@interface BATHealthCircleImageCollectionView () <
//UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
SDPhotoBrowserDelegate
>

/**
 *  数据源
 */
@property (nonatomic,strong) NSMutableArray *dataSource;

@end

@implementation BATHealthCircleImageCollectionView

- (void)dealloc
{
//    _collectionView.delegate = nil;
//    _collectionView.dataSource = nil;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _dataSource = [NSMutableArray array];
    
//    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    _flowLayout.minimumLineSpacing = 5;
//    _flowLayout.minimumInteritemSpacing = 5;
//    
//    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_flowLayout];
//    _collectionView.backgroundColor = [UIColor whiteColor];
//    _collectionView.delegate = self;
//    _collectionView.dataSource = self;
//    _collectionView.scrollEnabled = NO;
//    [self addSubview:_collectionView];
//    
//    [_collectionView registerNib:[UINib nibWithNibName:@"BATHealthCircleImageCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"BATHealthCircleImageCollectionViewCell"];
    
//    [self setupConstraints];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//- (void)setupConstraints
//{
//    WEAK_SELF(self);
//    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        STRONG_SELF(self);
//        make.edges.equalTo(self);
//        
//    }];
//}

#pragma mark - Action

- (void)loadImageData:(NSArray *)imageArray
{
    
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[UIImageView class]]) {
            [subView removeFromSuperview];
        }
    }
    
    [_dataSource removeAllObjects];
    
    [_dataSource addObjectsFromArray:imageArray];
    
//    [_collectionView reloadData];
    
    CGFloat imageWidth = _dataSource.count == 1 ? 120 : itemWidth;
    CGFloat imageHeight = imageWidth;
    
    CGFloat margin = 5;
    
    WEAK_SELF(self);
    [_dataSource enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        STRONG_SELF(self);
        
        long columnIndex = idx % 3;
        long rowIndex = idx / 3;
        
        NSDictionary *imgs = obj;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(columnIndex * (imageWidth + margin), rowIndex * (imageHeight + margin), imageWidth, imageHeight)];
        
        if ([imgs[@"ImageUrl"] hasPrefix:@"http://"]) {
            [imageView sd_setImageWithURL:[NSURL URLWithString:imgs[@"ImageUrl"]] placeholderImage:[UIImage imageNamed:@"icon_pictures_default"]];
        } else {
//            [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,imgs.imgs]] placeholderImage:[UIImage imageNamed:@"icon_pictures_default"]];
            [imageView sd_setImageWithURL:[NSURL URLWithString:imgs[@"ImageUrl"]] placeholderImage:[UIImage imageNamed:@"icon_pictures_default"]];
        }
        
        imageView.userInteractionEnabled = YES;
        imageView.tag = idx;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [self addSubview:imageView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
        [imageView addGestureRecognizer:tap];
        
    }];

}

#pragma mark - 图片点击
- (void)tapImageView:(UITapGestureRecognizer *)tap
{
    UIView *imageView = tap.view;
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.currentImageIndex = imageView.tag;
    browser.sourceImagesContainerView = self;
    browser.imageCount = _dataSource.count;
    browser.delegate = self;
    [browser show];
    
    [[Tools getCurrentVC].view endEditing:YES];
    
//    if (_delegate && [_delegate respondsToSelector:@selector(healthCircleImageCollectionView:imageClicked:)]) {
//        UIImageView *imageView = (UIImageView *)tap.view;
//        [_delegate healthCircleImageCollectionView:self imageClicked:imageView.tag];
//    }
}


#pragma mark - SDPhotoBrowserDelegate

- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSDictionary *imgs = _dataSource[index];
    
    if ([imgs[@"ImageUrl"] hasPrefix:@"http://"]) {
        return [NSURL URLWithString:imgs[@"ImageUrl"]];
    } else {
        return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",APP_DOMAIN_URL,imgs[@"ImageUrl"]]];
    }
    
}

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    UIImageView *imageView = self.subviews[index];
    return imageView.image;
}

//#pragma mark - UICollectionViewDataSource
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
//{
//    return 1;
//}
//
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
//{
//    return _dataSource.count;
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    BATHealthCircleImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BATHealthCircleImageCollectionViewCell" forIndexPath:indexPath];
//    
//    if (_dataSource.count > 0) {
//        BATImglist * imgs = _dataSource[indexPath.row];
//        
//        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,imgs.imgs]] placeholderImage:[UIImage imageNamed:@"icon_pictures_default"]];
//    }
//    
//    return cell;
//}
//
//#pragma mark - UICollectionViewDelegateFlowLayout
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (_dataSource.count > 1) {
//        return CGSizeMake(floor(itemWidth), floor(itemHeight));
//    }
//    return CGSizeMake(120, 120);
//}

@end
