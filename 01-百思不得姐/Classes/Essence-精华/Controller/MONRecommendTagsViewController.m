//
//  MONRecommendTagsViewController.m
//  01-百思不得姐
//
//  Created by DAC on 16-8-11.
//  Copyright (c) 2016年 DAC. All rights reserved.
//

#import "MONRecommendTagsViewController.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "MONRecommendTags.h"
#import "MONRecommendTagsCell.h"
#import "MJExtension.h"

@interface MONRecommendTagsViewController ()
/** 标签数据 */
@property (nonatomic,strong) NSArray *tags;
@end

@implementation MONRecommendTagsViewController
static NSString * const MONTagsId = @"tags";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    [self loadTags];
}

- (void)loadTags
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    //请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    //发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        self.tags = [MONRecommendTags objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载标签信息失败"];
    }];
}

- (void)setupTableView
{
    //注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MONRecommendTagsCell class]) bundle:nil] forCellReuseIdentifier:MONTagsId];
    
    self.tableView.rowHeight = 70;
    self.navigationItem.title = @"推荐订阅";
    self.tableView.backgroundColor = MONGlobalBg;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.tags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MONRecommendTagsCell *cell = [tableView dequeueReusableCellWithIdentifier:MONTagsId];
    
    cell.recommengTag = self.tags[indexPath.row];
    
    return cell;
}


@end
