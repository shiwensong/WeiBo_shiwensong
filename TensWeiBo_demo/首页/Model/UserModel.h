//
//  UserModel.h
//  TensWeiBo_demo
//
//  Created by tens on 15-10-9.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "TSBaseModel.h"

@interface UserModel : TSBaseModel


/** 用户昵称 */
@property (copy, nonatomic) NSString *screen_name;

/** 用户头像（中图）  */
@property (copy, nonatomic) NSString *profile_image_url;

/** 用户头像（大图）  */
@property (copy, nonatomic) NSString *avatar_large;

/** 粉丝数  */
@property (copy, nonatomic) NSString *followers_count;

/** 关注数  */
@property (copy, nonatomic) NSString *friends_count;

/** 微博数  */
@property (copy, nonatomic) NSString *statuses_count;



@end
