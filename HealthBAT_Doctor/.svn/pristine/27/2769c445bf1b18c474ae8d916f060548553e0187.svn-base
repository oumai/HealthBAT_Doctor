//
//  BATContractConfirmView.m
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/20.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import "BATContractConfirmView.h"

@implementation BATContractConfirmView

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
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.tableFooterView = self.footerView;
        _tableView.tableHeaderView = self.webView;
        _tableView.backgroundColor = UIColorFromHEX(0xffffff, 1);
    }
    return _tableView;
}

- (UIWebView *)webView
{
    if (_webView == nil) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    }
    return _webView;
}

- (BATContractConfirmFooterView *)footerView
{
    if (_footerView == nil) {
        _footerView = [[BATContractConfirmFooterView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 250)];
    }
    return _footerView;
}

@end
