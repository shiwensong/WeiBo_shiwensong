//
//  ButtonAnimationView.m
//  TensWeiBo_demo
//
//  Created by tens on 15-10-6.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "ButtonAnimationView.h"

@interface ButtonAnimationView ()

@property (strong, nonatomic) UIImageView *backgroundImageView;
@property (strong, nonatomic) UIButton *deleteButton;

@property (strong, nonatomic) NSMutableArray *animationButtons;

@end

@implementation ButtonAnimationView

#pragma mark - Lifecycle

+ (instancetype)creat{
    return [[self alloc] init];
}

#pragma mark - UIResponder

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self closeCurrentVeiw];
}

#pragma mark - Private

- (void)showSendWeiboView{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    self.frame = CGRectMake(0, 0, TScreenWidth, TScreenHeight);
    self.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
    [keyWindow addSubview:self];
    
    [self backgroundImageView];
    [self deleteButton];
    [self creatAnimationButtonGround];
    
    [self setButtonAnimationIsShow:YES];
    
}

- (void)creatAnimationButtonGround{
    
    NSArray *buttonImages = @[@"tabbar_compose_idea",
                              @"tabbar_compose_photo",
                              @"tabbar_compose_weibo",
                              @"tabbar_compose_lbs",
                              @"tabbar_compose_review",
                              @"tabbar_compose_more"
                              ];
    
    NSArray *buttonWords = @[@"文字",
                             @"相册",
                             @"相机",
                             @"签到",
                             @"点评",
                             @"更多"];
    
    CGFloat buttonHeight = 110;
    CGFloat buttonWidth = (TScreenWidth - 40) / 3;
    
    for (int  i = 0; i < 6; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat x = 10 + (10 + buttonWidth) * (i %3);
        CGFloat y = TScreenWidth + buttonHeight * (i / 3);
        
        button.tag = i;
        button.frame = CGRectMake(x, y, buttonWidth, buttonHeight);
        
        [button setImage:[UIImage imageNamed:buttonImages[i]] forState:UIControlStateNormal];
        [button setTitle:buttonWords[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button addTarget:self action:@selector(animationButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:button];
        
        
        CGFloat titleLeft = TScreenWidth  > 320 ?  -75 : -70;
        CGFloat imageLeft = TScreenHeight > 320 ? 15 : 10;
        [button setImageEdgeInsets:UIEdgeInsetsMake(-10, imageLeft, 0, 0)];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(90, titleLeft, 0, 0)];
        
        [self.animationButtons addObject:button];
        //暂时设置背景颜色
//        button.backgroundColor = [UIColor blackColor];
    }
}

- (void)setButtonAnimationIsShow:(BOOL)isShow{
    CGFloat oneRowY = TScreenHeight - 300;
    CGFloat twoRowY = TScreenHeight - 190;
    CGFloat delay = 0;
    
    if (!isShow) {
         oneRowY = TScreenHeight;
         twoRowY = TScreenHeight + 110;
         delay = 0.3;
    }
    
    for (UIButton *button in self.animationButtons) {
        
        [UIView animateWithDuration:0.8 delay:delay usingSpringWithDamping:0.7 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            button.y = button.tag < 3 ? oneRowY : twoRowY;
            
        } completion:^(BOOL finished) {
            
        }];
        delay = isShow ? (delay + 0.05) : (delay - 0.05);
    }
}


#pragma mark - IBAction

- (void)closeCurrentVeiw{
    
    
    [self setButtonAnimationIsShow:NO];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self removeFromSuperview];
        self.alpha = 0;
        
    });
}

- (void)animationButtonAction:(UIButton *)button{
    
    [UIView animateWithDuration:0.5 animations:^{
        button.transform = CGAffineTransformMakeScale(1.5, 1.5);
        self.alpha = 0;
    }];
    
    [self.animationButtons removeObject:button];
    
    for (UIButton *button in self.animationButtons) {
        
        [UIView animateWithDuration:0.4 animations:^{
            button.transform = CGAffineTransformMakeScale(0.5, 0.5);
            button.alpha = 0;
        }];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });
}


#pragma mark - Custom Accessors

- (UIImageView *)backgroundImageView
{
    if (_backgroundImageView == nil) {
        _backgroundImageView = [[UIImageView alloc] init];
        
        _backgroundImageView.image = [UIImage imageNamed:@"compose_slogan"];
        _backgroundImageView.contentMode = UIViewContentModeScaleAspectFit;
        _backgroundImageView.frame = CGRectMake((TScreenWidth - 150)/2, 150,150 , 50);
        [self addSubview:_backgroundImageView];
    }
    return _backgroundImageView;
}

- (UIButton *)deleteButton{
    if (_deleteButton == nil) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteButton.frame = CGRectMake(0, TScreenHeight - 45, TScreenWidth, 45);
        _deleteButton.backgroundColor = [UIColor whiteColor];
        [_deleteButton addTarget:self action:@selector(closeCurrentVeiw) forControlEvents:UIControlEventTouchUpInside];
        [_deleteButton setImage:[UIImage imageNamed:@"tabbar_compose_background_icon_close"] forState:UIControlStateNormal];
        [self addSubview:_deleteButton];
        
    }
    return _deleteButton;
}

- (NSMutableArray *)animationButtons{
    if (_animationButtons == nil) {
        _animationButtons = [NSMutableArray array];
    }
    return  _animationButtons;
}

@end
