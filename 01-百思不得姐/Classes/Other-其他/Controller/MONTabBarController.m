//
//  MONTabBarController.m
//  01-百思不得姐
//
//  Created by DAC on 16-8-1.
//  Copyright (c) 2016年 DAC. All rights reserved.
//

#import "MONTabBarController.h"
#import "MONEssenceViewController.h"
#import "MONNewViewController.h"
#import "MONFriendTrendsViewController.h"
#import "MONMeViewController.h"
#import "MONTabBar.h"
#import "MONNavigationController.h"

@interface MONTabBarController ()

@end

@implementation MONTabBarController

+ (void)initialize
{
    //通过appearance统一设置所有UITabBarItem的文字属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectAttrs = [NSMutableDictionary dictionary];
    selectAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    selectAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectAttrs forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
   
    //添加子控制器
    [self setupChildVc:[[MONEssenceViewController alloc] init] title: @"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    [self setupChildVc:[[MONNewViewController alloc] init]title: @"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
    [self setupChildVc:[[MONFriendTrendsViewController alloc] init] title: @"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    
    [self setupChildVc:[[MONMeViewController alloc] init] title: @"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
    //更换自定义的tabBar
    //self.tabBar = [[MONTabBar alloc] init];
    [self setValue:[[MONTabBar alloc] init] forKey:@"tabBar"];
    

}

- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    //UIViewController *vc = [[UIViewController alloc] init];
    //设置文字和图片
    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
    //设置背景色
    //vc.view.backgroundColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0];
    
    //添加为子控制器
    //[self addChildViewController:vc];
    //包装一个导航控制器，添加导航控制器为tabBarController的子控制器
    MONNavigationController *nav = [[MONNavigationController alloc] initWithRootViewController:vc];
    
    [self addChildViewController:nav];
}

@end
