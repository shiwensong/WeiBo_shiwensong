//
//  WeiboModel.m
//  TensWeiBo_demo
//
//  Created by tens on 15-10-9.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "WeiboModel.h"
#import "UserModel.h"

@implementation WeiboModel

#pragma mark - Custom Accessor

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    self = [super initWithDictionary:dict];
    if (self) {
        _user = [UserModel modelWithDictionary:dict[@"user"]];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"retweeted_status"]) {
        
         self.retweetedWeiboModel = [WeiboModel modelWithDictionary:value];
    }
}


#pragma mark - Custom Accessor

- (void)setCreated_at:(NSString *)created_at{
    // 格式化日期字符串
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [dateFormatter setDateFormat:@"ccc LLL dd HH:mm:ss Z yyyy"];
    NSDate *serverDate = [dateFormatter dateFromString:created_at];
    
    
    // 按需要格式格式化日期
//    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Chongqing"];
//    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"YYYY-MM-d HH:mm:ss"];
    NSString *correctDate = [dateFormatter stringFromDate:serverDate];
    
    _created_at = correctDate;
}

- (void)setSource:(NSString *)source{
    
//    if (source.length <= 0) {
//        return;
//    }
    
    NSRange range1 = [source rangeOfString:@">"];
    NSRange range2 = [source rangeOfString:@"</a>"];
    
    NSRange range = {range1.location + 1 ,range2.location - range1.location - 1};
    
    if(source.length >0){
        
        _source = [source substringWithRange:range];
    }else{
        _source = source;
    }
    
}

@end
