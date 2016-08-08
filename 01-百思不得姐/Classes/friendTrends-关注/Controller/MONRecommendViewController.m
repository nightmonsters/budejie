//
//  MONRecommendViewController.m
//  01-百思不得姐
//
//  Created by DAC on 16-8-5.
//  Copyright (c) 2016年 DAC. All rights reserved.
//

#import "MONRecommendViewController.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "MONRecommendCategoryCell.h"
#import "MJExtension.h"
#import "MONRecommendCategory.h"

@interface MONRecommendViewController ()<UITableViewDataSource,UITableViewDelegate>
/** 左边的类别数据 */
@property (nonatomic,strong) NSArray *categories;
/** 左边的类别表格 */
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@end

@implementation MONRecommendViewController

static NSString * const MONCategoryID = @"category";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([MONRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:MONCategoryID];
    
    self.navigationItem.title = @"推荐关注";
    
    //设置背景色
    self.view.backgroundColor = MONGlobalBg;
    
    //显示指示器
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    //发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //隐藏指示器
        [SVProgressHUD dismiss];
        
        //服务器返回的JSON数据
        self.categories = [MONRecommendCategory objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //刷新表格
        [self.categoryTableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //隐藏指示器
        //[SVProgressHUD dismiss];
        //显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载信息失败"];
    }];
}

#pragma mark -<UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.categories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MONRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:MONCategoryID];
    
    cell.category = self.categories[indexPath.row];
    //MONLog(@"%@",cell.category);
    return cell;
}

@end
