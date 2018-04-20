//
//  BATRegisterViewController.m
//  HealthBAT_Pro
//
//  Created by KM on 16/8/242016.
//  Copyright © 2016年 KMHealthCloud. All rights reserved.
//

#import "BATRegisterViewController.h"
//第三方
#import "SFHFKeychainUtils.h"

#import "BATLoginModel.h"
#import "BATPerson.h"
#import "BATTIMDataModel.h"
#import "BATImageTextField.h"

#import "BATAppDelegate+BATResetLogin.h"//登录
#import "BATAppDelegate+BATDoctorStatus.h"
#import "BATAgoraSignalingManager.h"

#import "BATAuthenticateResultViewController.h"
#import "BATAuthenticateIndexViewController.h"

@interface BATRegisterViewController ()<UITextFieldDelegate>

@property (nonatomic,strong) UIImageView *topImageView;
@property (nonatomic,strong) BATImageTextField *phoneTF;
@property (nonatomic,strong) BATImageTextField *codeTF;
@property (nonatomic,strong) UIButton *countdownButton;
//@property (nonatomic,strong) UITextField *accountNameTF;
@property (nonatomic,strong) BATImageTextField *passwordTF;
//@property (nonatomic,strong) UITextField *confirmPasswordTF;
@property (nonatomic,strong) UIButton *registerButton;

@end

