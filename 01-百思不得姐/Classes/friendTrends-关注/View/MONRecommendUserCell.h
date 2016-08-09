//
//  MONRecommendUserCell.h
//  01-百思不得姐
//
//  Created by DAC on 16-8-8.
//  Copyright (c) 2016年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MONRecommendUser;

@interface MONRecommendUserCell : UITableViewCell
/** 用户模型 */
@property (nonatomic,strong) MONRecommendUser *user;
@end
