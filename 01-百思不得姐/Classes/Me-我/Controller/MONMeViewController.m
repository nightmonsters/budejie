//
//  MONMeViewController.m
//  01-百思不得姐
//
//  Created by DAC on 16-8-1.
//  Copyright (c) 2016年 DAC. All rights reserved.
//

#import "MONMeViewController.h"

@interface MONMeViewController ()

@end

@implementation MONMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏标题
    self.navigationItem.title = @"我的";
    
    //设置导航栏右边按钮
    UIBarButtonItem *settingButton = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    
    UIBarButtonItem *moonButton = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    
    self.navigationItem.rightBarButtonItems = @[settingButton,moonButton];
    
    //设置背景色
    self.view.backgroundColor = MONGlobalBg;
}

- (void)settingClick
{
    MONLogFunc;
}

- (void)moonClick
{
    MONLogFunc;
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
