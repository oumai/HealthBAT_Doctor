//
//  LoginViewController.m
//  HealthBAT_Pro
//
//  Created by Skyrim on 16/7/13.
//  Copyright © 2016年 KMHealthCloud. All rights reserved.
//

#import "BATLoginViewController.h"
//第三方
#import "SFHFKeychainUtils.h"
//子视图
#import "BATImageTextField.h"
#import "BATLoginModel.h"
//model
#import "BATPerson.h"
#import "BATTIMDataModel.h"

//跳转试图
#import "BATRegisterViewController.h"
#import "BATForgetPasswordViewController.h"
#import "BATAuthenticateResultViewController.h"
#import "BATAuthenticateIndexViewController.h"

//#import "BATTIMManager.h"
//#import "BATVisitConfigModel.h"

#import "IQKeyboardManager.h"//键盘管理

#import "BATAppDelegate+BATResetLogin.h"//登录
#import "BATAppDelegate+BATDoctorStatus.h"
#import "BATAgoraSignalingManager.h"


@interface BATLoginViewController ()<UITextFieldDelegate>
{
    NSString *userId;
    NSString *userToken;
}

@property (nonatomic,strong) UIImageView       *topImageView;
@property (nonatomic,strong) UIView            *moveBGView;

//@property (nonatomic,strong) UITextField       *loginUserTF;
//@property (nonatomic,strong) UITextField       *loginPasswordTF;

@property (nonatomic,strong) BATImageTextField       *loginUserTF;
@property (nonatomic,strong) BATImageTextField       *loginPasswordTF;

//@property (nonatomic,strong) UITextField       *registerPhoneTF;
//@property (nonatomic,strong) UITextField       *registerCodeTF;
//@property (nonatomic,strong) UITextField       *registerPasswordTF;
//@property (nonatomic,strong) UIButton          *registerCountdownButton;
//@property (nonatomic,strong) UIButton          *registerShowPasswordButton;

@property (nonatomic,strong) UIButton          *loginButton;
//@property (nonatomic,strong) UIButton          *registerButton;
@property (nonatomic,strong) UIButton          *goRegisterButton;
//@property (nonatomic,strong) UIButton          *goLoginButton;
@property (nonatomic,strong) UIButton          *forgetPasswordButton;

@property (nonatomic,assign) BOOL              isLoginIn;
@end

@implementation BATLoginViewController

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self userLogout];

    self.isLoginIn = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //绑定手机成功通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bindingPhoneSucess) name:@"DINDING_PHONE_SUCCESS" object:nil];
    
    [self pagesLayout];


    self.loginUserTF.rightTF.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"LOGIN_NAME"];
    if (self.loginUserTF.rightTF.text.length == 0) {
        return;
    }
    NSError *error;
    NSString * password = [SFHFKeychainUtils getPasswordForUsername:self.loginUserTF.rightTF.text andServiceName:ServiceName error:&error];
    if(error){
        DDLogError(@"从Keychain里获取密码出错：%@",error);
        return;
    }
    self.loginPasswordTF.rightTF.text = password;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark - UITextFieldDelegate

-(void)textFieldDidEndEditing:(UITextField *)textField{

    if (![Tools checkPhoneNumber:textField.text]) {
        [self showErrorWithText:@"请输入正确的手机号码"];
    }
}

#pragma mark - Action
- (void)login {
    if (self.loginUserTF.rightTF.text.length == 0) {
        [self showErrorWithText:@"请输入帐号或者手机号"];
        return;
    }

    if (self.loginPasswordTF.rightTF.text.length == 0) {
        [self showErrorWithText:@"请输入密码"];
        return;
    }

    [self.view endEditing:YES];
    [self loginRequest];
}

- (void)bindingPhoneSucess{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:NO completion:nil];
    });
}

