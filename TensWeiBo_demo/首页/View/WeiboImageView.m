//
//  WeiboImageView.m
//  TensWeiBo_demo
//
//  Created by tens on 15-10-10.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "WeiboImageView.h"

@implementation WeiboImageView
{
    NSArray *_subViews;
}

- (void)awakeFromNib{
    _subViews = self.subviews;
}

- (void)setImageURLs:(NSArray *)imageURLs{
    _imageURLs = imageURLs;
    
    [self setimageViews];
}

- (void)setimageViews{
    
    for (int i = 0; i < _subViews.count; i++) {
        WeiboImage *imageView = _subViews[i];
        imageView.delegate = self;
        imageView.userInteractionEnabled = YES;

        if (i >= _imageURLs.count) {
            imageView.hidden = YES;
        }else{
            imageView.hidden = NO;
            NSString *urlString = _imageURLs[i][@"thumbnail_pic"];
            urlString = [urlString stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
            [imageView sd_setImageWithURL:[NSURL URLWithString:urlString]];
        }
    }
}

#pragma mark - Group Protol

#pragma mark - WeiboImageDelegate

- (void)clickTheImageViewWithTag:(NSInteger)tag{
    
    HZPhotoBrowser *browserVc = [[HZPhotoBrowser alloc] init];
    browserVc.sourceImagesContainerView = self;
    browserVc.imageCount = _imageURLs.count;
    browserVc.currentImageIndex = (int)tag;
    // 代理
    browserVc.delegate = self;
    // 展示图片浏览器
    [browserVc show];
}

#pragma mark - HZPhotoBrowserDelegate

//返回占位的图片

- (UIImage *)photoBrowser:(HZPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index{
    
    return [self.subviews[index] image];
}

//返回我们

- (NSURL *)photoBrowser:(HZPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index{
    
    NSString *urlString = self.imageURLs[index][@"thumbnail_pic"];
    //将缩略图换成高清图片显示
    urlString  = [urlString stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
    
    return [NSURL URLWithString:urlString];
}


@end
