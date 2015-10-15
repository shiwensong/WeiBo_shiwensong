//
//  TSOAuthModel.m
//  TensWeiBo_demo
//
//  Created by tens on 15-10-7.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "TSOAuthModel.h"

@implementation TSOAuthModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    self.creatTokenDate = [NSDate date];
}


-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _access_token = [aDecoder decodeObjectForKey:@"access_token"];
        _expires_in = [aDecoder decodeObjectForKey:@"expires_in"];
        _uid = [aDecoder decodeObjectForKey:@"uid"];
        _creatTokenDate = [aDecoder decodeObjectForKey:@"creatTokenDate"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_access_token forKey:@"access_token"];
    [aCoder encodeObject:_expires_in forKey:@"expires_in"];
    [aCoder encodeObject:_uid forKey:@"uid"];
    [aCoder encodeObject:_creatTokenDate forKey:@"creatTokenDate"];
}

-(NSString *)description  {
    NSString *string = [NSString stringWithFormat:@"access_token == %@, expires_in == %@, uid ==%@", _access_token, _expires_in, _uid];
    return string;
}

@end