- (void)userLogout {

    //清空极光推送别名
//    [JPUSHService setAlias:@"" callbackSelector:nil object:nil];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"APPLICATION_LOGOUT" object:nil];

    //改变登录状态
    SET_LOGIN_STATION(NO);

    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"Token"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    [[NSFileManager defaultManager] removeItemAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/UserLogin.data"] error:nil];
    [[NSFileManager defaultManager] removeItemAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Person.data"] error:nil];

}

#pragma mark - NET
- (void)loginRequest {
    [self showProgressWithText:@"正在登录"];

    BATAppDelegate *delegate = (BATAppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate bat_LoginWithUserName:self.loginUserTF.rightTF.text password:self.loginPasswordTF.rightTF.text Success:^{

        [self showSuccessWithText:@"登录成功"];
        //完成登录，退出登录界面
        
        //获取工作室的状态
        [self requestGetDoctorStatus];
        
        
    } failure:^(NSError *error) {
        
        [self showErrorWithText:error.localizedDescription];
    }];
}

- (void)personInfoListRequest {

    [HTTPTool requestWithURLString:@"/api/Patient/Info" parameters:nil type:kGET success:^(id responseObject) {
        
        BATPerson * person = [BATPerson mj_objectWithKeyValues:responseObject];
        if (person.ResultCode == 0) {

            //保存登录信息
            NSString *file = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Person.data"];
            [NSKeyedArchiver archiveRootObject:person toFile:file];
        }
    } failure:^(NSError *error) {

    }];
}

- (void)requestGetDoctorStatus
{
    BATAppDelegate *delegate = (BATAppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate getDoctorStatus:^(BATAuditingType type,BATDoctorStatusModel *doctorStatusModel) {
        switch (type) {
            case BATAuditingType_NotOpen: {
                //未开通工作室
                BATAuthenticateIndexViewController *authenticateIndexVC = [[BATAuthenticateIndexViewController alloc] init];
                authenticateIndexVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:authenticateIndexVC animated:YES];
            }
                break;
                
            case BATAuditingType_PendingReview: {
                //待审核/审核中
                BATAuthenticateResultViewController *authenticateResultVC = [[BATAuthenticateResultViewController alloc] init];
                authenticateResultVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:authenticateResultVC animated:YES];
            }
                break;
                
            case BATAuditingType_ReviewSuccess:
                //审核通过
                
                //连接融云
                [[BATRongCloudManager sharedBATRongCloudManager] bat_loginRongCloudWithToken:doctorStatusModel.Data.RongCloudToken success:^(NSString *userId) {
                    
                } error:^(RCConnectErrorCode status) {
                    
                } tokenIncorrect:^{
                    
                }];
                
                //登录声网信令
                [[BATAgoraSignalingManager shared] login:doctorStatusModel.Data.DoctorID token:doctorStatusModel.Data.AgoraToken deviceID:@"" complete:^(BOOL success) {
                    
                }];
                
                [self dismissViewControllerAnimated:NO completion:nil];
                
                break;
                
            case BATAuditingType_ReviewFail: {
                //审核不通过
                
                BATAuthenticateResultViewController *authenticateResultVC = [[BATAuthenticateResultViewController alloc] init];
                authenticateResultVC.authenticateResultView.resultLabel.text = @"审核失败，请重新认证";
                authenticateResultVC.authenticateResultView.contentLabel.text = [NSString stringWithFormat:@"失败原因：%@",doctorStatusModel.Data.AuditingContent];
                authenticateResultVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:authenticateResultVC animated:YES];
            }
                break;
                
            case BATAuditingType_Close:
                //关闭工作室
                break;
                
            default:
                break;
        }
    }];
}

