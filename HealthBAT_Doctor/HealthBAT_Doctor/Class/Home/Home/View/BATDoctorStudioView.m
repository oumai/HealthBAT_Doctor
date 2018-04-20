//
//  BATDoctorStudioView.m
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/15.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import "BATDoctorStudioView.h"

@implementation BATDoctorStudioView

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
    [self addSubview:self.tableView];
    
    WEAK_SELF(self);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.edges.equalTo(self);
    }];
}

#pragma mark - get & set
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.scrollEnabled = NO;
        _tableView.tableHeaderView = self.headerView;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundColor = UIColorFromHEX(0xf8f8f8, 1);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        if (@available(iOS 11.0, *)) {
            _tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
        }
        
    }
    return _tableView;
}

- (BATDoctorInfoHeaderView *)headerView
{
    if (_headerView == nil) {
        _headerView = [[BATDoctorInfoHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - ((iPhone4 || iPad || iPadAir) ? (100 + 64) : (217 + 64)))];
    }
    return _headerView;
}

@end
