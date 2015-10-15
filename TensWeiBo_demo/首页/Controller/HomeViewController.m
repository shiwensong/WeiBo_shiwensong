//
//  HomeViewController.m
//  TensWeiBo_demo
//
//  Created by tens on 15-10-5.
//  Copyright (c) 2015年 tens. All rights reserved.
//Sat Oct 10 12:28:24 +0800 2015

#import "HomeViewController.h"

#import "PopView.h"

#import "KeyedArchiverToken.h"

#import "TSWeiboCell.h"

#import "WeiboModel.h"

#import "MJRefresh.h"

@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *weiboModels;


@property (weak, nonatomic) IBOutlet UITableView *tabelView;

@end

static NSString *cellID = @"WeiboCell";

@implementation HomeViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [_tabelView registerNib:[UINib nibWithNibName:@"TSWeiboCell" bundle:nil] forCellReuseIdentifier:cellID];
    [self addDownRefreshView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Private

- (void)creatPopView:(UIView *)view withType:(PopViewType)type{

    PopView *popView = [PopView creat];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    button.bounds = CGRectMake(0, 0, 150, 100);
    
    [button addTarget:self action:@selector(buttonActionwithButton:) forControlEvents:UIControlEventTouchUpInside];
    popView.contentView = button;
    
    [popView showPopImageView:view withType:type];
}

//记载网络数据(正常加载数据和下拉菜单加载更多数据)
- (void)loadWeiBoData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    NSString *access_token = [KeyedArchiverToken unarchiverToken].access_token;
    [parameters setValue:access_token forKey:@"access_token"];
    
    WeiboModel *model = [self.weiboModels firstObject];
    if (model) {
        [parameters setValue:model.idstr forKey:@"since_id"];
    }
    
    [manager GET:HomeWeiboURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self fromDictionaryToModel:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"发生错误！error ==%@",error);
        [self.tabelView.header endRefreshing];
    }];
}

- (void)fromDictionaryToModel:(NSDictionary *)dictionary{
    
    NSMutableArray *newWeiboArray = [NSMutableArray array];
    
    NSArray *responseArray = dictionary[@"statuses"];
    for (NSDictionary *dictionary in responseArray) {
        
        WeiboModel *model = [WeiboModel modelWithDictionary:dictionary];
        
        [newWeiboArray addObject:model];
    }
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, newWeiboArray.count)];
    [self.weiboModels insertObjects:newWeiboArray atIndexes:indexSet];
    
    
    [_tabelView reloadData];
    [self.tabelView.header endRefreshing];
    
    // 有数据的时候在添加上拉加载更多视图
    if (self.tabelView.footer == nil) {
        
        [self addUpRefreshView];
    }
}


#pragma mark - 上拉加载更多数据
- (void)loadMoreWeiboData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    
    TSOAuthModel *model = [KeyedArchiverToken unarchiverToken];
    [parames setObject:model.access_token forKey:@"access_token"];
    
    // 加载比最后一个微博ID小的微博
    WeiboModel *wbModel = [self.weiboModels lastObject];
    if (wbModel) {
        NSString *nextID = [NSString stringWithFormat:@"%lld",wbModel.idstr.longLongValue - 1];
        [parames setObject:nextID forKey:@"max_id"];
    }
    
    [manager GET:HomeWeiboURL parameters:parames success:^(AFHTTPRequestOperation *operation, id responseObject) {

        [self fromDicToModelForMoreData:responseObject];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self.tabelView.footer endRefreshing];
        
    }];
}

- (void)fromDicToModelForMoreData:(NSDictionary *)dic
{
    NSArray *statuses = dic[@"statuses"];
    for (NSDictionary *statusDic in statuses) {
        WeiboModel *model = [[WeiboModel alloc] initWithDictionary:statusDic];
        
        [self.weiboModels addObject:model];
    }
    
    [self.tabelView reloadData];
    
    // 结束上拉刷新
    [self.tabelView.footer endRefreshing];
}

//---------------------


- (void)addDownRefreshView{
    
    self.tabelView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadWeiBoData)];
    
    [self.tabelView.header beginRefreshing];
    
}

- (void)addUpRefreshView{
    
    self.tabelView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreWeiboData)];

}

#pragma mark - IBAction

- (IBAction)titleButtonAction:(UIButton *)sender {
    
    [self creatPopView:sender withType:PopViewIsCenter];
}


- (IBAction)leftButtonAction:(UIButton *)sender {
    [self creatPopView:sender withType:PopViewIsLeft];
}

- (IBAction)rightButtonAction:(UIButton *)sender {
    [self creatPopView:sender withType:PopViewIsRight];
}

- (void)buttonActionwithButton:(UIButton *)button
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"点击了" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}


#pragma mark - Group Protol

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.weiboModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TSWeiboCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    cell.model = self.weiboModels[indexPath.row];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WeiboModel *model = self.weiboModels[indexPath.row];
    CGFloat cellheight = 0;
    if (model.retweetedWeiboModel != nil) {
//        cellheight =  
    }else{
         cellheight = [TSWeiboCell tableViewCellRowHeight:model];
    }
    
    return cellheight;
}


#pragma mark - Custon Accessor

- (NSMutableArray *)weiboModels{
    if (_weiboModels  == nil) {
        _weiboModels = [NSMutableArray array];
    }
    return _weiboModels;
}

@end
