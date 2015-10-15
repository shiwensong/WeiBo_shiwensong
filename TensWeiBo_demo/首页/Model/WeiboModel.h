//
//  WeiboModel.h
//  TensWeiBo_demo
//
//  Created by tens on 15-10-9.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "TSBaseModel.h"

@class UserModel;

@interface WeiboModel : TSBaseModel

/** 微博创建时间  */
@property (copy, nonatomic) NSString *created_at;

/** 字符串型的微博ID  */
@property (copy, nonatomic) NSString *idstr;

/** 微博信息内容  */
@property (copy, nonatomic) NSString *text;

/** 微博来源  */
@property (copy, nonatomic) NSString *source;

/** 微博转发数 */
@property (strong, nonatomic) NSNumber *reposts_count;

/**  微博评论数*/
@property (strong, nonatomic) NSNumber *comments_count;

/**  微博表态数(赞数)*/
@property (strong, nonatomic) NSNumber *attitudes_count;

/**  会员等级*/
@property (strong, nonatomic) NSNumber *mlevel;

/** 保存我们的所有的图片数据 */
@property (strong, nonatomic) NSArray *pic_urls;

/**  这是我们的userModel*/
@property (strong, nonatomic) UserModel *user;

/**  转发微博model*/
@property (strong, nonatomic) WeiboModel *retweetedWeiboModel;

@end
