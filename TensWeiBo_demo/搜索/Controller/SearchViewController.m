//
//  SearchViewController.m
//  TensWeiBo_demo
//
//  Created by tens on 15-10-5.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "SearchViewController.h"

#import "SearchView.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SearchView *searchView = [[SearchView alloc] initWithFrame:CGRectMake(0, 0,TScreenWidth - 20 , 35)];
    
    self.navigationItem.titleView = searchView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
