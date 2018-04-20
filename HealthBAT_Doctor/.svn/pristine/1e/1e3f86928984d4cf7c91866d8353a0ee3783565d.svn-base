//
//  BATDoctorInfoViewController.m
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/17.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import "BATDoctorInfoViewController.h"
#import "BATCustomTableViewCell.h"
#import "BATDoctorInfoAvatarTableViewCell.h"
#import "BATDoctorDetailModel.h"
#import "TZImagePickerController.h"
#import "TZImageManager.h"
#import "NSString+Chinese.h"

@interface BATDoctorInfoViewController () <UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,TZImagePickerControllerDelegate,BATTitlePickerViewDelegate,BATDepartmentPickerViewDelegate>

@property (nonatomic,strong) BATDoctorDetailModel *doctorDetailModel;

@end

@implementation BATDoctorInfoViewController

- (void)dealloc
{
    DDLogDebug(@"%@", self);
}

- (void)loadView
{
    [super loadView];
    
    [self pageLayout];
    
    self.title = @"医生信息";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.doctorInfoView.tableView registerClass:[BATCustomTableViewCell class] forCellReuseIdentifier:@"BATCustomTableViewCell"];
    [self.doctorInfoView.tableView registerClass:[BATDoctorInfoAvatarTableViewCell class] forCellReuseIdentifier:@"BATDoctorInfoAvatarTableViewCell"];
    
    [self requestGetDoctorDetail];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 11;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 100;
    }
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        BATDoctorInfoAvatarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BATDoctorInfoAvatarTableViewCell" forIndexPath:indexPath];
        cell.titleLabel.text = @"头像";
        [cell.avatarImageView sd_setImageWithURL:[NSURL URLWithString:self.doctorDetailModel.Data.DoctorPic] placeholderImage:[UIImage imageNamed:@"icon-nys"]];
        return cell;
    }
    
    BATCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BATCustomTableViewCell" forIndexPath:indexPath];
    
    
    cell.textField.keyboardType = UIKeyboardTypeDefault;
    
    if (indexPath.row == 1) {
        
        cell.titleLabel.text = @"姓名";
        cell.textField.placeholder = @"请输入姓名";
        cell.textField.text = self.doctorDetailModel.Data.DoctorName;
        
    } else if (indexPath.row == 2) {
        cell.titleLabel.text = @"手机";
        cell.textField.placeholder = @"请输入手机";
        cell.textField.keyboardType = UIKeyboardTypePhonePad;
        cell.textField.text = self.doctorDetailModel.Data.PhoneNumber;
        
    } else if (indexPath.row == 3) {
        cell.titleLabel.text = @"微信";
        cell.textField.placeholder = @"请输入微信";
        cell.textField.text = self.doctorDetailModel.Data.WechatNum;
        
    } else if (indexPath.row == 4) {
        cell.titleLabel.text = @"身份证";
        cell.textField.placeholder = @"请输入身份证";
//        cell.textField.inputView = self.doctorInfoView.sexInputPickerView;
        cell.textField.text = self.doctorDetailModel.Data.IDNumber;
        
    } else if (indexPath.row == 5) {
        cell.titleLabel.text = @"职称";
        cell.textField.placeholder = @"请输入职称";
        cell.textField.inputView = self.doctorInfoView.titlePickerView;
        
        cell.textField.text = self.doctorDetailModel.Data.DoctorTitle;
        
    } else if (indexPath.row == 6) {
        cell.titleLabel.text = @"医院";
        cell.textField.placeholder = @"请输入医院";
        cell.textField.text = self.doctorDetailModel.Data.HospitalName;
    } else if (indexPath.row == 7) {
        cell.titleLabel.text = @"科室";
        cell.textField.placeholder = @"请选择科室";
        cell.textField.text = self.doctorDetailModel.Data.DepartmentName;
        cell.textField.inputView = self.doctorInfoView.departmentPickerView;
    } else if (indexPath.row == 8) {
        cell.titleLabel.text = @"城市";
        cell.textField.placeholder = @"请输入城市";
        cell.textField.text = self.doctorDetailModel.Data.City;
    } else if (indexPath.row == 9) {
        cell.titleLabel.text = @"擅长";
        cell.textField.placeholder = @"字数限制80个";
        cell.textField.text = self.doctorDetailModel.Data.GoodAt;
    } else if (indexPath.row == 10) {
        cell.titleLabel.text = @"简介";
        cell.textField.placeholder = @"字数限制50个";
        cell.textField.text = self.doctorDetailModel.Data.DoctorDesc;
    }
    
    if (indexPath.row == 1
        || indexPath.row == 2
        || indexPath.row == 3
        || indexPath.row == 4
        || indexPath.row == 5
        || indexPath.row == 6
//        || indexPath.row == 7
        || indexPath.row == 8
        || indexPath.row == 9
        || indexPath.row == 10) {
        
        WEAK_SELF(self);
        cell.textInput = ^(NSString *text, NSIndexPath *cellIndexPath) {
            DDLogDebug(@"text %@ indexPath %@",text,cellIndexPath);
            STRONG_SELF(self);
            
            if (indexPath.row == 1) {
                //姓名
                self.doctorDetailModel.Data.DoctorName = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];;
            } else if (indexPath.row == 2) {
                //手机
                self.doctorDetailModel.Data.PhoneNumber = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];;
            } else if (indexPath.row == 3) {
                //微信
                self.doctorDetailModel.Data.WechatNum = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];;
            } else if (indexPath.row == 4) {
                //身份证
                self.doctorDetailModel.Data.IDNumber = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];;
            } else if (indexPath.row == 6) {
                //医院
                self.doctorDetailModel.Data.HospitalName = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];;
            }
