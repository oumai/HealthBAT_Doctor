//
//  BATReservatonManageView.m
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/17.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import "BATReservationManageView.h"
#import "BATReservationManageTitleCell.h"
#import "BATReservationManageOptionCell.h"

@interface BATReservationManageView () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UILabel *slider;

@property (nonatomic,strong) BATScheduleModel *scheduleModel;

@property (nonatomic,strong) NSArray *weeks;

@property (nonatomic,strong) NSArray *times;

@property (nonatomic,assign) BATNextWeekType type;

@property (nonatomic,assign) NSIndexPath *indexPath;

@end

@implementation BATReservationManageView

- (void)dealloc
{
    _collectionView.delegate = nil;
    _collectionView.dataSource = nil;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        _saveData = [NSMutableArray array];
        
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_topView];
        
        _scrollView = [[UIScrollView alloc] init];
        [self addSubview:_scrollView];
        
        _contarinerView = [[UIView alloc] init];
        [_scrollView addSubview:_contarinerView];
        
        UIButton *preButton = nil;
        for (int i = 0 ; i < 2; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitleColor:BLUE_COLOR forState:UIControlStateSelected];
            [button setTitleColor:STRING_LIGHT_COLOR forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:15];
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = 100 + i;
            
            if (i == 0) {
                [button setTitle:@"本周" forState:UIControlStateNormal];
            } else {
                [button setTitle:@"下周" forState:UIControlStateNormal];
            }
            
            [_topView addSubview:button];
            
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(_topView);
                make.width.mas_equalTo(50);
                if (i != 0) {
                    make.left.equalTo(preButton.mas_right).offset(50);
                } else {
                    make.left.equalTo(_topView.mas_left).offset((SCREEN_WIDTH - 150) / 2);
                }
            }];
            
            if (i == 0) {
                button.selected = YES;
                _type = BATNowWeek;
                _slider = [[UILabel alloc] init];
                _slider.backgroundColor = BLUE_COLOR;
                [_topView addSubview:_slider];
                
                [_slider mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(button.mas_width);
                    make.height.mas_equalTo(2);
                    make.left.equalTo(_topView.mas_left).offset((SCREEN_WIDTH - 150) / 2);
                    make.bottom.equalTo(_topView.mas_bottom);
                }];
            }
            
            preButton = button;
        }
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 1;
        flowLayout.minimumInteritemSpacing = 1;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 1, 0);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = UIColorFromHEX(0xf6f6f6, 1);
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.layer.borderColor = UIColorFromHEX(0xf6f6f6, 1).CGColor;
        _collectionView.layer.borderWidth = 0.5f;
        _collectionView.scrollEnabled = NO;
        [_contarinerView addSubview:_collectionView];
        
        [_collectionView registerClass:[BATReservationManageTitleCell class] forCellWithReuseIdentifier:@"BATReservationManageTitleCell"];
        [_collectionView registerClass:[BATReservationManageOptionCell class] forCellWithReuseIdentifier:@"BATReservationManageOptionCell"];
        
        _footerView = [[BATReservationManageFooterView alloc] init];
        _footerView.backgroundColor = [UIColor whiteColor];
        [_contarinerView addSubview:_footerView];
        
        _control = [[UIControl alloc] init];
        _control.backgroundColor = [UIColor blackColor];
        _control.alpha = 0.5f;
        [_control addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
        [[UIApplication sharedApplication].keyWindow addSubview:_control];
        
        _countPickerView = [[BATReservationCountPickerView alloc] init];
        
        WEAK_SELF(self);
        _countPickerView.confirmBlock = ^(NSInteger value) {
            STRONG_SELF(self);
            
            [self setCellTitle:value];
            
            [self.control sendActionsForControlEvents:UIControlEventTouchUpInside];
        };
        [[UIApplication sharedApplication].keyWindow addSubview:_countPickerView];
        
        _control.hidden = YES;
        _countPickerView.hidden = YES;
        
        [self setupConstraints];
        
    }
    return self;
}

