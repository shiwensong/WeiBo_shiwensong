//
//  OAuthViewController.m
//  TensWeiBo_demo
//
//  Created by tens on 15-10-7.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "OAuthViewController.h"
#import "TSOAuthModel.h"
#import "KeyedArchiverToken.h"
#import "UIWindow+RootViewController.h"


@interface OAuthViewController () <UIWebViewDelegate>

@end

@implementation OAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, TScreenWidth, TScreenHeight)];
    [self.view addSubview:webView];
    
    webView.delegate = self;
    NSString *urlString = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",TSAppKey, TSRetracementAddress];

    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [webView loadRequest:request];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Group Protol

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *url = request.URL.relativeString;
    NSRange range = [url rangeOfString:@"code="];
    
    if (range.location != NSNotFound) {
        NSString *code = [url substringFromIndex:range.location + range.length];
        
        [self requestTokenWithCode:code];
    }
    
    return YES;
}

- (void)requestTokenWithCode:(NSString *)code{
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    NSMutableDictionary *parmeters = [NSMutableDictionary dictionary];
    [parmeters setValue:TSAppKey forKey:@"client_id"];
    [parmeters setValue:TSAppSecret forKey:@"client_secret"];
    [parmeters setValue:@"authorization_code" forKey:@"grant_type"];
    [parmeters setValue:code forKey:@"code"];
    [parmeters setValue:TSRetracementAddress forKey:@"redirect_uri"];
    
    [manager POST:AccessTokenURL parameters:parmeters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        TSOAuthModel *model = [[TSOAuthModel alloc] initWithDictionary:responseObject];
        
        //本地化我们的model
        [KeyedArchiverToken archiverTokenWithModel:model];
        
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        [keyWindow setRootViewController];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error %@",error);
    }];
    
}
@end