//            else if (indexPath.row == 7) {
//                //科室
//                self.doctorDetailModel.Data.DepartmentName = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];;
//            }
            else if (indexPath.row == 8) {
                //城市
                self.doctorDetailModel.Data.City = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];;
            } else if (indexPath.row == 9) {
                //擅长
                self.doctorDetailModel.Data.GoodAt = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];;
            } else if (indexPath.row == 10) {
                //简介
                self.doctorDetailModel.Data.DoctorDesc = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];;
            }
            
            
        };
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        //头像
        
        [self takePic];
        
    }
}

#pragma mark - BATTitlePickerViewDelegate
- (void)BATTitlePickerView:(BATTitlePickerView *)titlePickerView didSelectRow:(NSInteger)row titleForRow:(NSString *)title
{
    self.doctorDetailModel.Data.DoctorTitle = title;
    self.doctorDetailModel.Data.TitleType = row;
    [self.doctorInfoView.tableView reloadData];
}

#pragma mark - BATDepartmentPickerViewDelegate
- (void)BATDepartmentPickerView:(BATDepartmentPickerView *)departmentPickerView didSelectRow:(NSInteger)row departmentForRow:(NSDictionary *)department
{
    
    self.doctorDetailModel.Data.DepartmentID = department[@"ID"];
    self.doctorDetailModel.Data.DepartmentName = department[@"departmentName"];
    
    [self.doctorInfoView.tableView reloadData];
    
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
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
    
//    TZImagePickerController *tzImagePickerVC = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
//    tzImagePickerVC.allowPickingVideo = NO;
//    
//    // 你可以通过block或者代理，来得到用户选择的照片.
//    [tzImagePickerVC setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
//        if (photos.count > 0) {
//            for (UIImage *image in photos) {
//                //对图片进行压缩处理
//                if (isSelectOriginalPhoto) {
//                    [self requestUploadAttachment:image];
//                }
//                else {
//                    UIImage *imageCompress = [Tools compressImageWithImage:image ScalePercent:0.05];
//                    [self requestUploadAttachment:imageCompress];
//                }
//            }
//        }
//        
//        
//        
//    }];
//    
//    [self presentViewController:tzImagePickerVC animated:YES completion:nil];
    
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
        
        [self showSuccessWithText:@"上传头像成功"];
        
        NSMutableArray *imageModelArray = [BATImage mj_objectArrayWithKeyValuesArray:imageArray];
        BATImage *imageModel = [imageModelArray firstObject];
        self.doctorDetailModel.Data.DoctorPic = imageModel.url;
        [self.doctorInfoView.tableView reloadData];
    } failure:^(NSError *error) {
        
        [self showErrorWithText:@"上传失败"];
        
    } fractionCompleted:^(double count) {
        
        [self showProgres:count];
        
    }];
}

- (void)requestGetDoctorDetail
{
    
    [self showProgress];
    
    [HTTPTool requestWithURLString:@"/api/Doctor/GetDoctorDetail" parameters:nil type:kGET success:^(id responseObject) {
        
        [self dismissProgress];
        
        self.doctorDetailModel = [BATDoctorDetailModel mj_objectWithKeyValues:responseObject];
        
        [self.doctorInfoView.tableView reloadData];
        
        //保存医生信息
        NSString *file = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/DoctorDetail.data"];
        [NSKeyedArchiver archiveRootObject:self.doctorDetailModel toFile:file];
        
        
    } failure:^(NSError *error) {
        [self showErrorWithText:error.localizedDescription];
    }];
}

