//
//  MONRecommendUserCell.m
//  01-百思不得姐
//
//  Created by DAC on 16-8-8.
//  Copyright (c) 2016年 DAC. All rights reserved.
//

#import "MONRecommendUserCell.h"
#import "MONRecommendUser.h"
#import "UIImageView+WebCache.h"

@interface MONRecommendUserCell()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageview;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;

@end

@implementation MONRecommendUserCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setUser:(MONRecommendUser *)user
{
    _user = user;
    
    self.screenNameLabel.text = user.screen_name;
    self.fansCountLabel.text = [NSString stringWithFormat:@"%zd人关注",user.fans_count];
    [self.headerImageview sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}

@end
