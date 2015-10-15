//
//  WelcomeViewController.m
//  TensWeiBo_demo
//
//  Created by tens on 15-10-7.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "WelcomeViewController.h"

@interface WelcomeViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *enterWeiBoButton;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addWelcomeImages];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private

- (void)addWelcomeImages{
    self.scrollView.contentSize = CGSizeMake(TScreenWidth * 4, TScreenHeight);
    
    for (int i = 0; i < 4; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(TScreenWidth * i, 0, TScreenWidth, TScreenHeight)];
        NSString *imageName = [NSString stringWithFormat:@"new_feature_%d",i+1];
        imageView.image = [UIImage imageNamed:imageName];

        [self.scrollView addSubview:imageView];
    }
}


#pragma mark - IBAction

- (IBAction)enterWeiBoButtonOnClick:(UIButton *)sender {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    keyWindow.rootViewController = [self.storyboard instantiateInitialViewController];
}

#pragma mark - Group Protol

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.pageControl.currentPage = self.scrollView.contentOffset.x / TScreenWidth;
    
    if (self.pageControl.currentPage == 3) {
        self.enterWeiBoButton.hidden = NO;
    }else{
        self.enterWeiBoButton.hidden = YES;
    }
}

@end
