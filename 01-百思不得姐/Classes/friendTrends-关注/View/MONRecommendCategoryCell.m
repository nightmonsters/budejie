//
//  MONRecommendCategoryCell.m
//  01-百思不得姐
//
//  Created by DAC on 16-8-5.
//  Copyright (c) 2016年 DAC. All rights reserved.
//

#import "MONRecommendCategoryCell.h"
#import "MONRecommendCategory.h"

@interface MONRecommendCategoryCell()
/** 选中时显示的指示器控件*/
@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;

@end

@implementation MONRecommendCategoryCell

- (void)awakeFromNib {
    self.backgroundColor = MONRGBColor(244, 244, 244);
//    self.textLabel.textColor = MONRGBColor(78, 78, 78);
}

- (void)setCategory:(MONRecommendCategory *)category
{
    _category = category;
    self.textLabel.text = category.name;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 2 * self.textLabel.y;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    self.selectedIndicator.hidden = !selected;
    self.textLabel.textColor = selected ? MONRGBColor(219, 21, 26):MONRGBColor(78, 78, 78);
}

@end
