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
#import "MJRefresh.h"

#define MONSelectedCategory self.categories[self.categoryTableView.indexPathForSelectedRow.row]

@interface MONRecommendViewController () <UITableViewDataSource,UITableViewDelegate>
/** 左边的类别数据 */
@property (nonatomic,strong) NSArray *categories;
/** 右边的类别数据 */
//@property (nonatomic,strong) NSArray *users;
/** 左边的类别表格 */
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
/** 右侧的用户表格 */
@property (weak, nonatomic) IBOutlet UITableView *userTableView;

/** 请求参数 */
@property (nonatomic,strong) NSMutableDictionary *params;
/** AFN请求管理者 */
@property (nonatomic,strong) AFHTTPSessionManager *manager;
@end

@implementation MONRecommendViewController

static NSString * const MONCategoryID = @"category";
static NSString * const MONUserId = @"user";

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //控件的初始化
    [self setupTableView];
    
    //添加刷新控件
    [self setupRefresh];
    
    //加载左侧的类别数据
    [self loadCategories];
    
}
/**
 *加载左侧的类别数据
 */
- (void)loadCategories
{
    //显示指示器
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    //发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //隐藏指示器
        [SVProgressHUD dismiss];
        
        //服务器返回的JSON数据
        self.categories = [MONRecommendCategory objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //刷新表格
        [self.categoryTableView reloadData];
        //默认选中首行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        //让用户表格进入下拉刷新状态
        [self.userTableView.header beginRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //隐藏指示器
        //[SVProgressHUD dismiss];
        //显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载信息失败"];
    }];

}

/**
 *控件的初始化
 */
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
/**
 *控添加刷新控件
 */
- (void)setupRefresh
{
    self.userTableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    self.userTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    self.userTableView.footer.hidden = YES;
}

- (void)loadNewUsers
{
    MONRecommendCategory *rc = MONSelectedCategory;
    
    //设置当前页码为1
    rc.currentPage = 1;
    
    //发送请求给服务器，加载右侧的数据
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(rc.id);
    params[@"page"] = @(rc.currentPage);
    self.params = params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //字典数组->模型数组
        NSArray *users = [MONRecommendUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //清除所有旧数据
        [rc.users removeAllObjects];
        
        //添加到当前类别对应的用户数组中
        [rc.users addObjectsFromArray:users];
        
        //保存总数
        rc.total = [responseObject[@"total"] integerValue];
        
        //不是最后一次请求
        if (self.params != params) return;
        
        //刷新右边表格
        [self.userTableView reloadData];
        
        //结束刷新
        [self.userTableView.header endRefreshing];
        
        //让底部控件结束刷新
        [self checkFooterState];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (self.params != params) return;
        //提醒失败
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        //结束刷新
        [self.userTableView.header endRefreshing];
    }];

}

- (void)loadMoreUsers
{
    MONRecommendCategory *category = MONSelectedCategory;
    
    //发送请求给服务器，加载右侧的数据
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @([MONSelectedCategory id]);
    params[@"page"] = @(++category.currentPage);
    self.params = params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //字典数组->模型数组
        NSArray *users = [MONRecommendUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //添加到当前类别对应的用户数组中
        [category.users addObjectsFromArray:users];
        
        //不是最后一次请求
        if (self.params != params) return;
        
        //刷新右边表格
        [self.userTableView reloadData];
        
        //让底部控件结束刷新
        [self checkFooterState];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (self.params != params) return;
        //提醒失败
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        //结束刷新
        [self.userTableView.footer endRefreshing];
    }];

}
/**
 *时刻监测footer的状态
 */
- (void)checkFooterState
{
    MONRecommendCategory *rc = MONSelectedCategory;
    //每次刷新右边数据时，都控制footer显示或者隐藏
    self.userTableView.footer.hidden = (rc.users.count ==0);
    //让底部控件结束刷新
    if (rc.users.count == rc.total) {//全部加载完毕
        [self.userTableView.footer noticeNoMoreData];
    } else {//还没有加载完毕
        [self.userTableView.footer endRefreshing];
    }

}

#pragma mark -<UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //左边类别表格
    if (tableView == self.categoryTableView) return self.categories.count;
    
    //监测footer的状态
    [self checkFooterState];
    
    //右边用户表格
    return [MONSelectedCategory users].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView) {//左边类别表格
        MONRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:MONCategoryID];
        cell.category = self.categories[indexPath.row];
        return cell;
    }else {//右边用户表格
        MONRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:MONUserId];
        //MONRecommendCategory *c = MONSelectedCategory;
        cell.user = [MONSelectedCategory users][indexPath.row];
        return cell;
    }
    
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //结束刷新
    [self.userTableView.header endRefreshing];
    [self.userTableView.footer endRefreshing];
    
    MONRecommendCategory *c = self.categories[indexPath.row];
    
    if (c.users.count) {
        //显示曾经的数据
        [self.userTableView reloadData];
    } else {
        //刷新表格，目的是，马上显示当前category的用具数据,不让用户看到上一个category的数据
        [self.userTableView reloadData];
        
        //进入下拉刷新状态
        [self.userTableView.header beginRefreshing];
        
            }
    
}

#pragma mark - 控制器的销毁
- (void)dealloc
{
    //停止所有操作
    [self.manager.operationQueue cancelAllOperations];
}


@end
