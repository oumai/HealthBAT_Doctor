//
//  BATAuthenticateResultViewController.m
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/16.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import "BATAuthenticateResultViewController.h"
#import "BATAuthenticateViewController.h"

@interface BATAuthenticateResultViewController ()

@end

@implementation BATAuthenticateResultViewController

- (void)dealloc
{
    DDLogDebug(@"%@", self);
}

- (void)loadView
{
    [super loadView];
    
    [self pageLayout];
    
    self.title = @"医生认证";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

#pragma mark - pageLayout
- (void)pageLayout
{
    [self.view addSubview:self.authenticateResultView];
    
    WEAK_SELF(self);
    [self.authenticateResultView mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - get & set
- (BATAuthenticateResultView *)authenticateResultView
{
    if (_authenticateResultView == nil) {
        _authenticateResultView = [[BATAuthenticateResultView alloc] init];
        
        WEAK_SELF(self);
        _authenticateResultView.resetBlock = ^(){
            STRONG_SELF(self);
            BATAuthenticateViewController *authenticateVC = [[BATAuthenticateViewController alloc] init];
            authenticateVC.isFromResult = YES;
            authenticateVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:authenticateVC animated:YES];
        };
    }
    return _authenticateResultView;
}

@end