#pragma mark - net
//- (void)codeRequest {
//    
//    //判断输入的手机号码是否符合规范
//    if (![Tools checkPhoneNumber:self.registerPhoneTF.text]) {
//        [self showText:@"请输入正确的手机号"];
//        return;
//    }
//    
//    [self showProgress];
//    
//    [HTTPTool requestWithURLString:[NSString stringWithFormat:@"/api/Account/SendVerifyCode/%@/1",self.registerPhoneTF.text] parameters:nil type:kGET success:^(id responseObject) {
//        
//        [self dismissProgress];
//        
//        //创建获取验证码的定时器
//        self.registerCountdownButton.userInteractionEnabled = NO;
//        self.registerCountdownButton.backgroundColor = [UIColor clearColor];
//        [self.registerCountdownButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//        [Tools countdownWithTime:120 End:^{
//            [self.registerCountdownButton setTitle:@"获取验证码" forState:UIControlStateNormal];
//            [self.registerCountdownButton setTitleColor:BASE_COLOR forState:UIControlStateNormal];
//            self.registerCountdownButton.userInteractionEnabled = YES;
//        } going:^(NSString *time) {
//            [self.registerCountdownButton setTitle:time forState:UIControlStateNormal];
//        }];
//        
//        
//    } failure:^(NSError *error) {
//        [self showErrorWithText:error.localizedDescription];
//    }];
//}
//
//-(void)registerBAT {
//    
//    [self.view endEditing: YES];
//    //判断输入框是否为空。(即无输入)
//    if (self.registerPhoneTF.text.length == 0) {
//        [self showText:@"请输入手机号"];
//        return;
//    }
//    
//    //判断输入的手机号码是否符合规范
//    if (![Tools checkPhoneNumber:self.registerPhoneTF.text]) {
//        [self showText:@"请输入正确的手机号"];
//        return;
//    }
//    
//    
//    if (self.registerCodeTF.text.length == 0) {
//        [self showText:@"请输入验证码"];
//        return;
//    }
//    if (self.registerPasswordTF.text.length == 0) {
//        [self showText:@"请输入密码"];
//        return;
//    }
//    
//    if(self.registerPasswordTF.text.length > 16){
//        [self showText:@"密码过长，请重新输入"];
//        return;
//    }
//    if(self.registerPasswordTF.text.length < 6){
//        [self showText:@"密码过短，请重新输入"];
//        return;
//    }
//    
//    if ([self.registerPasswordTF.text rangeOfString:@" "].location != NSNotFound) {
//        [self showText:@"密码中不能包含空格"];
//        return;
//    }
//    
//    
//    [self registerRequest];
//}
//
//- (void)registerRequest {
//    
//    NSDictionary *para = @{@"VerificationCode":self.registerCodeTF.text,@"Password":self.registerPasswordTF.text,@"PhoneNumber":self.registerPhoneTF.text};
//    [self showProgress];
//    [HTTPTool requestWithURLString:@"/api/NetworkMedical/UserRegister" parameters:para type:kPOST success:^(id responseObject) {
//        
//        [self showSuccessWithText:@"注册成功"];
//        
//        BATLoginModel * login = [BATLoginModel mj_objectWithKeyValues:responseObject];
//        
//        if (login.ResultCode == 0) {
//            //登录成功
//            BATAppDelegate *delegate = (BATAppDelegate *)[UIApplication sharedApplication].delegate;
//            [delegate successActionWithLogin:login userName:self.registerPhoneTF.text password:self.registerPasswordTF.text];
//            
//            //获取工作室的状态
//            [self requestGetDoctorStatus];
//        }
//        
//    } failure:^(NSError *error) {
//        [self showErrorWithText:@"请求失败，请稍候重试"];
//
//    }];
//}

#pragma mark - Layout
- (void)pagesLayout {
    
    /**
     *  判断手机型号，调整整体布局
     */
//    CGFloat lineSpa;
//    CGFloat height;
//    if (iPhone4) {
//        lineSpa = 7;
//        height = 59;
//    }
//    else if(iPhone5){
//        lineSpa = 10;
//        height = 59;
//    }else if(iPhone6){
//        lineSpa = 15;
//        height = 59;
//    }else if(iPhone6p){
//        lineSpa = 20;
//        height = 59;
//    }else {
//        lineSpa = 20;
//        height = 59;
//    }
    
    CGFloat offsetTop = 65;
    
    if (iPhone4 || iPad || iPadAir) {
        offsetTop = 21;
    } else if(iPhone5){
        offsetTop = 30;
    }


    WEAK_SELF(self);
    
    
    [self.view addSubview:self.topImageView];
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(64+20);
    }];
    
    
