//
//  MONFriendTrendsViewController.m
//  01-百思不得姐
//
//  Created by DAC on 16-8-1.
//  Copyright (c) 2016年 DAC. All rights reserved.
//

#import "MONFriendTrendsViewController.h"
#import "MONRecommendViewController.h"
#import "MONLoginRegisterViewController.h"

@interface MONFriendTrendsViewController ()

@end

@implementation MONFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏标题
    self.navigationItem.title = @"我的关注";
    
    //设置导航栏左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsClick)];
    
    //设置背景色
    self.view.backgroundColor = MONGlobalBg;
}

- (void)friendsClick
{
    MONRecommendViewController *vc = [[MONRecommendViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)loginRegister {
    MONLoginRegisterViewController *login = [[MONLoginRegisterViewController alloc] init];
    [self presentViewController:login animated:YES completion:nil];
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
