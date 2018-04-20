//
//  BATMyPatientViewController.m
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/21.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import "BATMyPatientViewController.h"
#import "BATMyPatientTableViewCell.h"
#import "BATMyPatientSectionHeaderView.h"
#import "BATMyPatientModel.h"
#import "BATPatientDetailViewController.h"
#import "BATMyPatientCollectionViewCell.h"

@interface BATMyPatientViewController () <
//UITableViewDelegate,UITableViewDataSource,
UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) NSMutableArray *dataSource;

@property (nonatomic,assign) NSInteger pageSize;

@property (nonatomic,assign) NSInteger pageIndex;

@property (nonatomic,strong) BATDefaultView *defaultView;

/**
 判断数据请求完成
 */
@property (nonatomic,assign) BOOL isCompleteRequest;


@end

@implementation BATMyPatientViewController

- (void)dealloc
{
    DDLogDebug(@"%@", self);
}

- (void)loadView
{
    [super loadView];
    
    [self pageLayout];
    
    self.title = @"我的患者";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _pageSize = 10;
    _pageIndex = 0;
    _dataSource = [NSMutableArray array];
    
//    [self.myPatientView.tableView registerClass:[BATMyPatientTableViewCell class] forCellReuseIdentifier:@"BATMyPatientTableViewCell"];
//    
//    [self.myPatientView.tableView.mj_header beginRefreshing];
    
    [self.myPatientView.collectionView registerClass:[BATMyPatientCollectionViewCell class] forCellWithReuseIdentifier:@"BATMyPatientCollectionViewCell"];
    
    [self.myPatientView.collectionView.mj_header beginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UICollectionDataSource
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
    BATMyPatientCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BATMyPatientCollectionViewCell" forIndexPath:indexPath];
    
    if (_dataSource.count > 0) {
        
        BATPatientItem *item = _dataSource[indexPath.row];
        
//        BATPatientItem *item = data.PatientList[indexPath.row];
        
        [cell.avatarImageView sd_setImageWithURL:[NSURL URLWithString:item.PhotoPath] placeholderImage:[UIImage imageNamed:@"personalCenter_defaultAvator"]];
        cell.nameLabel.text = item.TrueName;
        cell.sexLabel.text = item.Sex == 0 ? @"女" : @"男";
        cell.ageLabel.text = [NSString stringWithFormat:@"%ld岁",item.Age];
        cell.isFamilyService = item.IsFamilyService;
        cell.isExpire = item.IsExpire;
    }
    
    return cell;
}

#pragma mark - UICollectionDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_dataSource.count > 0) {
        BATPatientDetailViewController *patientDetailVC = [[BATPatientDetailViewController alloc] init];
        
        BATPatientItem *item = _dataSource[indexPath.row];
        
//        BATPatientItem *item = data.PatientList[indexPath.row];
        
        patientDetailVC.patientID = item.AccountID;
        
        patientDetailVC.title = item.TrueName;
        
        patientDetailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:patientDetailVC animated:YES];
    }
}

/*
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    BATMyPatientData *data = _dataSource[section];
    
    return data.PatientList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    BATMyPatientSectionHeaderView *sectionHeaderView = [[BATMyPatientSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    
    if (_dataSource.count > 0) {
        
        BATMyPatientData *data = _dataSource[section];
        
        sectionHeaderView.sectionIndexLabel.text = data.GroupName;
    }
    
    return sectionHeaderView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BATMyPatientTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BATMyPatientTableViewCell" forIndexPath:indexPath];
    
    if (_dataSource.count > 0) {
        
        BATMyPatientData *data = _dataSource[indexPath.section];
        
        BATPatientItem *item = data.PatientList[indexPath.row];
        
        [cell.avatarImageView sd_setImageWithURL:[NSURL URLWithString:item.PhotoPath] placeholderImage:[UIImage imageNamed:@"personalCenter_defaultAvator"]];
        cell.nameLabel.text = item.TrueName;
        cell.sexLabel.text = item.Sex == 0 ? @"女" : @"男";
        cell.ageLabel.text = [NSString stringWithFormat:@"%ld岁",item.Age];
        cell.isFamilyService = item.IsFamilyService;
        cell.isExpire = item.IsExpire;
    }
    

    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_dataSource.count > 0) {
        BATPatientDetailViewController *patientDetailVC = [[BATPatientDetailViewController alloc] init];
        
        BATMyPatientData *data = _dataSource[indexPath.section];
        
        BATPatientItem *item = data.PatientList[indexPath.row];
        
        patientDetailVC.patientID = item.AccountID;
        
        patientDetailVC.title = item.TrueName;
        
        patientDetailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:patientDetailVC animated:YES];
    }
}
*/
 
