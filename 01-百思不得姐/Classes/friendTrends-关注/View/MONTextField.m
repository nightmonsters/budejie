//
//  MONTextField.m
//  01-百思不得姐
//
//  Created by DAC on 16-8-12.
//  Copyright (c) 2016年 DAC. All rights reserved.
//

#import "MONTextField.h"
#import <objc/runtime.h>

static NSString * const MONPlacerholderColorKeyPath = @"_placeholderLabel.textColor";
@implementation MONTextField


+ (void)initialize
{
    
    
    
//runtime拿到所有的成员变量列表
//    unsigned int count = 0;
//    Ivar *ivars = class_copyIvarList([UITextField class], &count);
//    for (int i = 0; i<count; i++) {
//        
//        Ivar ivar = ivars[i];
//        MONLog(@"%s <----> %s",ivar_getName(ivar),ivar_getTypeEncoding(ivar));
//    }
//    free(ivars);
}

- (void)awakeFromNib
{
    //修改占位文字颜色
    //UILabel *placeholderLabel = [self valueForKeyPath:@"_placeholderLabel"];
    //placeholderLabel.textColor = [UIColor redColor];
    
    //修改占位文字颜色
    //[self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    //设置光标颜色和文字颜色一致
    self.tintColor = self.textColor;
    //不成为第一响应者
    [self resignFirstResponder];
}
//成为第一响应者,当前文本框聚焦时就会调用
- (BOOL)becomeFirstResponder
{
    //修改占位文字颜色
    [self setValue:self.textColor forKeyPath:MONPlacerholderColorKeyPath];
    return [super becomeFirstResponder];
}
//放弃第一响应者，当前文本框失去焦点时就会调用
- (BOOL)resignFirstResponder
{
    //修改占位文字颜色
    [self setValue:[UIColor grayColor] forKeyPath:MONPlacerholderColorKeyPath];

    return [super resignFirstResponder];
}

//- (void)setPlaceholderColor:(UIColor *)placeholderColor
//{
//    _placeholderColor = placeholderColor;
//    
//    //修改占位文字颜色
//    [self setValue:placeholderColor forKeyPath:MONPlacerholderColorKeyPath];
//}

@end
