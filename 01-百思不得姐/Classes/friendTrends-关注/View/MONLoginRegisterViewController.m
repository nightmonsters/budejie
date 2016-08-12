//
//  MONLoginRegisterViewController.m
//  01-百思不得姐
//
//  Created by DAC on 16-8-11.
//  Copyright (c) 2016年 DAC. All rights reserved.
//

#import "MONLoginRegisterViewController.h"

@interface MONLoginRegisterViewController ()
/** 登录框距离控制器view左边的间距 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftMargin;

@end

@implementation MONLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
}
- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)showLoginOrRegister:(UIButton *)button {
    //退出键盘
    [self.view endEditing:YES];
    if (self.loginViewLeftMargin.constant == 0) {
        self.loginViewLeftMargin.constant = - self.view.width;
        [button setTitle:@"已有账号？" forState:UIControlStateNormal];
    } else {
        self.loginViewLeftMargin.constant = 0;
        [button setTitle:@"注册账号" forState:UIControlStateNormal];
    }
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    }];
}

/**
 *让当前控制器对应的状态栏是白色
 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
