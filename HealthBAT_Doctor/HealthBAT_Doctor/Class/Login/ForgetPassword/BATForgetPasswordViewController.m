//
//  BATForgetPasswordViewController.m
//  HealthBAT_Pro
//
//  Created by KM on 16/8/242016.
//  Copyright © 2016年 KMHealthCloud. All rights reserved.
//

#import "BATForgetPasswordViewController.h"
#import "BATImageTextField.h"

@interface BATForgetPasswordViewController ()<UITextFieldDelegate>

@property (nonatomic,strong) UIImageView *topImageView;
@property (nonatomic,strong) BATImageTextField *phoneTF;
@property (nonatomic,strong) BATImageTextField *codeTF;
@property (nonatomic,strong) UIButton *countdownButton;
@property (nonatomic,strong) BATImageTextField *passwordTF;
//@property (nonatomic,strong) UITextField *confirmPasswordTF;
@property (nonatomic,strong) UIButton *confirmButton;

@end

@implementation BATForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    [self layoutPages];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    
    
//    WEAK_SELF(self);
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] bk_initWithBarButtonSystemItem:UIBarButtonSystemItemStop handler:^(id sender) {
//        STRONG_SELF(self);
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }];
    
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

#pragma mark - action
-(void)checkValue {

    [self.view endEditing: YES];
    //判断输入框是否为空。(即无输入)
    if (self.phoneTF.rightTF.text.length == 0) {
        [self showText:@"请输入手机号"];
        return;
    }
    
    //判断输入的手机号码是否符合规范
    if (![Tools checkPhoneNumber:self.phoneTF.rightTF.text]) {
        [self showText:@"请输入正确的手机号"];
        return;
    }
    
    
    if (self.codeTF.rightTF.text.length == 0) {
        [self showText:@"请输入验证码"];
        return;
    }
    if (self.passwordTF.rightTF.text.length == 0) {
        [self showText:@"请输入密码"];
        return;
    }
    
    if(self.passwordTF.rightTF.text.length > 16){
        [self showText:@"密码过长，请重新输入"];
        return;
    }
    if(self.passwordTF.rightTF.text.length < 6){
        [self showText:@"密码过短，请重新输入"];
        return;
    }
    
    if ([self.passwordTF.rightTF.text rangeOfString:@" "].location != NSNotFound) {
        [self showText:@"密码中不能包含空格"];
        return;
    }
    
    [self forgetPasswordRequest];
}