#pragma mark - 编辑医生个人信息
- (void)requestEditDoctorInfo
{
 
    if (self.doctorDetailModel.Data.DoctorName.length <= 0) {
        [self showErrorWithText:@"姓名不能为空"];
        return;
    }
    
    if (self.doctorDetailModel.Data.DoctorName.length < 2 || self.doctorDetailModel.Data.DoctorName.length > 6) {
        [self showErrorWithText:@"姓名长度只能是2-6个字符"];
        return;
    }
    
    if (![self.doctorDetailModel.Data.DoctorName isChinese]) {
        [self showErrorWithText:@"姓名只能是汉字"];
        return;
    }
    
    if (self.doctorDetailModel.Data.PhoneNumber.length <= 0) {
        [self showErrorWithText:@"手机不能为空"];
        return;
    }
    
    if (self.doctorDetailModel.Data.PhoneNumber.length != 11) {
        [self showErrorWithText:@"手机长度只能是11位"];
        return;
    }
    
    if (self.doctorDetailModel.Data.IDNumber.length <= 0) {
        [self showErrorWithText:@"身份证不能为空"];
        return;
    }
    
    if (self.doctorDetailModel.Data.IDNumber.length != 18) {
        [self showErrorWithText:@"身份证长度只能是18位"];
        return;
    }
    
    if (self.doctorDetailModel.Data.DoctorTitle.length <= 0) {
        [self showErrorWithText:@"职称不能为空"];
        return;
    }
    
    if (self.doctorDetailModel.Data.HospitalName.length <= 0) {
        [self showErrorWithText:@"医院不能为空"];
        return;
    }
    
    if (self.doctorDetailModel.Data.HospitalName.length > 20) {
        [self showErrorWithText:@"医院长度最多只能是20个字符"];
        return;
    }
    
    if (self.doctorDetailModel.Data.DepartmentName.length <= 0) {
        [self showErrorWithText:@"科室不能为空"];
        return;
    }
    
    if (self.doctorDetailModel.Data.City.length <= 0) {
        [self showErrorWithText:@"城市不能为空"];
        return;
    }
    
    if (self.doctorDetailModel.Data.GoodAt.length <= 0) {
        [self showErrorWithText:@"擅长不能为空"];
        return;
    }
    
    if (self.doctorDetailModel.Data.GoodAt.length > 80) {
        [self showErrorWithText:@"擅长长度最多只能是80个字符"];
        return;
    }
    
    if (self.doctorDetailModel.Data.DoctorDesc.length > 80) {
        [self showErrorWithText:@"简介长度最多只能是50个字符"];
        return;
    }
    
    [self showProgress];
    [HTTPTool requestWithURLString:@"/api/Doctor/EditDoctorInfo"
                        parameters:@{@"ID":self.doctorDetailModel.Data.ID,
                                     @"DoctorName":self.doctorDetailModel.Data.DoctorName,
                                     @"IDNumber":self.doctorDetailModel.Data.IDNumber,
                                     @"PhoneNumber":self.doctorDetailModel.Data.PhoneNumber,
                                     @"HospitalName":self.doctorDetailModel.Data.HospitalName,
                                     @"DepartmentName":self.doctorDetailModel.Data.DepartmentName,
                                     @"DepartmentID":self.doctorDetailModel.Data.DepartmentID,
                                     @"TitleType":@(self.doctorDetailModel.Data.TitleType),
                                     @"City":self.doctorDetailModel.Data.City,
                                     @"DoctorPic":self.doctorDetailModel.Data.DoctorPic,
                                     @"GoodAt":self.doctorDetailModel.Data.GoodAt,
                                     @"DoctorDesc":self.doctorDetailModel.Data.DoctorDesc,
                                     @"WechatNum":self.doctorDetailModel.Data.WechatNum}
                              type:kPOST
                           success:^(id responseObject) {
                
                               [self showSuccessWithText:@"修改信息成功"];
                               [self.doctorInfoView.tableView reloadData];
        
    } failure:^(NSError *error) {
         [self showErrorWithText:error.localizedDescription];
    }];
}

#pragma mark - pageLayout
- (void)pageLayout
{
    [self.view addSubview:self.doctorInfoView];
    
    WEAK_SELF(self);
    [self.doctorInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - get & set
- (BATDoctorPersonalInfoView *)doctorInfoView
{
    if (_doctorInfoView == nil) {
        _doctorInfoView = [[BATDoctorPersonalInfoView alloc] init];
        _doctorInfoView.tableView.delegate = self;
        _doctorInfoView.tableView.dataSource = self;
        _doctorInfoView.titlePickerView.delegate = self;
        _doctorInfoView.departmentPickerView.delegate = self;
        
        WEAK_SELF(self);
        _doctorInfoView.footerView.doctorInfoFooterConfirmBlock = ^(){
            STRONG_SELF(self);
            [self requestEditDoctorInfo];
        };
    }
    return _doctorInfoView;
}

@end