@implementation BATRegisterViewController

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
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] bk_initWithImage:[UIImage imageNamed:@"back_icon"] style:UIBarButtonItemStyleDone handler:^(id sender) {
//        STRONG_SELF(self);
//        [self.navigationController popViewControllerAnimated:YES];
//
//    }];

//    WEAK_SELF(self);
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] bk_initWithBarButtonSystemItem:UIBarButtonSystemItemStop handler:^(id sender) {
//        STRONG_SELF(self);
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
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
-(void)registerBAT {

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
    
    
    [self registerRequest];
}

#pragma mark - net
- (void)codeRequest {

    //判断输入的手机号码是否符合规范
    if (![Tools checkPhoneNumber:self.phoneTF.rightTF.text]) {
        [self showText:@"请输入正确的手机号"];
        return;
    }

    [self showProgress];

    [HTTPTool requestWithURLString:[NSString stringWithFormat:@"/api/Account/SendVerifyCode/%@/1",self.phoneTF.rightTF.text] parameters:nil type:kGET success:^(id responseObject) {

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

- (void)registerRequest {

    NSDictionary *para = @{@"VerificationCode":self.codeTF.rightTF.text,
                           @"Password":self.passwordTF.rightTF.text,
                           @"PhoneNumber":self.phoneTF.rightTF.text};
    
    [self showProgress];
    [HTTPTool requestWithURLString:@"/api/NetworkMedical/UserRegister" parameters:para type:kPOST success:^(id responseObject) {
        
        [self showSuccessWithText:@"注册成功"];
        
        BATLoginModel * login = [BATLoginModel mj_objectWithKeyValues:responseObject];
        
        if (login.ResultCode == 0) {
            //登录成功
            BATAppDelegate *delegate = (BATAppDelegate *)[UIApplication sharedApplication].delegate;
            [delegate successActionWithLogin:login userName:self.phoneTF.rightTF.text password:self.phoneTF.rightTF.text];
            
            //获取工作室的状态
            [self requestGetDoctorStatus];
        }
        
    } failure:^(NSError *error) {
        [self showErrorWithText:@"请求失败，请稍候重试"];
        
    }];

//    [HTTPTool requestWithURLString:@"/api/NetworkMedical/UserRegister" parameters:para type:kPOST success:^(id responseObject) {
//
//        [self showSuccessWithText:@"注册成功"];
//
//        
//        BATLoginModel * login = [BATLoginModel mj_objectWithKeyValues:responseObject];
//        
//        if (login.ResultCode == 0) {
//            //登录成功
//            if (login.Data.AccountType == 2) {
//                //医生账号，暂时不能登陆
//                [self showErrorWithText:@"账号异常"];
//                return ;
//            }
//            
//            //改变登录状态
//            SET_LOGIN_STATION(YES);
//            
//            //保存登录信息
//            NSString *file = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/UserLogin.data"];
//            [NSKeyedArchiver archiveRootObject:login toFile:file];
//            [[NSUserDefaults standardUserDefaults] setValue:login.Data.Token forKey:@"Token"];
//            [[NSUserDefaults standardUserDefaults] synchronize];
//            
//            //保存密码
//            NSError  *error;
//            NSString *userName = self.phoneTF.text;
//            NSString *password = self.passwordTF.text;
//            [[NSUserDefaults standardUserDefaults] setValue:userName forKey:@"LOGIN_NAME"];
//            BOOL saved = [SFHFKeychainUtils storeUsername:userName andPassword:password forServiceName:ServiceName updateExisting:YES error:&error];
//            if(!saved){
//                DDLogError(@"保存密码时出错：%@",error);
//            }
//            error = nil;
//            
//            
//            //获取个人信息
//            [self personInfoListRequest];
//            
//            //获取云通讯配置信息
////            [[BATTIMManager sharedBATTIM] bat_loginTIM];
//            [self getTIMDataRequest];
//            
//        }
//
//        //返回登录界面
//        [self dismissViewControllerAnimated:YES completion:nil];
//        
//
//    } failure:^(NSError *error) {
//
//    }];
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


////获取云通讯信息
//- (void)getTIMDataRequest{
//    
//    [HTTPTool requestWithURLString:@"/api/Account/GetIMConfig" parameters:nil type:kGET success:^(id responseObject) {
//        
//        BATTIMDataModel *TIMData= [BATTIMDataModel mj_objectWithKeyValues:responseObject];
//        
//        if (TIMData.ResultCode == 0) {
//            
//            NSString *file = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/TIMData.data"];
//            [NSKeyedArchiver archiveRootObject:TIMData toFile:file];
//            
////            [[BATTIMManager sharedBATTIM] bat_loginTIM];
//        }
//        
//    } failure:^(NSError *error) {
//        
//    }];
//}
//
//- (void)personInfoListRequest {
//    
//    [HTTPTool requestWithURLString:@"/api/Patient/Info" parameters:nil type:kGET success:^(id responseObject) {
//        
//        BATPerson * person = [BATPerson mj_objectWithKeyValues:responseObject];
//        if (person.ResultCode == 0) {
//            
//            //保存登录信息
//            NSString *file = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Person.data"];
//            [NSKeyedArchiver archiveRootObject:person toFile:file];
//        }
//    } failure:^(NSError *error) {
//        
//    }];
//}

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
//    }else {
//        lineSpa = 20;
//        height = 50;
//    }
    
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

    [self.view addSubview:self.registerButton];
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
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
//        UILabel *confirmPasswordLabel = [[UILabel alloc] init];
//        confirmPasswordLabel.text = @"确认密码：";
//        [confirmPasswordLabel sizeToFit];
//        _confirmPasswordTF.leftView = confirmPasswordLabel;
//        _confirmPasswordTF.leftViewMode = UITextFieldViewModeAlways;
//        _confirmPasswordTF.returnKeyType = UIReturnKeyDone;
//        _confirmPasswordTF.delegate = self;
//    }
//    return _confirmPasswordTF;
//}

- (UIButton *)registerButton {
    if (!_registerButton) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom Title:@"注册" titleColor:[UIColor whiteColor] backgroundColor:nil backgroundImage:[UIImage imageNamed:@"login-btn"] Font:[UIFont systemFontOfSize:18]];
        [_registerButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 10, 0)];
//        _registerButton.layer.cornerRadius = 5.0f;
        WEAK_SELF(self);
        [_registerButton bk_whenTapped:^{
            STRONG_SELF(self);
            [self registerBAT];
        }];
    }
    return _registerButton;
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
