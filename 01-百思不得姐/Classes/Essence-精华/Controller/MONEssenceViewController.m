//
//  MONEssenceViewController.m
//  01-百思不得姐
//
//  Created by DAC on 16-8-1.
//  Copyright (c) 2016年 DAC. All rights reserved.
//

#import "MONEssenceViewController.h"
#import "MONRecommendTagsViewController.h"
#import "MONTopicViewController.h"

@interface MONEssenceViewController() <UIScrollViewDelegate>
/** 标签栏底部的红色指示器 */
@property (nonatomic,weak) UIView *indicatorView;
/** 当前选中的按钮 */
@property (nonatomic,weak) UIButton *selectedButton;
/** 顶部的所有标签 */
@property (nonatomic,weak) UIView *titlesView;
/** 底部的所有内容 */
@property (nonatomic,weak) UIScrollView *contentView;
@end

@implementation MONEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [self setupNav];
    
    //初始化子控制器
    [self setupChildVces];
    
    //设置顶部的标签栏
    [self setupTitlesView];
    
    //设置底部的栏目
    [self setupContentView];
    
}
/**
 *初始化子控制器
 */
- (void)setupChildVces
{
    MONTopicViewController *word = [[MONTopicViewController alloc] init];
    word.title = @"段子";
    word.type = MONTopicTypeWord;
    [self addChildViewController:word];
    
    MONTopicViewController *all = [[MONTopicViewController alloc] init];
    all.title = @"全部";
    all.type = MONTopicTypeAll;
    [self addChildViewController:all];
    
    MONTopicViewController *picture = [[MONTopicViewController alloc] init];
    picture.title = @"图片";
    picture.type = MONTopicTypePicture;
    [self addChildViewController:picture];
    
    MONTopicViewController *video = [[MONTopicViewController alloc] init];
    video.title = @"视频";
    video.type = MONTopicTypeVideo;
    [self addChildViewController:video];
    
    MONTopicViewController *voice = [[MONTopicViewController alloc] init];
    voice.title = @"音频";
    voice.type = MONTopicTypeVoice;
    [self addChildViewController:voice];
    
}

/**
 *设置底部scrollView
 */
- (void)setupContentView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    //设置内边距
    //CGFloat bottom = self.tabBarController.tabBar.height;
    //CGFloat top = CGRectGetMaxY(self.titlesView.frame);
    //contentView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    self.contentView = contentView;
    
    [self scrollViewDidEndScrollingAnimation:contentView];
}

/**
 *设置顶部的标签栏
 */
- (void)setupTitlesView
{
    
    //标签栏整体
    UIScrollView *titlesView = [[UIScrollView alloc] init];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    titlesView.width = self.view.width;
    titlesView.height = 35;
    titlesView.y = 64;
    
    titlesView.showsHorizontalScrollIndicator = false;
    //titlesView.showsVerticalScrollIndicator = false;
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    
    //底部的红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    //indicatorView.width = titlesView.width;
    indicatorView.tag = -1;
    indicatorView.y = titlesView.height - indicatorView.height;
    [titlesView addSubview:indicatorView];
    
    self.indicatorView = indicatorView;
    
    //内部的子标签
    //NSArray *titles = @[@"全部",@"图片",@"段子",@"音频",@"视频",@"网红",@"排行",@"社会",@"美女",@"冷知识",@"游戏"];
    for (NSInteger i = 0; i<self.childViewControllers.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        button.height = titlesView.height;
        button.width = titlesView.width / 5;
        button.x = i * button.width;
        
        UIViewController *vc = self.childViewControllers[i];
        [button setTitle:vc.title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button layoutIfNeeded];
        
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        
        titlesView.contentSize = CGSizeMake((i + 1) * button.width, 0);
        [titlesView addSubview:button];
        
        //默认点击了第一个按钮
        if (i == 0) {
            button.enabled = NO;
            self.selectedButton = button;
            //[button sizeToFit];
            self.indicatorView.width = button.titleLabel.width;
            self.indicatorView.centerX = button.centerX;
        }
    }
}

- (void)titleClick:(UIButton *)button
{
    //修改按钮状态
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    
    //动画
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];
    //滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
//    CGPoint center = self.indicatorView.center;
//    center.x = button.center.x;
//    self.indicatorView.center = center;
    
}

/**
 *设置导航栏的内容
 */
- (void)setupNav
{
    //设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    //设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick-click" target:self action:@selector(tagClick)];
    
    //设置背景色
    self.view.backgroundColor = MONGlobalBg;
}

- (void)tagClick
{
    MONRecommendTagsViewController *tags = [[MONRecommendTagsViewController alloc] init];
    [self.navigationController pushViewController:tags animated:YES];
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    //当前索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    //取出子控制器
    UIViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0;
    vc.view.height = scrollView.height;
    
    [scrollView addSubview:vc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    //点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titleClick:self.titlesView.subviews[index]];
}

@end
