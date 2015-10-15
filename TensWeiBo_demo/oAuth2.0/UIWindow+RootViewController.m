//
//  UIWindow+RootViewController.m
//  TensWeiBo_demo
//
//  Created by tens on 15-10-7.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "UIWindow+RootViewController.h"

@implementation UIWindow (RootViewController)

- (void)setRootViewController{
    
    NSString *oldVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"versionNumber"];
    NSDictionary *infoDictionary = [NSBundle mainBundle].infoDictionary;
    NSString *currentVersion = infoDictionary[@"CFBundleVersion"];
    
    if ([oldVersion isEqualToString:currentVersion]) {
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        self.rootViewController = [storyboard instantiateInitialViewController];
    }else{
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        self.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"WelcomeViewController"];
        
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:@"versionNumber"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}


@end
