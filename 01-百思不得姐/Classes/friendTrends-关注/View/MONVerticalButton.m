//
//  MONVerticalButton.m
//  01-百思不得姐
//
//  Created by DAC on 16-8-11.
//  Copyright (c) 2016年 DAC. All rights reserved.
//

#import "MONVerticalButton.h"

@implementation MONVerticalButton

- (void)setup
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [self setup];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //调整图片
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;
    //调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.width;
    self.titleLabel.width = self.imageView.width;
    self.titleLabel.height = self.height - self.imageView.height;

}

@end
