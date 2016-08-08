//
//  MONRecommendCategoryCell.m
//  01-百思不得姐
//
//  Created by DAC on 16-8-5.
//  Copyright (c) 2016年 DAC. All rights reserved.
//

#import "MONRecommendCategoryCell.h"
#import "MONRecommendCategory.h"

@implementation MONRecommendCategoryCell

- (void)awakeFromNib {
    
}

- (void)setCategory:(MONRecommendCategory *)category
{
    _category = category;
    self.textLabel.text = category.name;
}

@end
