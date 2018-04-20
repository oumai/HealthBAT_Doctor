//
//  BATAuthenticateViewController.m
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/15.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import "BATAuthenticateViewController.h"
#import "BATCustomTableViewCell.h"
#import "BATAuthenticatePicTableViewCell.h"
#import "TZImagePickerController.h"
#import "TZImageManager.h"
#import "BATAuthenticateResultViewController.h"
#import "NSString+Chinese.h"
#import "BATLoginViewController.h"

@interface BATAuthenticateViewController () <UITableViewDelegate,UITableViewDataSource,BATDepartmentPickerViewDelegate,BATSexInputPickerViewDelegate,BATTitlePickerViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,TZImagePickerControllerDelegate,UITextFieldDelegate>

@property (nonatomic,strong) NSString *name;

@property (nonatomic,strong) NSString *sex;

@property (nonatomic,assign) NSInteger sexType;

@property (nonatomic,strong) NSString *IDNumber;

@property (nonatomic,strong) NSString *hospital;

@property (nonatomic,strong) NSString *departmentName;

@property (nonatomic,strong) NSString *departmentID;

@property (nonatomic,strong) NSString *doctorTitle;

@property (nonatomic,assign) NSInteger titleType;

@property (nonatomic,strong) NSString *city;

@property (nonatomic,strong) NSString *attachment;

@end

@implementation BATAuthenticateViewController

- (void)dealloc
{
    
    DDLogDebug(@"%@", self);
    
    self.authenticateView.tableView.delegate = nil;
    self.authenticateView.tableView.dataSource = nil;
    self.authenticateView.sexInputPickerView.delegate = nil;
    self.authenticateView.titlePickerView.delegate = nil;
    self.authenticateView.departmentPickerView.delegate = nil;
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
    
    [self.authenticateView.tableView registerClass:[BATCustomTableViewCell class] forCellReuseIdentifier:@"BATCustomTableViewCell"];
    [self.authenticateView.tableView registerClass:[BATAuthenticatePicTableViewCell class] forCellReuseIdentifier:@"BATAuthenticatePicTableViewCell"];
}

- (BOOL)navigationShouldPopOnBackButton {
    
    BOOL flag = YES;
    for (UIViewController *vc in self.navigationController.viewControllers) {
        
        if ([vc isKindOfClass:[BATLoginViewController class]] && self.isFromResult) {
            
            flag = NO;
            
            [self.navigationController popToViewController:vc animated:YES];
            
            break;
        }
    }
    
    return flag;
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

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 6;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 50;
    }
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        BATCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BATCustomTableViewCell" forIndexPath:indexPath];
        
        cell.indexPath = indexPath;
        
        if (indexPath.row == 0) {
            cell.titleLabel.attributedText = [cell setTitleString:@"姓名 *"];
            cell.textField.placeholder = @"请输入姓名";
            cell.textField.text = self.name;
            
        } else if (indexPath.row == 1) {
            
            cell.titleLabel.attributedText = [cell setTitleString:@"身份证 *"];
            cell.textField.placeholder = @"请输入身份证";
            cell.textField.text = self.IDNumber;
//            cell.textField.inputView = self.authenticateView.sexInputPickerView;
            
        } else if (indexPath.row == 2) {
            
            cell.titleLabel.attributedText = [cell setTitleString:@"医院 *"];
            cell.textField.placeholder = @"请输入医院";
            cell.textField.text = self.hospital;

            
        } else if (indexPath.row == 3) {
            
            cell.titleLabel.attributedText = [cell setTitleString:@"科室 *"];
            cell.textField.placeholder = @"请输入科室";
            cell.textField.text = self.departmentName;
            cell.textField.inputView = self.authenticateView.departmentPickerView;
            
        } else if (indexPath.row == 4) {
            
            cell.titleLabel.attributedText = [cell setTitleString:@"职称 *"];
            cell.textField.placeholder = @"请选择职称";
            cell.textField.text = self.doctorTitle;
            cell.textField.inputView = self.authenticateView.titlePickerView;
            
        } else if (indexPath.row == 5) {
            
            cell.titleLabel.attributedText = [cell setTitleString:@"城市 *"];
            cell.textField.placeholder = @"请输入城市";
            cell.textField.text = self.city;
        }
        
        WEAK_SELF(self);
        
        if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 5) {
            cell.textInput = ^(NSString *text, NSIndexPath *cellIndexPath) {
                DDLogDebug(@"text %@ indexPath %@",text,cellIndexPath);
                STRONG_SELF(self);
                
                if (cellIndexPath.row == 0) {
                    self.name = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                } else if (indexPath.row == 1) {
                    self.IDNumber = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];;
                } else if (indexPath.row == 2) {
                    self.hospital = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];;
                } else if (indexPath.row == 5) {
                    self.city = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];;
                }
                
            };
        }

        return cell;

    }
    
    BATAuthenticatePicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BATAuthenticatePicTableViewCell" forIndexPath:indexPath];
    cell.titleLabel.text = @"执业医师证";
    [cell.picView sd_setImageWithURL:[NSURL URLWithString:self.attachment] placeholderImage:nil];
    
    if (self.attachment) {
        cell.deleteBtn.hidden = NO;
    } else {
        cell.deleteBtn.hidden = YES;
    }
    
    WEAK_SELF(self);
    cell.addPicBlock = ^(){
        STRONG_SELF(self);
        [self.view endEditing:YES];
        [self takePic];
    };
    
    cell.deletePicBlock = ^(){
        STRONG_SELF(self);
        self.attachment = nil;
        [self.authenticateView.tableView reloadData];
    };
    
    return cell;
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    [self.authenticateView.sexPickerView hide];
//    [self.authenticateView.titlePickerView hide];

}

