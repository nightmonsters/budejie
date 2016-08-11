//
//  MONRecommendTags.h
//  01-百思不得姐
//
//  Created by DAC on 16-8-11.
//  Copyright (c) 2016年 DAC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MONRecommendTags : NSObject
/** 头像 */
@property (nonatomic,copy) NSString *image_list;
/** 名字 */
@property (nonatomic,copy) NSString *theme_name;
/** 订阅数 */
@property (nonatomic,assign) NSInteger sub_number;
@end
