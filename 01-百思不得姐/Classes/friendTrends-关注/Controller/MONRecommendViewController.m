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
#import "MONRecommendUserCell.h"
#import "MONRecommendUser.h"

@interface MONRecommendViewController () <UITableViewDataSource,UITableViewDelegate>
/** 左边的类别数据 */
@property (nonatomic,strong) NSArray *categories;
/** 右边的类别数据 */
//@property (nonatomic,strong) NSArray *users;
/** 左边的类别表格 */
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
/** 右侧的用户表格 */
@property (weak, nonatomic) IBOutlet UITableView *userTableView;
@end

@implementation MONRecommendViewController

static NSString * const MONCategoryID = @"category";
static NSString * const MONUserId = @"user";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //控件的初始化
    [self setupTableView];
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
        //默认选中首行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //隐藏指示器
        //[SVProgressHUD dismiss];
        //显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载信息失败"];
    }];
}

- (void)setupTableView
{
    //注册左边表格
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([MONRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:MONCategoryID];
    
    //注册右边表格
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([MONRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:MONUserId];

    //设置inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
    self.categoryTableView.rowHeight = 44.0f;
    self.userTableView.rowHeight = 70.0f;
    
    //设置标题
    self.navigationItem.title = @"推荐关注";
    
    //设置背景色
    self.view.backgroundColor = MONGlobalBg;
}

#pragma mark -<UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.categoryTableView) {//左边类别表格
        return self.categories.count;
    }else {//右边用户表格
        //左边被选中的类别模型
        MONRecommendCategory *c = self.categories[self.categoryTableView.indexPathForSelectedRow.row]; 
        return c.users.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView) {//左边类别表格
        MONRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:MONCategoryID];
        cell.category = self.categories[indexPath.row];
        return cell;
    }else {//右边用户表格
        MONRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:MONUserId];
        MONRecommendCategory *c = self.categories[self.categoryTableView.indexPathForSelectedRow.row];
        cell.user = c.users[indexPath.row];
        return cell;
    }
    
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MONRecommendCategory *c = self.categories[indexPath.row];
    
    if (c.users.count) {
        //显示曾经的数据
        [self.userTableView reloadData];
    } else {
        //刷新表格，目的是，马上显示当前category的用具数据,不让用户看到上一个category的数据
        [self.userTableView reloadData];
        //发送请求给服务器，加载右侧的数据
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"list";
        params[@"c"] = @"subscribe";
        params[@"category_id"] = @(c.id);
        
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            //字典数组->模型数组
            NSArray *users = [MONRecommendUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
            //添加到当前类别对应的用户数组中
            [c.users addObjectsFromArray:users];
            
            //刷新右边表格
            [self.userTableView reloadData];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            MONLog(@"%@",error);
        }];
    }
    
}

@end