#pragma mark - BATSexInputPickerViewDelegate
- (void)BATSexInputPickerView:(BATSexInputPickerView *)sexInputPickerView didSelectRow:(NSInteger)row titleForRow:(NSString *)title
{
    self.sex = title;
    self.sexType = row;
    [self.authenticateView.tableView reloadData];
}

#pragma mark - BATTitlePickerViewDelegate
- (void)BATTitlePickerView:(BATTitlePickerView *)titlePickerView didSelectRow:(NSInteger)row titleForRow:(NSString *)title
{
    self.doctorTitle = title;
    self.titleType = row;
    [self.authenticateView.tableView reloadData];
}

#pragma mark - BATDepartmentPickerViewDelegate
- (void)BATDepartmentPickerView:(BATDepartmentPickerView *)departmentPickerView didSelectRow:(NSInteger)row departmentForRow:(NSDictionary *)department
{
    
    self.departmentID = department[@"ID"];
    self.departmentName = department[@"departmentName"];
    
    [self.authenticateView.tableView reloadData];

}

#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage* image = [[info objectForKey:UIImagePickerControllerEditedImage] copy];
    
    //    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [[TZImageManager manager] savePhotoWithImage:image completion:^(NSError *error) {
        
        if (!error) {
            UIImage *imageCompress = [Tools compressImageWithImage:image ScalePercent:0.05];
            [self requestUploadAttachment:imageCompress];
        }
        
    }];
    
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Action
- (void)takePic
{
    [self.view endEditing:YES];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"上传图片" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    WEAK_SELF(self);
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        STRONG_SELF(self);
        [self getPhotosFromCamera];
    }];
    
    UIAlertAction *photoGalleryAction = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        STRONG_SELF(self);
        [self getPhotosFromLocal];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertController addAction:cameraAction];
    [alertController addAction:photoGalleryAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}
    
#pragma mark - 从本地相册获取图片
- (void)getPhotosFromLocal
{
    
    TZImagePickerController *tzImagePickerVC = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    tzImagePickerVC.allowPickingVideo = NO;

    // 你可以通过block或者代理，来得到用户选择的照片.
    [tzImagePickerVC setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        if (photos.count > 0) {
            for (UIImage *image in photos) {
                //对图片进行压缩处理
                if (isSelectOriginalPhoto) {
                    [self requestUploadAttachment:image];
                }
                else {
                    UIImage *imageCompress = [Tools compressImageWithImage:image ScalePercent:0.05];
                    [self requestUploadAttachment:imageCompress];
                }
            }
        }
        
        
        
    }];
    
    [self presentViewController:tzImagePickerVC animated:YES completion:nil];
    
}

#pragma mark - 从相机中获取图片
- (void)getPhotosFromCamera
{
    AVAuthorizationStatus AVstatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];//相机权限
    
    switch (AVstatus) {
        case AVAuthorizationStatusAuthorized:
            DDLogDebug(@"Authorized");
            break;
        case AVAuthorizationStatusDenied:
        {
            DDLogDebug(@"Denied");
            //提示开启相机
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"相机权限已关闭" message:@"请到设置->隐私->相机开启权限" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[UIApplication sharedApplication] openURL:[NSURL  URLWithString:UIApplicationOpenSettingsURLString]];
                
                return ;
            }];
            UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:okAction];
            [alert addAction:cancelAction];
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
            break;
        case AVAuthorizationStatusNotDetermined:
            DDLogDebug(@"not Determined");
            break;
        case AVAuthorizationStatusRestricted:
            DDLogDebug(@"Restricted");
            break;
        default:
            break;
    }
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];
    }
    else {
        NSLog(@"模拟器中无法打开相机，请在真机中使用");
    }
}

