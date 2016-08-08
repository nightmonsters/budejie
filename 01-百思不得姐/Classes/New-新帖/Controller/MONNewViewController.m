//
//  MONNewViewController.m
//  01-百思不得姐
//
//  Created by DAC on 16-8-1.
//  Copyright (c) 2016年 DAC. All rights reserved.
//

#import "MONNewViewController.h"

@interface MONNewViewController ()

@end

@implementation MONNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   //设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    //设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    //设置背景色
    self.view.backgroundColor = MONGlobalBg;
}

- (void)tagClick
{
   MONLogFunc;
}


@end
