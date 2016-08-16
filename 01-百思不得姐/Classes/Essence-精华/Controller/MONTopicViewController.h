//
//  MONTopicViewController.h
//  01-百思不得姐
//
//  Created by DAC on 16-8-15.
//  Copyright (c) 2016年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  enum{
    MONTopicTypeAll = 1,
    MONTopicTypePicture = 10,
    MONTopicTypeWord = 29,
    MONTopicTypeVoice = 31,
    MONTopicTypeVideo = 41
}MonTopicType;

@interface MONTopicViewController : UITableViewController
/** 帖子类型 */
@property (nonatomic,assign) MonTopicType type;
@end
