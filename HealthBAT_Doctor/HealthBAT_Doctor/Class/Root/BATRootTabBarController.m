//
//  BATRootTabBarController.m
//  HealthBAT_Doctor
//
//  Created by cjl on 2017/4/11.
//  Copyright © 2017年 KM. All rights reserved.
//

#import "BATRootTabBarController.h"
#import "BATDoctorStudioViewController.h"
#import "BATListeninDoctorController.h"
#import "BATMeViewController.h"
#import "BATTrainViewController.h"

@interface BATRootTabBarController () <UITabBarControllerDelegate>

@end

@implementation BATRootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"首页";
    [self setupViewControllers];
    self.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupViewControllers{
    
    BATDoctorStudioViewController *doctorStudioVC = [BATDoctorStudioViewController new];
    UINavigationController * doctorStudioNav = [[UINavigationController alloc] initWithRootViewController:doctorStudioVC];
    
    BATListeninDoctorController *doctorGroupVC = [BATListeninDoctorController new];
    UINavigationController *doctorGroupNav = [[UINavigationController alloc] initWithRootViewController:doctorGroupVC];
    
    BATMeViewController * meVC = [BATMeViewController new];
    UINavigationController * meNav = [[UINavigationController alloc] initWithRootViewController:meVC];
    
    self.viewControllers = @[doctorStudioNav, doctorGroupNav, meNav];
    
    [self customizeTabBarForController];
    
}

- (void)customizeTabBarForController
{
    //选项卡图片
    NSArray *tabBarItemImages = @[@"home", @"ysq", @"wd"];
    //选项卡标题
    NSArray *tabBarItemTitles = @[@"首页", @"医生圈", @"我的"];
    NSInteger index = 0;
    for (UIViewController * vc in self.viewControllers) {
        
        UITabBarItem * item = vc.tabBarItem;
        
        item.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@_select",[tabBarItemImages objectAtIndex:index]]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
        item.image = [[UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",[tabBarItemImages objectAtIndex:index]]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.title = [tabBarItemTitles objectAtIndex:index];
        [item setTitleTextAttributes:@{
                                       NSFontAttributeName: [UIFont boldSystemFontOfSize:12],
                                       NSForegroundColorAttributeName:UIColorFromRGB(108, 108, 108, 1),
                                       }
                            forState:UIControlStateNormal];
        [item setTitleTextAttributes:@{
                                       NSFontAttributeName: [UIFont boldSystemFontOfSize:12],
                                       NSForegroundColorAttributeName:BASE_COLOR,
                                       }
                            forState:UIControlStateSelected];
        index ++;
    }
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    return YES;
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
