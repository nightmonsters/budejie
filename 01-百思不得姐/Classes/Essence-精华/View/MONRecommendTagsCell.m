//
//  MONRecommendTagsCell.m
//  01-百思不得姐
//
//  Created by DAC on 16-8-11.
//  Copyright (c) 2016年 DAC. All rights reserved.
//

#import "MONRecommendTagsCell.h"
#import "MONRecommendTags.h"
#import "UIImageView+WebCache.h"

@interface MONRecommendTagsCell()
@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageListView;
@end

@implementation MONRecommendTagsCell

- (void)awakeFromNib {
    
}
- (void)setRecommengTag:(MONRecommendTags *)recommengTag
{
    _recommengTag = recommengTag;
    
    self.themeNameLabel.text = recommengTag.theme_name;
    NSString *subnumber = nil;
    if (recommengTag.sub_number < 10000) {
        subnumber = [NSString stringWithFormat:@"%zd人订阅",recommengTag.sub_number];
    } else {
        subnumber = [NSString stringWithFormat:@"%.1f万人订阅",recommengTag.sub_number / 10000.0];
    }
    self.subNumberLabel.text = subnumber;
    [self.imageListView sd_setImageWithURL:[NSURL URLWithString:recommengTag.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x = 5;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 1;
    [super setFrame:frame];
}

@end