#pragma mark - net
- (void)codeRequest {

    //判断输入的手机号码是否符合规范
    if (![Tools checkPhoneNumber:self.phoneTF.rightTF.text]) {
        [self showText:@"请输入正确的手机号码"];
        return;
    }

    [self showProgress];

    [HTTPTool requestWithURLString:[NSString stringWithFormat:@"/api/Account/SendVerifyCode/%@/2",self.phoneTF.rightTF.text] parameters:nil type:kGET success:^(id responseObject) {

        [self dismissProgress];
        
        //创建获取验证码的定时器
        self.countdownButton.userInteractionEnabled = NO;
        self.countdownButton.backgroundColor = [UIColor clearColor];
        [self.countdownButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [Tools countdownWithTime:120 End:^{
            [self.countdownButton setTitle:@"获取验证码" forState:UIControlStateNormal];
            [self.countdownButton setTitleColor:BASE_COLOR forState:UIControlStateNormal];
            self.countdownButton.userInteractionEnabled = YES;
        } going:^(NSString *time) {
            [self.countdownButton setTitle:time forState:UIControlStateNormal];
        }];
    } failure:^(NSError *error) {
        [self showErrorWithText:[error localizedDescription]];
    }];
}

- (void)forgetPasswordRequest {

//    NSDictionary *para = @{@"VerifyCode":self.codeTF.text,@"NewPassword":self.passwordTF.text,@"ConfirmPassword":self.confirmPasswordTF.text,@"PhoneNumber":self.phoneTF.text};
    
    NSDictionary *para = @{@"VerifyCode":self.codeTF.rightTF.text,@"NewPassword":self.passwordTF.rightTF.text,@"PhoneNumber":self.phoneTF.rightTF.text};
    //
    ///api/Account/ChangePassword
    [HTTPTool requestWithURLString:@"/api/account/forgetchangepassword" parameters:para type:kPOST success:^(id responseObject) {
        [self showText:@"修改成功"];
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSError *error) {
        [self showErrorWithText:[error localizedDescription]];
    }];
}

#pragma mark - layout
- (void)layoutPages {

    /**
     *  判断手机型号，调整整体布局
     */
//    CGFloat lineSpa;
//    CGFloat height;
//    if (iPhone4) {
//        lineSpa = 7;
//        height = 35;
//    }
//    else if(iPhone5){
//        lineSpa = 10;
//        height = 40;
//    }else if(iPhone6){
//        lineSpa = 15;
//        height = 45;
//    }else if(iPhone6p){
//        lineSpa = 20;
//        height = 50;
//    }else{
//        lineSpa = 20;
//        height = 50;
//    }
//    
    WEAK_SELF(self);
    [self.view addSubview:self.topImageView];
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(64+20);
        
    }];
    
    [self.view addSubview:self.phoneTF];
    [self.phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(SCREEN_WIDTH-45);
        make.top.equalTo(self.topImageView.mas_bottom).offset(65);
        make.height.mas_equalTo(59);
    }];
    
    //手机号下划线
    UIView *phoneTFLine = [[UIView alloc]init];
    phoneTFLine.backgroundColor = BASE_LINECOLOR;
    [self.view addSubview:phoneTFLine];
    [phoneTFLine mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        
        make.top.equalTo(self.phoneTF.mas_bottom).offset(1);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(0.5);
        make.width.mas_equalTo(SCREEN_WIDTH-50);
    }];
    
    [self.view addSubview:self.countdownButton];
    [self.countdownButton mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        
        make.right.equalTo(self.view.mas_right).offset(-22.5);
        make.top.equalTo(self.phoneTF.mas_bottom).offset(20);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(59);
    }];
    
    //验证码分割线
    UIView *codeCutLine = [[UIView alloc]init];
    codeCutLine.backgroundColor = BASE_LINECOLOR;
    [self.view addSubview:codeCutLine];
    [codeCutLine mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        
        make.right.equalTo(self.countdownButton.mas_left).offset(-1);
        make.centerY.equalTo(self.countdownButton.mas_centerY);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(1);
    }];
    
    [self.view addSubview:self.codeTF];
    [self.codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        
        make.left.equalTo(self.view.mas_left).offset(22.5);
        make.top.equalTo(self.phoneTF.mas_bottom).offset(20);
        make.right.equalTo(codeCutLine.mas_left).offset(-20);
        make.height.mas_equalTo(59);
    }];
    
    //验证码下划线
    UIView *codeTFLine = [[UIView alloc]init];
    codeTFLine.backgroundColor = BASE_LINECOLOR;
    [self.view addSubview:codeTFLine];
    [codeTFLine mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        
        make.top.equalTo(self.codeTF.mas_bottom).offset(1);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(0.5);
        make.width.mas_equalTo(SCREEN_WIDTH-50);
    }];
    
    [self.view addSubview:self.passwordTF];
    [self.passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(SCREEN_WIDTH-45);
        make.top.equalTo(self.codeTF.mas_bottom).offset(20);
        make.height.mas_equalTo(59);
    }];
    
    //密码下划线
    UIView *passwordTFLine = [[UIView alloc]init];
    passwordTFLine.backgroundColor = BASE_LINECOLOR;
    [self.view addSubview:passwordTFLine];
    [passwordTFLine mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        
        make.top.equalTo(self.passwordTF.mas_bottom).offset(1);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(0.5);
        make.width.mas_equalTo(SCREEN_WIDTH-50);
    }];
    
//    [self.view addSubview:self.confirmPasswordTF];
//    [self.confirmPasswordTF mas_makeConstraints:^(MASConstraintMaker *make) {
//        STRONG_SELF(self);
//        
//        make.centerX.equalTo(self.view.mas_centerX);
//        make.width.mas_equalTo(SCREEN_WIDTH-45);
//        make.top.equalTo(self.passwordTF.mas_bottom).offset(lineSpa);
//        make.height.mas_equalTo(height);
//    }];
//    
//    //确认密码下划线
//    UIView *surePasswordTFLine = [[UIView alloc]init];
//    surePasswordTFLine.backgroundColor = BASE_LINECOLOR;
//    [self.view addSubview:surePasswordTFLine];
//    [surePasswordTFLine mas_makeConstraints:^(MASConstraintMaker *make) {
//        STRONG_SELF(self);
//        
//        make.top.equalTo(self.confirmPasswordTF.mas_bottom).offset(1);
//        make.centerX.equalTo(self.view.mas_centerX);
//        make.height.mas_equalTo(0.5);
//        make.width.mas_equalTo(SCREEN_WIDTH-50);
//    }];
    
    [self.view addSubview:self.confirmButton];
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(SCREEN_WIDTH-45);
        make.top.equalTo(self.passwordTF.mas_bottom).offset(37);
        make.height.mas_equalTo(59);
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