//    //======滑动背景========================
//    [self.view addSubview:self.moveBGView];
//    [self.moveBGView mas_makeConstraints:^(MASConstraintMaker *make) {
//        STRONG_SELF(self);
//        
//        make.top.equalTo(self.topImageView.mas_bottom).offset(65);
//        make.left.equalTo(self.view.mas_left).offset(0);
//        make.height.mas_equalTo(3*(lineSpa + height) + 28);
//        make.width.mas_equalTo(SCREEN_WIDTH*2);
//    }];

    
    //======登录控件========================
    [self.view addSubview:self.loginUserTF];
    [self.loginUserTF mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        
        make.top.equalTo(self.topImageView.mas_bottom).offset(offsetTop);
        make.left.equalTo(self.view.mas_left).offset(23);
        make.height.mas_equalTo(59);
        make.width.mas_equalTo(SCREEN_WIDTH-46);
    }];
    
    //手机号下划线
    UIView *userTFLine = [[UIView alloc]init];
    userTFLine.backgroundColor = BASE_LINECOLOR;
    [self.view addSubview:userTFLine];
    [userTFLine mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        
        make.top.equalTo(self.loginUserTF.mas_bottom).offset(1);
        make.left.equalTo(self.view.mas_left).offset(23);
        make.height.mas_equalTo(0.5);
        make.width.mas_equalTo(SCREEN_WIDTH-46);
    }];

    [self.view addSubview:self.loginPasswordTF];
    [self.loginPasswordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);

        make.top.equalTo(self.loginUserTF.mas_bottom).offset(20);
        make.left.equalTo(self.view.mas_left).offset(23);
        make.height.mas_equalTo(59);
        make.width.mas_equalTo(SCREEN_WIDTH-46);
    }];
    
    //密码下划线
    UIView *passwordTFLine = [[UIView alloc]init];
    passwordTFLine.backgroundColor = BASE_LINECOLOR;
    [self.view addSubview:passwordTFLine];
    [passwordTFLine mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        
        make.top.equalTo(self.loginPasswordTF.mas_bottom).offset(1);
        make.left.equalTo(self.view.mas_left).offset(23);
        make.height.mas_equalTo(0.5);
        make.width.mas_equalTo(SCREEN_WIDTH-46);
    }];
    
    [self.view addSubview:self.forgetPasswordButton];
    [self.forgetPasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        
        make.right.equalTo(self.loginPasswordTF.mas_right);
        make.top.equalTo(self.loginPasswordTF.mas_bottom).offset(15);
    }];
    
    [self.view addSubview:self.goRegisterButton];
    [self.goRegisterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        
        make.left.equalTo(self.loginPasswordTF.mas_left);
        make.top.equalTo(self.loginPasswordTF.mas_bottom).offset(15);
    }];

    [self.view addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);

        make.top.equalTo(self.goRegisterButton.mas_bottom).offset(37);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(59);
        make.width.mas_equalTo(SCREEN_WIDTH-40);
    }];
    

    
