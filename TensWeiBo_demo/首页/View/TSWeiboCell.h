//
//  TSWeiboCell.h
//  TensWeiBo_demo
//
//  Created by tens on 15-10-9.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WeiboModel;

@interface TSWeiboCell : UITableViewCell

@property (nonatomic, strong) WeiboModel *model;

+ (CGFloat)tableViewCellRowHeight:(WeiboModel *)model;

@end
