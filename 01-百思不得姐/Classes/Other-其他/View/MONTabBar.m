//
//  MONTabBar.m
//  01-百思不得姐
//
//  Created by DAC on 16-8-1.
//  Copyright (c) 2016年 DAC. All rights reserved.
//

#import "MONTabBar.h"

@interface MONTabBar()
/** 发布按钮 */
@property (nonatomic,weak) UIButton *publishButton;
@end

@implementation MONTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        //设置tabBar的背景图片
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
        //添加发布图片
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        publishButton.size = publishButton.currentBackgroundImage.size;
        
        [self addSubview:publishButton];
        self.publishButton = publishButton;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat width = self.width;
    CGFloat height = self.height;
    self.publishButton.center = CGPointMake(width * 0.5, height * 0.5);
    
    //设置其他UITabBarButton的frame
    CGFloat buttonY = 0;
    CGFloat buttonW = width / 5;
    CGFloat buttonH = height;
    NSInteger index = 0;
    
    for (UIView *button in self.subviews) {
        if (![button isKindOfClass:[UIControl class]] || button == self.publishButton) continue;
            //计算按钮的X值
            CGFloat buttonX = buttonW * ((index > 1)?(index + 1):index);
            //增加索引
            index++;
            button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    }
}

@end