//    
//    //======注册控件========================
//    [self.moveBGView addSubview:self.registerPhoneTF];
//    [self.registerPhoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
//        STRONG_SELF(self);
//        
//        make.top.equalTo(self.moveBGView.mas_top).offset(0);
//        make.left.equalTo(self.moveBGView.mas_left).offset(23 + SCREEN_WIDTH);
//        make.height.mas_equalTo(height);
//        make.width.mas_equalTo(SCREEN_WIDTH-46);
//    }];
//    
//    //手机号下划线
//    UIView *phoneTFLine = [[UIView alloc]init];
//    phoneTFLine.backgroundColor = BASE_LINECOLOR;
//    [self.moveBGView addSubview:phoneTFLine];
//    [phoneTFLine mas_makeConstraints:^(MASConstraintMaker *make) {
//        STRONG_SELF(self);
//        
//        make.top.equalTo(self.registerPhoneTF.mas_bottom).offset(1);
//        make.left.equalTo(self.moveBGView.mas_left).offset(23 + SCREEN_WIDTH);
//        make.height.mas_equalTo(0.5);
//        make.width.mas_equalTo(SCREEN_WIDTH-46);
//    }];
//
//    [self.moveBGView addSubview:self.registerCodeTF];
//    [self.registerCodeTF mas_makeConstraints:^(MASConstraintMaker *make) {
//        STRONG_SELF(self);
//        
//        make.left.equalTo(self.moveBGView.mas_left).offset(23 + SCREEN_WIDTH);
//        make.top.equalTo(self.registerPhoneTF.mas_bottom).offset(lineSpa);
//        make.height.mas_equalTo(height);
//        make.width.mas_equalTo(SCREEN_WIDTH - 46 - 80);
//    }];
//    
//    [self.moveBGView addSubview:self.registerCountdownButton];
//    [self.registerCountdownButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        STRONG_SELF(self);
//        
//        make.right.equalTo(self.moveBGView.mas_right).offset(-23);
//        make.centerY.equalTo(self.registerCodeTF.mas_centerY);
//    }];
//    
//    
//    //验证码下划线
//    UIView *codeTFLine = [[UIView alloc]init];
//    codeTFLine.backgroundColor = BASE_LINECOLOR;
//    [self.moveBGView addSubview:codeTFLine];
//    [codeTFLine mas_makeConstraints:^(MASConstraintMaker *make) {
//        STRONG_SELF(self);
//        
//        make.top.equalTo(self.registerCodeTF.mas_bottom).offset(1);
//        make.left.equalTo(self.moveBGView.mas_left).offset(23 +SCREEN_WIDTH);
//        make.height.mas_equalTo(0.5);
//        make.width.mas_equalTo(SCREEN_WIDTH-46);
//    }];
//    
//    [self.moveBGView addSubview:self.registerPasswordTF];
//    [self.registerPasswordTF mas_makeConstraints:^(MASConstraintMaker *make) {
//        STRONG_SELF(self);
//        
//        make.left.equalTo(self.moveBGView.mas_left).offset(23 + SCREEN_WIDTH);
//        make.top.equalTo(self.registerCodeTF.mas_bottom).offset(lineSpa);
//        make.height.mas_equalTo(height);
//        make.width.mas_equalTo(SCREEN_WIDTH - 46 - 40);
//    }];
//    
//    //密码下划线
//    UIView *registerPasswordTFLine = [[UIView alloc]init];
//    registerPasswordTFLine.backgroundColor = BASE_LINECOLOR;
//    [self.moveBGView addSubview:registerPasswordTFLine];
//    [registerPasswordTFLine mas_makeConstraints:^(MASConstraintMaker *make) {
//        STRONG_SELF(self);
//        
//        make.top.equalTo(self.registerPasswordTF.mas_bottom).offset(1);
//        make.left.equalTo(self.moveBGView.mas_left).offset(23 +SCREEN_WIDTH);
//        make.height.mas_equalTo(0.5);
//        make.width.mas_equalTo(SCREEN_WIDTH-46);
//    }];
//    
//    [self.moveBGView addSubview:self.registerShowPasswordButton];
//    [self.registerShowPasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        STRONG_SELF(self);
//        
//        make.centerY.equalTo(self.registerPasswordTF.mas_centerY);
//        make.right.equalTo(self.moveBGView.mas_right).offset(-23);
//        make.width.mas_offset(50);
//        make.height.mas_equalTo(height);
//    }];
//    
//    
//    [self.view addSubview:self.registerButton];
//    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        STRONG_SELF(self);
//        
//        make.top.equalTo(self.moveBGView.mas_bottom).offset(0);
//        make.centerX.equalTo(self.view.mas_centerX);
//        make.height.mas_equalTo(height);
//        make.width.mas_equalTo(SCREEN_WIDTH-46);
//    }];
//    
//    [self.view addSubview:self.goLoginButton];
//    [self.goLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        STRONG_SELF(self);
//        
//        make.centerX.equalTo(self.view.mas_centerX);
//        make.top.equalTo(self.registerButton.mas_bottom).offset(32);
//    }];
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

- (UIView *)moveBGView{
    if (!_moveBGView) {
        _moveBGView = [[UIView alloc]initWithFrame:CGRectZero];
    }
    return _moveBGView;
}

- (BATImageTextField *)loginUserTF {
    if (!_loginUserTF) {
        _loginUserTF = [[BATImageTextField alloc] initWithFrame:CGRectZero Image:[UIImage imageNamed:@"icon_login_phone"] placehold:@"请输入手机号"];
        _loginUserTF.rightTF.keyboardType = UIKeyboardTypePhonePad;
        _loginUserTF.rightTF.delegate = self;
        
    }
    return _loginUserTF;
}

- (BATImageTextField *)loginPasswordTF {
    
    if (!_loginPasswordTF) {
        
        _loginPasswordTF = [[BATImageTextField alloc] initWithFrame:CGRectZero Image:[UIImage imageNamed:@"icon_login_password"] placehold:@"请输入密码"];
        _loginPasswordTF.rightTF.secureTextEntry = YES;
    }
    return _loginPasswordTF;
}

