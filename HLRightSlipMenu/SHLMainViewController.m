//
//  SHLMainViewController.m
//  HLRightSlipMenu
//
//  Created by hellen on 2017/4/6.
//  Copyright © 2017年 SKYWORTH. All rights reserved.
//

#import "SHLMainViewController.h"
#import "SHLTabbar.h"
#import "SHLHomePageCtrl.h"
#import "SHLMeViewController.h"
#import "SHLNavigationCtrl.h"
@interface SHLMainViewController ()

@end

@implementation SHLMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置tabbar
    [self setValue:[[SHLTabbar alloc] init] forKeyPath:@"tabBar"];
    // 初始化所有的子控制器
    [self setupChildViewControllers];
}


/**
 * 初始化所有的子控制器
 */
- (void)setupChildViewControllers
{
    SHLHomePageCtrl *first = [[SHLHomePageCtrl alloc] init];
    [self setupOneChildViewController:first title:@"first" image:@"tab_device_default" selectedImage:@"tab_device_selected"];
    SHLMeViewController *second = [[SHLMeViewController alloc] init];
    [self setupOneChildViewController:second title:@"two" image:@"tab_personal_default" selectedImage:@"tab_personal_selected"];
    
}
- (void)setupOneChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    [self addChildViewController:[[SHLNavigationCtrl alloc] initWithRootViewController:vc]];
}

+ (void)initialize
{
    UITabBarItem *appearance = [UITabBarItem appearance];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [appearance setTitleTextAttributes:attrs forState:UIControlStateSelected];
}


@end