#pragma mark - Net
#pragma mark - 更新头像
- (void)requestUploadAttachment:(UIImage *)img {
    
    
    [HTTPTool requestUploadImageToBATWithParams:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        NSData *imageData = UIImagePNGRepresentation(img);
        [formData appendPartWithFileData:imageData
                                    name:[NSString stringWithFormat:@"attachment"]
                                fileName:[NSString stringWithFormat:@"attachment.jpg"]
                                mimeType:@"multipart/form-data"];
    } success:^(NSArray *imageArray) {
        
        [self showSuccessWithText:@"上传证件成功"];
        
        NSMutableArray *imageModelArray = [BATImage mj_objectArrayWithKeyValuesArray:imageArray];
        BATImage *imageModel = [imageModelArray firstObject];
        self.attachment = imageModel.url;
        [self.authenticateView.tableView reloadData];
    } failure:^(NSError *error) {
        
        [self showErrorWithText:@"上传失败"];
        
    } fractionCompleted:^(double count) {
        
        [self showProgres:count];
        
    }];
}

#pragma mark - 医生申请认证
- (void)requestCommitAuditing
{
    [self.view endEditing:YES];
    
    if (self.name.length <= 0) {
        [self showErrorWithText:@"姓名不能为空"];
        return;
    }
    
    if (self.name.length < 2 || self.name.length > 6) {
        [self showErrorWithText:@"姓名长度只能是2-6位"];
        return;
    }
    
    if (![self.name isChinese]) {
        [self showErrorWithText:@"姓名只能是汉字"];
        return;
    }
    
    if (self.IDNumber.length <= 0) {
        [self showErrorWithText:@"身份证不能为空"];
        return;
    }
    
    if (self.IDNumber.length != 18) {
        [self showErrorWithText:@"身份证长度只能是18位"];
        return;
    }
    
    if (self.hospital.length <= 0) {
        [self showErrorWithText:@"医院不能为空"];
        return;
    }
    
    if (self.hospital.length > 20) {
        [self showErrorWithText:@"医院长度最多只能是20个字符"];
        return;
    }
    
    if (self.departmentName.length <= 0) {
        [self showErrorWithText:@"科室不能为空"];
        return;
    }
    
    if (self.doctorTitle.length <= 0) {
        [self showErrorWithText:@"职称不能为空"];
        return;
    }
    
    if (self.city.length <= 0) {
        [self showErrorWithText:@"城市不能为空"];
        return;
    }
    
    if (self.attachment.length <= 0) {
        [self showErrorWithText:@"证件不能为空"];
        return;
    }
    
    [self showProgress];
    
    [HTTPTool requestWithURLString:@"/api/Doctor/CommitAuditing"
                        parameters:@{
                                     @"DoctorName":self.name,
                                     @"IDNumber":self.IDNumber,
                                     @"HospitalName":self.hospital,
                                     @"DepartmentName":self.departmentName,
                                     @"DepartmentID":self.departmentID,
                                     @"TitleType":@(self.titleType),
                                     @"City":self.city,
                                     @"QualificationCertificateImage":self.attachment}
                              type:kPOST
                           success:^(id responseObject) {
                               [self dismissProgress];
                               
                               BATAuthenticateResultViewController *authenticateResultVC = [[BATAuthenticateResultViewController alloc] init];
                               authenticateResultVC.hidesBottomBarWhenPushed = YES;
                               [self.navigationController pushViewController:authenticateResultVC animated:YES];
    } failure:^(NSError *error) {
        [self showErrorWithText:error.localizedDescription];
    }];
}

#pragma mark - pageLayout
- (void)pageLayout
{
    [self.view addSubview:self.authenticateView];
    
    WEAK_SELF(self);
    [self.authenticateView mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - get & set
- (BATAuthenticateView *)authenticateView
{
    if (_authenticateView == nil) {
        _authenticateView = [[BATAuthenticateView alloc] init];
        _authenticateView.tableView.delegate = self;
        _authenticateView.tableView.dataSource = self;
        _authenticateView.sexInputPickerView.delegate = self;
        _authenticateView.titlePickerView.delegate = self;
        _authenticateView.departmentPickerView.delegate = self;
        
        WEAK_SELF(self);
        _authenticateView.footerView.submitAction = ^(){
            STRONG_SELF(self);
            [self requestCommitAuditing];
        };
    }
    return _authenticateView;
}

@end
