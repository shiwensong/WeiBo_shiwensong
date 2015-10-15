//
//  weiboImage.h
//  TensWeiBo_demo
//
//  Created by tens on 15-10-10.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WeiboImageDelegate <NSObject>

- (void)clickTheImageViewWithTag:(NSInteger)tag;

@end

@interface WeiboImage : UIImageView

@property (strong, nonatomic) id<WeiboImageDelegate> delegate;

@end