- (void)setupConstraints
{
    WEAK_SELF(self);
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.left.right.equalTo(self);
        make.top.equalTo(self.mas_top).offset(10);
        make.height.mas_equalTo(48);
    }];
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.top.equalTo(_topView.mas_bottom);
        make.left.right.bottom.equalTo(self);
    }];
    
    [_contarinerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_scrollView);
        make.width.mas_offset(SCREEN_WIDTH);
    }];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.top.equalTo(_topView.mas_bottom);
        make.top.left.right.equalTo(_contarinerView);
    }];
    
    [_footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_collectionView.mas_bottom);
        //        make.bottom.equalTo(_contarinerView.mas_bottom);
        make.left.right.bottom.equalTo(_contarinerView);
    }];
    
    [_control mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo([UIApplication sharedApplication].keyWindow);
    }];
    
    [_countPickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo([UIApplication sharedApplication].keyWindow);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH - 40, 360));
    }];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    if (_scheduleModel.Data.count > 0) {
        BATScheduleData *schedule = [_scheduleModel.Data objectAtIndex:0];
        return 1 + schedule.ScheduleTimeList.count;
    }
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger offset = 0;
    
    if (_type == BATNowWeek) {
        offset = 0;
    } else {
        offset = 1;
    }
    
    if (indexPath.section == 0) {
        BATReservationManageTitleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BATReservationManageTitleCell" forIndexPath:indexPath];
        if (indexPath.row == 0) {
            cell.titleLabel.text = @"";
        } else {
            
            if (_scheduleModel.Data.count > 0) {
                
                BATScheduleData *schedule = [_scheduleModel.Data objectAtIndex:offset];
                
                BATDataWeekData *dateWeek = schedule.DataWeekList[indexPath.row - 1];
                
                cell.titleLabel.text = [NSString stringWithFormat:@"%@\n%@",dateWeek.WeekStr,dateWeek.DateStr];
            }
        }
        return cell;
    } else {
        
        if (indexPath.row == 0) {
            BATReservationManageTitleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BATReservationManageTitleCell" forIndexPath:indexPath];
            
            if (_scheduleModel.Data.count > 0) {
                
                BATScheduleData *schedule = [_scheduleModel.Data objectAtIndex:offset];
                
                BATScheduleTimeData *scheduleTime = schedule.ScheduleTimeList[indexPath.section  - 1];
                
                cell.titleLabel.text = [NSString stringWithFormat:@"%@\n%@",scheduleTime.StartTime,scheduleTime.EndTime];
                
            }
            
            return cell;
        } else {
            BATReservationManageOptionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BATReservationManageOptionCell" forIndexPath:indexPath];
            
            
            if (_scheduleModel.Data.count > 0) {
                
                BATScheduleData *schedule = [_scheduleModel.Data objectAtIndex:offset];
                
                BATScheduleTimeData *scheduleTime = schedule.ScheduleTimeList[indexPath.section  - 1];
                
                BATScheduleItem *scheduleItem = scheduleTime.ScheduleList[indexPath.row - 1];
                

                
                if (scheduleItem.CanEdit) {
                    cell.titleLabel.hidden = NO;
                    cell.titleLabel.backgroundColor = [UIColor whiteColor];
                    
                    if (scheduleItem.YueYueMax > 0) {
                        cell.titleLabel.text = [NSString stringWithFormat:@"%ld",scheduleItem.YueYueMax];
                        cell.borderView.hidden = NO;
                    } else {
                        cell.titleLabel.text = @"";
                        cell.borderView.hidden = YES;
                    }
                    
                } else {
                    cell.titleLabel.backgroundColor = UIColorFromHEX(0xf6f6f6, 1);
                    
                    cell.titleLabel.text = @"";
                    cell.borderView.hidden = YES;
                }
            }
            
            return cell;
        }
        
    }
    return nil;
    
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"indexPath %@",indexPath);
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section != 0 && indexPath.row != 0) {
        NSInteger offset = 0;
        
        if (_type == BATNowWeek) {
            offset = 0;
        } else {
            offset = 1;
        }
        
        BATScheduleData *schedule = [_scheduleModel.Data objectAtIndex:offset];
        
        BATScheduleTimeData *scheduleTime = schedule.ScheduleTimeList[indexPath.section  - 1];
        
        BATScheduleItem *scheduleItem = scheduleTime.ScheduleList[indexPath.row - 1];
        
        _indexPath = indexPath;
        
        if (scheduleItem.CanEdit) {
            
            _countPickerView.value = 0;
            [_countPickerView.pickerView selectRow:0 inComponent:0 animated:NO];
            
            _control.hidden = !_control.hidden;
            _countPickerView.hidden = !_countPickerView.hidden;
        }
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((SCREEN_WIDTH - 7) / 8, (SCREEN_WIDTH - 7) / 8);
}

#pragma mark - Action
- (void)configrationData:(BATScheduleModel *)data
{
    _scheduleModel = data;
    
    if (_scheduleModel.Data.count > 0) {
        BATScheduleData *schedule = [_scheduleModel.Data objectAtIndex:0];
        
        //设置collectionView大小
        float collectionHeight = (SCREEN_WIDTH - 7) / 8 * (1 + schedule.ScheduleTimeList.count) + ((1 + schedule.ScheduleTimeList.count) * 1);
        [_collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(collectionHeight);
        }];
        
        [_contarinerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(collectionHeight + 50);
        }];
    }
    

    
    [_collectionView reloadData];
}

- (void)setCellTitle:(NSInteger)value
{
    
    NSInteger offset = 0;
    
    if (_type == BATNowWeek) {
        offset = 0;
    } else {
        offset = 1;
    }
    
    BATScheduleData *schedule = [_scheduleModel.Data objectAtIndex:offset];
    
    BATScheduleTimeData *scheduleTime = schedule.ScheduleTimeList[_indexPath.section  - 1];
    
    BATScheduleItem *scheduleItem = scheduleTime.ScheduleList[_indexPath.row - 1];
    
    scheduleItem.YueYueMax = value;
    
    
    [scheduleTime.ScheduleList replaceObjectAtIndex:_indexPath.row - 1 withObject:scheduleItem];
    
    if (![_saveData containsObject:scheduleItem]) {
        [_saveData addObject:scheduleItem];
    }
    
    
    [self.collectionView reloadData];
    
}

- (void)buttonAction:(UIButton *)button
{
    //重置button状态
    for (UIView *subView in _topView.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)subView;
            btn.selected = NO;
        }
    }
    
    button.selected = YES;
    
    //设置当前显示的分栏
    if (button.tag == 100) {
        _type = BATNowWeek;
    } else {
        _type = BATNextWeek;
    }
    
    //更新滑块
    [_slider mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topView.mas_left).offset(button.frame.origin.x);
    }];
    
    
    [UIView animateWithDuration:0.5f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [_topView setNeedsLayout];
        [_topView layoutIfNeeded];
    } completion:nil];
    
    [_collectionView reloadData];
}

- (void)controlAction:(UIControl *)control
{
    _control.hidden = !_control.hidden;
    _countPickerView.hidden = !_countPickerView.hidden;
}

@end
