//
//  ChangePasswordViewController.m
//  HealthBAT_Pro
//
//  Created by Skyrim on 16/7/27.
//  Copyright © 2016年 KMHealthCloud. All rights reserved.
//

#import "BATChangePasswordViewController.h"
#import "BATAppDelegate+BATResetLogin.h"

#import "BATLoginModel.h"
#import "BATBaseModel.h"

@interface BATChangePasswordViewController ()<UITextFieldDelegate>

@property (nonatomic,strong) UIImageView *topImageView;
@property (nonatomic,strong) UITextField *oldPasswordTF;
@property (nonatomic,strong) UITextField *passwordTF;
@property (nonatomic,strong) UITextField *confirmPasswordTF;
@property (nonatomic,strong) UIButton    *changeButton;

@end

@implementation BATChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self pagesLayout];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    
    WEAK_SELF(self);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] bk_initWithBarButtonSystemItem:UIBarButtonSystemItemStop handler:^(id sender) {
        STRONG_SELF(self);
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    [self.view endEditing:YES];
    return YES;
}

#pragma mark - 判断内容是否正确
-(void)checkContent{

    [self.view endEditing: YES];
    //判断输入框是否为空。(即无输入)

    if (self.oldPasswordTF.text.length == 0) {
        [self showErrorWithText:@"请输入旧密码"];
        return;
    }
    
    if (self.passwordTF.text.length == 0) {
        [self showErrorWithText:@"请输入新密码"];
        return;
    } else if(self.passwordTF.text.length > 16 || self.passwordTF.text.length < 6){
        [self showErrorWithText:@"密码输入错误，长度为6~16位的数字与字母组合"];
        return;
    } else if ([self.passwordTF.text rangeOfString:@" "].location != NSNotFound) {
        [self showErrorWithText:@"密码中不能包含空格"];
        return;
    }
    
    if (self.confirmPasswordTF.text.length == 0) {
        [self showErrorWithText:@"请确认新密码"];
        return;
    }

    if ([self.oldPasswordTF.text isEqualToString:self.passwordTF.text]) {
        [self showErrorWithText:@"新密码与旧密码相同"];
        return;
    }

    if (![self.confirmPasswordTF.text isEqualToString:self.passwordTF.text]) {
        [self showErrorWithText:@"两次密码不一致，请重新输入"];
        return;
    }

    [self changePassWordResquest];
}

#pragma mark - NET
-(void)changePassWordResquest {
    
    self.navigationItem.leftBarButtonItem.enabled = NO;
    NSString *file = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/UserLogin.data"];
    BATLoginModel * login = [NSKeyedUnarchiver unarchiveObjectWithFile:file];

    NSDictionary * para = @{
                            @"AccountID":@(login.Data.ID),
                            @"OldPassword":self.oldPasswordTF.text,
                            @"NewPassword":self.passwordTF.text,
                            @"ConfirmPassword":self.confirmPasswordTF.text
                            };

    [HTTPTool requestWithURLString:@"/api/Account/ChangePassword" parameters:para type:kPOST success:^(id responseObject) {
        BATBaseModel * success = [BATBaseModel mj_objectWithKeyValues:responseObject];
        if (success.ResultCode == 0) {
            [self showSuccessWithText:@"修改成功" completion:^{
                self.navigationItem.leftBarButtonItem.enabled = YES;
                [self dismissViewControllerAnimated:NO completion:nil];
                
                BATAppDelegate *delegate = (BATAppDelegate *)[UIApplication sharedApplication].delegate;
                [delegate bat_logout];
            }];
        }
    } failure:^(NSError *error) {
        self.navigationItem.leftBarButtonItem.enabled = YES;
        [self showErrorWithText:error.localizedDescription];
    }];

}

