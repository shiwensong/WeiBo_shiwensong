//
//  MainTabBarController.m
//  TensWeiBo_demo
//
//  Created by tens on 15-10-5.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "MainTabBarController.h"

#import "ButtonAnimationView.h"

#import "UIView+Extension.h"



@interface MainTabBarController ()
{
    UIView *_presentView;
}
@property (strong, nonatomic) UIView *cicleView;

@property (strong, nonatomic) UIButton *centerButton;

#pragma mark - Method
/**
 *  设置TabBar 的TabBarItem的选中图片
 */
- (void)setTabbaritemSelectedImage;

/**
 *  我们centerButton的点击事件
 *
 *  @param centerButton TabBar的中间发送微博的点击按钮
 */
- (void)centerButtonSelectdAction:(UIButton *)centerButton;

@end

@implementation MainTabBarController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setTabbaritemSelectedImage];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -  Private

- (void)setTabbaritemSelectedImage{
    
    self.tabBar.barTintColor = [UIColor whiteColor];
    self.tabBar.tintColor = [UIColor colorWithRed:255/255.0 green:111/255.0 blue:0 alpha:1];
    
    [self.tabBar addSubview:self.centerButton];
    
    NSArray *selectedImages = @[@"tabbar_home_selected",
                                @"tabbar_message_center_selected",
                                @"",
                                @"tabbar_discover_selected",
                                @"tabbar_profile_selected",];
    
    NSArray *viewControllers = self.viewControllers;
    
    for (int i = 0; i < selectedImages.count; i ++) {
        
        //加上这个判断主要是因为[UIImage imageNameed:] 不能使用空得名字，所以我们需要过滤出中间那个图片的名字
        if(i == 2){
            continue;
        }
            UIViewController *viewController = viewControllers[i];
            
            NSString *selectedImageName = selectedImages[i];
            UIImage *selectImage = [UIImage imageNamed:selectedImageName];
            
            viewController.tabBarItem.selectedImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
}



#pragma mark - IBAction

- (void)centerButtonSelectdAction:(UIButton *)centerButton{
    
    ButtonAnimationView *buttonAnimationView = [ButtonAnimationView creat];
    
    [buttonAnimationView showSendWeiboView];
}




#pragma mark - Custom Accessors

- (UIButton *)centerButton{
    if (_centerButton == nil) {
        _centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        CGFloat centerX = CGRectGetMidX(self.tabBar.frame);
        CGFloat height  = CGRectGetHeight(self.tabBar.frame);
        
        _centerButton.frame = CGRectMake(centerX - 32, (height - 44) / 2, 64, 44);
        
        [_centerButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [_centerButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [_centerButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        
        [_centerButton addTarget:self action:@selector(centerButtonSelectdAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _centerButton;
}

@end