//- (UITextField *)loginUserTF {
//    if (!_loginUserTF) {
//        _loginUserTF = [UITextField textFieldWithfont:[UIFont systemFontOfSize:15] textColor:BASE_COLOR placeholder:@"请输入手机号" BorderStyle:UITextBorderStyleNone];
//        _loginUserTF.keyboardType = UIKeyboardTypePhonePad;
//        _loginUserTF.delegate = self;
//        _loginUserTF.leftViewMode = UITextFieldViewModeAlways;
//        _loginUserTF.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_login_phone"]];
//        
//    }
//    return _loginUserTF;
//}
//
//- (UITextField *)loginPasswordTF {
//
//    if (!_loginPasswordTF) {
//        
//        _loginPasswordTF = [UITextField textFieldWithfont:[UIFont systemFontOfSize:15] textColor:BASE_COLOR placeholder:@"请输入密码" BorderStyle:UITextBorderStyleNone];
//        _loginPasswordTF.secureTextEntry = YES;
//        _loginPasswordTF.leftViewMode = UITextFieldViewModeAlways;
//        _loginPasswordTF.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_login_password"]];
//    }
//    return _loginPasswordTF;
//}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom Title:@"登  录" titleColor:UIColorFromHEX(0xffffff,1) backgroundColor:nil backgroundImage:[UIImage imageNamed:@"login-btn"] Font:[UIFont systemFontOfSize:18]];
//        _loginButton.layer.cornerRadius = 5.0f;
        [_loginButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 10, 0)];
        WEAK_SELF(self);
        [_loginButton bk_whenTapped:^{
            STRONG_SELF(self);

            [self login];

        }];
    }
    return _loginButton;
}

//- (UIButton *)registerButton{
//    if (!_registerButton) {
//        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom Title:@"注册" titleColor:[UIColor whiteColor] backgroundColor:BASE_COLOR backgroundImage:nil Font:[UIFont systemFontOfSize:16]];
//        _registerButton.layer.cornerRadius = 5.0f;
//        _registerButton.hidden = YES;
//        WEAK_SELF(self);
//        [_registerButton bk_whenTapped:^{
//            STRONG_SELF(self);
//
//            [self registerBAT];
//            
//        }];
//    }
//    return _registerButton;
//}
//
//- (UIButton *)goLoginButton{
//    if (!_goLoginButton) {
//        _goLoginButton = [UIButton buttonWithType:UIButtonTypeCustom Title:@"已有账号？去登录" titleColor:BASE_COLOR  backgroundColor:[UIColor clearColor] backgroundImage:nil Font:[UIFont systemFontOfSize:14]];
//        _goLoginButton.hidden = YES;
//        
//        WEAK_SELF(self);
//        [_goLoginButton bk_whenTapped:^{
//            
//            STRONG_SELF(self);
//            [self.moveBGView mas_updateConstraints:^(MASConstraintMaker *make) {
//                
//                make.left.equalTo(self.view.mas_left).offset(0);
//                
//            }];
//            [UIView animateWithDuration:0.35f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
//                [self.view setNeedsLayout];
//                [self.view layoutIfNeeded];
//            } completion:nil];
//            self.registerButton.hidden = YES;
//            self.goRegisterButton.hidden = NO;
//            self.goLoginButton.hidden = YES;
//            self.registerPasswordTF.text = @"";
//            self.registerPhoneTF.text = @"";
//            self.registerCodeTF.text = @"";
//            
//        }];
//    }
//    return _goLoginButton;
//}

- (UIButton *)goRegisterButton {
    if (!_goRegisterButton) {
        _goRegisterButton = [UIButton buttonWithType:UIButtonTypeCustom Title:@"注册" titleColor:STRING_LIGHT_COLOR  backgroundColor:[UIColor clearColor] backgroundImage:nil Font:[UIFont systemFontOfSize:14]];
        
        WEAK_SELF(self);
        [_goRegisterButton bk_whenTapped:^{
            
            STRONG_SELF(self);
            
            BATRegisterViewController *registerVC = [[BATRegisterViewController alloc] init];
            [self.navigationController pushViewController:registerVC animated:YES];
            
//            [self.moveBGView mas_updateConstraints:^(MASConstraintMaker *make) {
//                
//                make.left.equalTo(self.view.mas_left).offset(-SCREEN_WIDTH);
//                
//            }];

//            [UIView animateWithDuration:0.35f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
//                [self.view setNeedsLayout];
//                [self.view layoutIfNeeded];
//            } completion:^(BOOL finished) {
//
//                [self.registerPhoneTF becomeFirstResponder];
//            }];

//            self.registerButton.hidden = NO;
//            self.goRegisterButton.hidden = YES;
//            self.goLoginButton.hidden = NO;
        }];
    }
    return _goRegisterButton;
}

