//
//  BATSettingView.m
//  HealthBAT_Doctor
//
//  Created by cjl on 2017/5/11.
//  Copyright © 2017年 KM. All rights reserved.
//

#import "BATSettingView.h"

@implementation BATSettingView

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

#pragma mark - Action
- (void)loginOut
{
    if (self.logoutBlock) {
        self.logoutBlock();
    }
}

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
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        UIView *tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
        
        UIButton *loginOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        loginOutBtn.frame = CGRectMake(10,34, SCREEN_WIDTH - 20, 40);
        loginOutBtn.backgroundColor = BLUE_COLOR;
        [loginOutBtn addTarget:self action:@selector(loginOut) forControlEvents:UIControlEventTouchUpInside];
        loginOutBtn.layer.cornerRadius = 6.0f;
        [loginOutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        [tableFooterView addSubview:loginOutBtn];
        
        _tableView.tableFooterView = tableFooterView;
        
    }
    return _tableView;
}

@end
