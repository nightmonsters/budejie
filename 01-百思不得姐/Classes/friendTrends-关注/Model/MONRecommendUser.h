//
//  MONRecommendUser.h
//  01-百思不得姐
//
//  Created by DAC on 16-8-8.
//  Copyright (c) 2016年 DAC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MONRecommendUser : NSObject
/** 头像 */
@property (nonatomic,copy) NSString *header;
/** 粉丝数 */
@property (nonatomic,assign) NSInteger fans_count;
/** 昵称 */
@property (nonatomic,copy) NSString *screen_name;
@end