#pragma mark - Net
- (void)requestGetPatients
{
    [HTTPTool requestWithURLString:@"/api/Doctor/GetPatients" parameters:@{@"doctorID":self.DoctorID,@"pageIndex":@(_pageIndex),@"pageSize":@(_pageSize)} type:kGET success:^(id responseObject) {
        
        WEAK_SELF(self);
        [self.myPatientView.collectionView.mj_header endRefreshingWithCompletionBlock:^{
            STRONG_SELF(self);
            self.isCompleteRequest = YES;
            [self.myPatientView.collectionView reloadData];
        }];
        [self.myPatientView.collectionView.mj_footer endRefreshing];
        
        if (_pageIndex == 0) {
            [self.dataSource removeAllObjects];
        }
        
        BATMyPatientModel *model = [BATMyPatientModel mj_objectWithKeyValues:responseObject];
        
        [self.dataSource addObjectsFromArray:model.Data];
        
        if (model.RecordsCount > 0) {
            self.myPatientView.collectionView.mj_footer.hidden = NO;
        } else {
            self.myPatientView.collectionView.mj_footer.hidden = YES;
        }
        
        if (self.dataSource.count == model.RecordsCount) {
            //            [self.batOnlineLearningView.tableView.mj_footer endRefreshingWithNoMoreData];
            self.myPatientView.collectionView.mj_footer.hidden = YES;
        }
        
        [self.myPatientView.collectionView reloadData];
        
        
        if(self.dataSource.count == 0){
            [self.defaultView showDefaultView];
        }
        
//        WEAK_SELF(self);
//        [self.myPatientView.collectionView.mj_header endRefreshingWithCompletionBlock:^{
//            STRONG_SELF(self);
//            self.isCompleteRequest = YES;
//            [self.myPatientView.collectionView reloadData];
//        }];
//        [self.myPatientView.collectionView.mj_footer endRefreshing];
//        
//        [_dataSource removeAllObjects];
//
//        
//        BATMyPatientModel *myPatientModel = [BATMyPatientModel mj_objectWithKeyValues:responseObject];
//        
//        [_dataSource addObjectsFromArray:myPatientModel.Data];
//        
//        
//        [self.myPatientView.collectionView reloadData];
//        
//        if(_dataSource.count == 0){
//            [self.defaultView showDefaultView];
//        }

        
    } failure:^(NSError *error) {
        [self showErrorWithText:error.localizedDescription];
        
        WEAK_SELF(self);
        [self.myPatientView.collectionView.mj_header endRefreshingWithCompletionBlock:^{
            STRONG_SELF(self);
            self.isCompleteRequest = YES;
            [self.myPatientView.collectionView reloadData];
        }];
        [self.myPatientView.collectionView.mj_footer endRefreshing];
        _pageIndex--;
        if (_pageIndex < 0) {
            _pageIndex = 0;
        }
        
        [self.defaultView showDefaultView];
        
//        [self showErrorWithText:error.localizedDescription];
//        WEAK_SELF(self);
//        [self.myPatientView.collectionView.mj_header endRefreshingWithCompletionBlock:^{
//            STRONG_SELF(self);
//            self.isCompleteRequest = YES;
//            [self.myPatientView.collectionView reloadData];
//        }];
//
//        [self.defaultView showDefaultView];
        
    }];
}

#pragma mark - pageLayout
- (void)pageLayout
{
    [self.view addSubview:self.myPatientView];
    
    WEAK_SELF(self);
    [self.myPatientView mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.edges.equalTo(self.view);
    }];
    
    [self.view addSubview:self.defaultView];
    [self.defaultView mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.bottom.right.left.top.equalTo(self.view);
    }];
}

#pragma mark - get & set
- (BATMyPatientView *)myPatientView
{
    if (_myPatientView == nil) {
        _myPatientView = [[BATMyPatientView alloc] init];
        _myPatientView.collectionView.delegate = self;
        _myPatientView.collectionView.dataSource = self;
        
        WEAK_SELF(self);
        _myPatientView.collectionView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
            STRONG_SELF(self);
            [self.myPatientView.collectionView.mj_footer resetNoMoreData];
            self.pageIndex = 0;
            [self requestGetPatients];
        }];
        
        _myPatientView.collectionView.mj_footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
            STRONG_SELF(self);
            self.pageIndex ++;
            [self requestGetPatients];
        }];
        
        _myPatientView.collectionView.mj_footer.hidden = YES;
    }
    return _myPatientView;
}

- (BATDefaultView *)defaultView{
    if (!_defaultView) {
        _defaultView = [[BATDefaultView alloc]initWithFrame:CGRectZero];
        _defaultView.hidden = YES;
        WEAK_SELF(self);
        [_defaultView setReloadRequestBlock:^{
            STRONG_SELF(self);
            DDLogInfo(@"=====重新开始加载！=====");
            self.defaultView.hidden = YES;
            [self requestGetPatients];
        }];
        
    }
    return _defaultView;
}

@end