#pragma mark - layout
- (void)pagesLayout {
    
    /**
     *  判断手机型号，调整整体布局
     */
    CGFloat lineSpa;
    CGFloat height;
    if (iPhone4) {
        lineSpa = 7;
        height = 35;
    }else if(iPhone5){
        lineSpa = 10;
        height = 40;
    }else if(iPhone6){
        lineSpa = 15;
        height = 45;
    }else if(iPhone6p){
        lineSpa = 20;
        height = 50;
    }else {
        lineSpa = 20;
        height = 50;
    }
    
    WEAK_SELF(self);
    [self.view addSubview:self.topImageView];
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(64+20);
        
    }];
    
    [self.view addSubview:self.oldPasswordTF];
    [self.oldPasswordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(SCREEN_WIDTH-45);
        make.top.equalTo(self.topImageView.mas_bottom).offset(3*lineSpa);
        make.height.mas_equalTo(height);
    }];
    
    //旧密码下划线
    UIView *oldPasswordLine = [[UIView alloc]init];
    oldPasswordLine.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:oldPasswordLine];
    [oldPasswordLine mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        
        make.top.equalTo(self.oldPasswordTF.mas_bottom).offset(1);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(0.5);
        make.width.mas_equalTo(SCREEN_WIDTH-50);
    }];

    
    [self.view addSubview:self.passwordTF];
    [self.passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(SCREEN_WIDTH-45);
        make.top.equalTo(self.oldPasswordTF.mas_bottom).offset(lineSpa);
        make.height.mas_equalTo(height);
    }];
    
    //新密码下划线
    UIView *passwordTFLine = [[UIView alloc]init];
    passwordTFLine.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:passwordTFLine];
    [passwordTFLine mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        
        make.top.equalTo(self.passwordTF.mas_bottom).offset(1);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(0.5);
        make.width.mas_equalTo(SCREEN_WIDTH-50);
    }];

    
    [self.view addSubview:self.confirmPasswordTF];
    [self.confirmPasswordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(SCREEN_WIDTH-45);
        make.top.equalTo(self.passwordTF.mas_bottom).offset(lineSpa);
        make.height.mas_equalTo(height);
    }];

    //确认密码下划线
    UIView *confirmPasswordTFLine = [[UIView alloc]init];
    confirmPasswordTFLine.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:confirmPasswordTFLine];
    [confirmPasswordTFLine mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        
        make.top.equalTo(self.confirmPasswordTF.mas_bottom).offset(1);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(0.5);
        make.width.mas_equalTo(SCREEN_WIDTH-50);
    }];

    [self.view addSubview:self.changeButton];
    [self.changeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(SCREEN_WIDTH-45);
        make.top.equalTo(self.confirmPasswordTF.mas_bottom).offset(3*lineSpa);
        make.height.mas_equalTo(height);
    }];
}

#pragma mark - setter && getter
- (UIImageView *)topImageView {
    if (!_topImageView) {
        _topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_login_logo"]];
        _topImageView.layer.cornerRadius = 7.0f;
        _topImageView.clipsToBounds = YES;
    }
    return _topImageView;
}


- (UITextField *)oldPasswordTF {
    if (!_oldPasswordTF) {
        _oldPasswordTF = [UITextField textFieldWithfont:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] placeholder:@"请输入旧密码" BorderStyle:UITextBorderStyleNone];
        _oldPasswordTF.secureTextEntry = YES;
    }
    return _oldPasswordTF;
}

- (UITextField *)passwordTF {
    if (!_passwordTF) {
        _passwordTF = [UITextField textFieldWithfont:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] placeholder:@"请输入新密码(长度为6~18位的数字与字母组合)" BorderStyle:UITextBorderStyleNone];
        _passwordTF.secureTextEntry = YES;

    }
    return _passwordTF;
}

- (UITextField *)confirmPasswordTF {
    if (!_confirmPasswordTF) {
        _confirmPasswordTF = [UITextField textFieldWithfont:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] placeholder:@"确认密码" BorderStyle:UITextBorderStyleNone];
        _confirmPasswordTF.secureTextEntry = YES;
        _confirmPasswordTF.delegate = self;
        _confirmPasswordTF.returnKeyType = UIReturnKeyDone;
    }
    return _confirmPasswordTF;
}

- (UIButton *)changeButton {
    if (!_changeButton) {
        _changeButton = [UIButton buttonWithType:UIButtonTypeCustom Title:@"确认" titleColor:[UIColor whiteColor] backgroundColor:BASE_COLOR backgroundImage:nil Font:[UIFont systemFontOfSize:17]];
        [_changeButton addTarget:self action:@selector(checkContent) forControlEvents:UIControlEventTouchUpInside];
        _changeButton.layer.cornerRadius = 5.0f;
    }
    return _changeButton;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
