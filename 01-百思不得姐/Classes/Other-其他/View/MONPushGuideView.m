//
//  MONPushGuideView.m
//  01-百思不得姐
//
//  Created by DAC on 16-8-12.
//  Copyright (c) 2016年 DAC. All rights reserved.
//

#import "MONPushGuideView.h"

@implementation MONPushGuideView

+ (void)show
{
    NSString *key = @"CFBundleShortVersionString";
    //获得当前软件的版本号
    NSString *currentVersion= [NSBundle mainBundle].infoDictionary[key];
    
    //获得沙盒中存储的版本号
    NSString *sanboxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    
    if (![currentVersion isEqualToString:sanboxVersion]) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        MONPushGuideView *guideView = [MONPushGuideView guideView];
        guideView.frame = window.bounds;
        [window addSubview:guideView];
        
        //存储版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
+ (instancetype)guideView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
- (IBAction)close {
    [self removeFromSuperview];
}

@end
