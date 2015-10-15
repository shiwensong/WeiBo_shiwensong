//
//  TSOAuthModel.h
//  TensWeiBo_demo
//
//  Created by tens on 15-10-7.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "TSBaseModel.h"

@interface TSOAuthModel : TSBaseModel

/**
 "access_token" = "2.00nmuTnDujJ_xD5d4df09126H_639C"; //这是我们的令牌
 "expires_in" = 157679999;                            //这是令牌的有限期
 uid = 3479568761;                                    //这是登录账号的ID
 */
@property (copy,   nonatomic) NSString *access_token;
@property (strong, nonatomic) NSNumber *expires_in;
@property (strong, nonatomic) NSNumber *uid;

//我们需要本地化一下我们的token创建时间，方便判断我们的token是否过期了
@property (strong, nonatomic) NSDate *creatTokenDate;

@end
