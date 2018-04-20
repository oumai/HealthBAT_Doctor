//
//  BATAuthenticateView.m
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/15.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import "BATAuthenticateView.h"
#import "YYText.h"

@implementation BATAuthenticateView

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
//    [self addSubview:self.sexPickerView];
//    [self addSubview:self.titlePickerView];
    
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
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _tableView.tableFooterView = self.footerView;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    }
    return _tableView;
}


- (BATSexInputPickerView *)sexInputPickerView
{
    if (!_sexInputPickerView) {
        _sexInputPickerView = [[BATSexInputPickerView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 64, SCREEN_WIDTH, 256)];
        WEAK_SELF(self);
        _sexInputPickerView.cancelBlcok = ^(){
            STRONG_SELF(self);
            [self endEditing:YES];
        };
    }
    return _sexInputPickerView;
}

- (BATTitlePickerView *)titlePickerView
{
    if (!_titlePickerView) {
        _titlePickerView = [[BATTitlePickerView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 64, SCREEN_WIDTH, 256)];
        WEAK_SELF(self);
        _titlePickerView.cancelBlcok = ^(){
            STRONG_SELF(self);
            [self endEditing:YES];
        };
    }
    return _titlePickerView;
}

- (BATDepartmentPickerView *)departmentPickerView
{
    if (!_departmentPickerView) {
        _departmentPickerView = [[BATDepartmentPickerView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 64, SCREEN_WIDTH, 256)];
        WEAK_SELF(self);
        _departmentPickerView.cancelBlcok = ^(){
            STRONG_SELF(self);
            [self endEditing:YES];
        };
    }
    return _departmentPickerView;
}

- (BATAuthenticateFooterView *)footerView
{
    if (_footerView == nil) {
        _footerView = [[BATAuthenticateFooterView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 250)];
        
    }
    return _footerView;
}

@end
