//
//  PopView.h
//  TensWeiBo_demo
//
//  Created by tens on 15-10-6.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    PopViewIsLeft,
    PopViewIsCenter,
    PopViewIsRight,
} PopViewType;

@interface PopView : UIView

@property (nonatomic, strong) UIView *contentView;

+ (instancetype)creat;

- (void)showPopImageView:(UIView *)view withType:(PopViewType)type;


@end
