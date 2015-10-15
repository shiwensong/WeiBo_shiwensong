//
//  KeyedArchiverToken.m
//  TensWeiBo_demo
//
//  Created by tens on 15-10-7.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#define tokenModelFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"tokenModel.plist"]

#import "KeyedArchiverToken.h"

@implementation KeyedArchiverToken

+ (void)archiverTokenWithModel:(TSOAuthModel *)model{
    
    [NSKeyedArchiver archiveRootObject:model toFile:tokenModelFilePath];
}

+ (TSOAuthModel *)unarchiverToken{
    
    TSOAuthModel *model = [NSKeyedUnarchiver unarchiveObjectWithFile:tokenModelFilePath];
    
    NSDate *date = [model.creatTokenDate dateByAddingTimeInterval:[model.expires_in doubleValue]];
    NSComparisonResult result = [date compare:[NSDate date]];
    
    if (result == NSOrderedAscending) {
        return  nil;
    }
    
    return model;
}

@end
