//
//  UIBarButtonItem+MONExtension.m
//  01-百思不得姐
//
//  Created by DAC on 16-8-4.
//  Copyright (c) 2016年 DAC. All rights reserved.
//

#import "UIBarButtonItem+MONExtension.h"

@implementation UIBarButtonItem (MONExtension)
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;
{
    UIButton *Button = [UIButton buttonWithType:UIButtonTypeCustom];
    [Button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [Button setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    //设置导航栏左边按钮的size
    Button.size = Button.currentBackgroundImage.size;
    [Button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:Button];
}
@end
