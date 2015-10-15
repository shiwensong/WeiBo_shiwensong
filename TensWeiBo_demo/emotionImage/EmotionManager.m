//
//  EmotionManager.m
//  TensWeiBo_demo
//
//  Created by tens on 15-10-12.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "EmotionManager.h"

#define defaultInfo @"defaultInfo"
#define emojiInfo   @"emojiInfo"
#define lxhInfo     @"lxhInfo"

NSMutableArray *_emotions;

@implementation EmotionManager

+ (NSString *)emotionPNGFromName:(NSString *)emotionName{
    NSLog(@"++++++++++%@",emotionName);
    for (NSDictionary *dictionary  in [self emotions]) {
        
        NSLog(@"%@",dictionary);
        NSLog(@"------%@",emotionName);
        
        if ([emotionName isEqualToString:dictionary[@"chs"]]) {
            NSLog(@"--------%@",dictionary[@"chs"]);
            return dictionary[@"png"];
        }
    }
    return nil;
}



+ (NSArray *)loadEmotionImageData:(NSString *)fileName{

    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    
    NSArray *emotionArray = [NSDictionary dictionaryWithContentsOfFile:filePath][@"emoticons"];
    
    
    return emotionArray;
}

#pragma mark - Custom Accessors 

+ (NSMutableArray *)emotions{
    if (_emotions == nil) {
        _emotions = [NSMutableArray array];
        
        
        [_emotions addObject:[self loadEmotionImageData:defaultInfo]];
//        [_emotions addObject:[self loadEmotionImageData:emojiInfo]];  //这个是苹果自带的表情，暂时还有对他进行操作
        [_emotions addObject:[self loadEmotionImageData:lxhInfo]];
    }
    
    NSLog(@"%@",_emotions);
    
    return [_emotions firstObject];
}


@end
