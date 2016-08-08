//
//  UIBarButtonItem+MONExtension.h
//  01-百思不得姐
//
//  Created by DAC on 16-8-4.
//  Copyright (c) 2016年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (MONExtension)
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;
@end