- (UIButton *)forgetPasswordButton {
    if (!_forgetPasswordButton) {
        _forgetPasswordButton = [UIButton buttonWithType:UIButtonTypeCustom Title:@"忘记密码?" titleColor:BLUE_COLOR  backgroundColor:[UIColor clearColor] backgroundImage:nil Font:[UIFont systemFontOfSize:14]];
        WEAK_SELF(self);
        [_forgetPasswordButton bk_whenTapped:^{
            STRONG_SELF(self);
            BATForgetPasswordViewController *forgetPasswordVC = [[BATForgetPasswordViewController alloc] init];
            [self.navigationController pushViewController:forgetPasswordVC animated:YES];
//        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:forgetPasswordVC] animated:YES completion:nil];
        }];
    }
    return _forgetPasswordButton;

}


////=====注册控件====================
//- (UITextField *)registerPhoneTF {
//    if (!_registerPhoneTF) {
//        _registerPhoneTF = [UITextField textFieldWithfont:[UIFont systemFontOfSize:15] textColor:BASE_COLOR placeholder:@"请输入手机号" BorderStyle:UITextBorderStyleNone];
//        _registerPhoneTF.keyboardType = UIKeyboardTypePhonePad;
//        _registerPhoneTF.delegate = self;
//    }
//    return _registerPhoneTF;
//}
//
//- (UITextField *)registerCodeTF {
//    if (!_registerCodeTF) {
//        _registerCodeTF = [UITextField textFieldWithfont:[UIFont systemFontOfSize:15] textColor:BASE_COLOR placeholder:@"请输入验证码" BorderStyle:UITextBorderStyleNone];
//        _registerCodeTF.keyboardType = UIKeyboardTypeNumberPad;
//    }
//    return _registerCodeTF;
//}
//
//- (UIButton *)registerCountdownButton {
//    if (!_registerCountdownButton) {
//        _registerCountdownButton = [UIButton buttonWithType:UIButtonTypeCustom Title:@"发送验证码" titleColor:BASE_COLOR backgroundColor:[UIColor clearColor] backgroundImage:nil Font:[UIFont systemFontOfSize:14]];
//        [_registerCountdownButton sizeToFit];
//        WEAK_SELF(self);
//        [_registerCountdownButton bk_whenTapped:^{
//            STRONG_SELF(self);
//            [self.view endEditing:YES];
//            [self codeRequest];
//        }];
//    }
//    return _registerCountdownButton;
//}
//
//- (UITextField *)registerPasswordTF {
//    if (!_registerPasswordTF) {
//        _registerPasswordTF = [UITextField textFieldWithfont:[UIFont systemFontOfSize:15] textColor:BASE_COLOR placeholder:@"请输入密码" BorderStyle:UITextBorderStyleNone];
//        _registerPasswordTF.secureTextEntry = YES;
//    }
//    return _registerPasswordTF;
//}
//
//
//- (UIButton *)registerShowPasswordButton{
//    if (!_registerShowPasswordButton) {
//        _registerShowPasswordButton = [UIButton buttonWithType:UIButtonTypeCustom Title:@"" titleColor:BASE_COLOR backgroundColor:[UIColor clearColor] backgroundImage:nil Font:nil];
//        [_registerShowPasswordButton setImage:[UIImage imageNamed:@"password"] forState:UIControlStateNormal];
//        [_registerShowPasswordButton sizeToFit];
//        WEAK_SELF(self);
//        [_registerShowPasswordButton bk_whenTapped:^{
//            STRONG_SELF(self);
//            if (self.registerPasswordTF.secureTextEntry) {
//                self.registerPasswordTF.secureTextEntry = NO;
//            }else{
//                self.registerPasswordTF.secureTextEntry = YES;
//            }
//            
//        }];
//    }
//    return _registerShowPasswordButton;
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
