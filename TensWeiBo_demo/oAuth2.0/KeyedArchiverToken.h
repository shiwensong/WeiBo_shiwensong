//
//  KeyedArchiverToken.h
//  TensWeiBo_demo
//
//  Created by tens on 15-10-7.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSOAuthModel.h"

@interface KeyedArchiverToken : NSObject

+ (void)archiverTokenWithModel:(TSOAuthModel *)model;

+ (TSOAuthModel *)unarchiverToken;

@end
