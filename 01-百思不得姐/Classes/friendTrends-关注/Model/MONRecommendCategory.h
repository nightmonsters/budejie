//
//  MONRecommendCategory.h
//  01-百思不得姐
//
//  Created by DAC on 16-8-5.
//  Copyright (c) 2016年 DAC. All rights reserved.
//  推荐关注左边的数据模型

#import <Foundation/Foundation.h>

@interface MONRecommendCategory : NSObject
/** id */
@property (nonatomic,assign) NSInteger id;
/** 总数 */
@property (nonatomic,assign) NSInteger count;
/** 名字 */
@property (nonatomic,copy) NSString *name;

/** 这个类别对应的用户数据 */
@property (nonatomic,strong) NSMutableArray *users;
/** 总数 */
@property (nonatomic,assign) NSInteger total;
/** 当前页码 */
@property (nonatomic,assign) NSInteger currentPage;

@end