- (BATImageTextField *)phoneTF {
    if (!_phoneTF) {
        
        _phoneTF = [[BATImageTextField alloc] initWithFrame:CGRectZero Image:[UIImage imageNamed:@"icon_login_phone"] placehold:@"请输入手机号"];
        _phoneTF.rightTF.keyboardType = UIKeyboardTypePhonePad;
        
        //        _phoneTF = [UITextField textFieldWithfont:[UIFont systemFontOfSize:15] textColor:nil placeholder:@"请输入手机号" BorderStyle:UITextBorderStyleNone];
        //        _phoneTF.keyboardType = UIKeyboardTypePhonePad;
        //        UILabel *phoneLabel = [[UILabel alloc] init];
        //        phoneLabel.text = @"手机号：";
        //        [phoneLabel sizeToFit];
        //        _phoneTF.leftView = phoneLabel;
        //        _phoneTF.leftViewMode = UITextFieldViewModeAlways;
    }
    return _phoneTF;
}

- (BATImageTextField *)codeTF {
    if (!_codeTF) {
        
        _codeTF = [[BATImageTextField alloc] initWithFrame:CGRectZero Image:[UIImage imageNamed:@"login-ic-yzm"] placehold:@"请输入验证码"];
        _codeTF.rightTF.keyboardType = UIKeyboardTypeNumberPad;
        
        //        _codeTF = [UITextField textFieldWithfont:[UIFont systemFontOfSize:14] textColor:nil placeholder:@"请输入验证码" BorderStyle:UITextBorderStyleNone];
        //        _codeTF.keyboardType = UIKeyboardTypeNumberPad;
        //        UILabel *codeLabel = [[UILabel alloc] init];
        //        codeLabel.text = @"验证码：";
        //        [codeLabel sizeToFit];
        //        _codeTF.leftView = codeLabel;
        //        _codeTF.leftViewMode = UITextFieldViewModeAlways;
    }
    return _codeTF;
}

- (UIButton *)countdownButton {
    if (!_countdownButton) {
        _countdownButton = [UIButton buttonWithType:UIButtonTypeCustom Title:@"发送验证码" titleColor:BLUE_COLOR backgroundColor:[UIColor clearColor] backgroundImage:nil Font:[UIFont systemFontOfSize:14]];
        _countdownButton.layer.cornerRadius = 5.0f;
        WEAK_SELF(self);
        [_countdownButton bk_whenTapped:^{
            STRONG_SELF(self);
            [self.view endEditing:YES];
            [self codeRequest];
        }];
    }
    return _countdownButton;
}

- (BATImageTextField *)passwordTF {
    if (!_passwordTF) {
        
        _passwordTF = [[BATImageTextField alloc] initWithFrame:CGRectZero Image:[UIImage imageNamed:@"icon_login_password"] placehold:@"请输入密码"];
        _passwordTF.rightTF.keyboardType = UIKeyboardTypePhonePad;
        
        //        _passwordTF = [UITextField textFieldWithfont:[UIFont systemFontOfSize:14] textColor:nil placeholder:@"请输入密码" BorderStyle:UITextBorderStyleNone];
        //        _passwordTF.secureTextEntry = YES;
        //        UILabel *passwordLabel = [[UILabel alloc] init];
        //        passwordLabel.text = @"密    码：";
        //        [passwordLabel sizeToFit];
        //        _passwordTF.leftView = passwordLabel;
        //        _passwordTF.leftViewMode = UITextFieldViewModeAlways;
    }
    return _passwordTF;
}


//- (UITextField *)confirmPasswordTF {
//    if (!_confirmPasswordTF) {
//        _confirmPasswordTF = [UITextField textFieldWithfont:[UIFont systemFontOfSize:14] textColor:nil placeholder:@"请再次输入密码" BorderStyle:UITextBorderStyleNone];
//        _confirmPasswordTF.secureTextEntry = YES;
//        _confirmPasswordTF.leftViewMode = UITextFieldViewModeAlways;
//        _confirmPasswordTF.delegate = self;
//        _confirmPasswordTF.returnKeyType = UIReturnKeyDone;
//    }
//    return _confirmPasswordTF;
//}

- (UIButton *)confirmButton {
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom Title:@"确认" titleColor:[UIColor whiteColor] backgroundColor:nil backgroundImage:[UIImage imageNamed:@"login-btn"] Font:[UIFont systemFontOfSize:18]];
//        _confirmButton.layer.cornerRadius = 5.0f;
        [_confirmButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 10, 0)];
        WEAK_SELF(self);
        [_confirmButton bk_whenTapped:^{
            STRONG_SELF(self);
            [self checkValue];
        }];
    }
    return _confirmButton;
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
