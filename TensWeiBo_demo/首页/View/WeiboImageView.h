//
//  WeiboImageView.h
//  TensWeiBo_demo
//
//  Created by tens on 15-10-10.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZPhotoBrowser.h"
#import "WeiboImage.h"
@interface WeiboImageView : UIView <HZPhotoBrowserDelegate, WeiboImageDelegate>

@property (nonatomic, strong)NSArray *imageURLs;


@end
