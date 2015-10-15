//
//  ToAttributeString.m
//  TensWeiBo_demo
//
//  Created by tens on 15-10-12.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "ToAttributeString.h"
#import "EmotionManager.h"


@implementation ToAttributeString

+ (NSAttributedString *)attributeStringfromString:(NSString *)string
{
//    string = @"@造船的铁匠:难怪人类和猴子长达几百万年的竞争当中，人类赢了，这完全靠的是实力呀[酷] //@侯宁:人类始祖时代的留存。[威武]别人家的小姨子，真赤鸡~[doge][doge][doge][doge][doge]  http://t.cn/RymYbM6";
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    
    // 第一个字符为@
    NSString *pattAt = @"@[\\w-]+";
    
    // 匹配话题#fhsaf#
    NSString *pattTopic = @"#[\\w-]+#";
    
    // https://baidu.com/
    NSString *pattURL = @"https?://[\\w-+&\\/.]+";
    
    // 匹配表情[哈哈]
    NSString *pattEmotion = @"\\[[\\w-]+\\]";
    
    // 包含多个表达式的条件
    NSString *pattAll = [NSString stringWithFormat:@"%@|%@|%@|%@",pattAt,pattTopic,pattURL,pattEmotion];
    
    NSRegularExpression *regularExpression = [[NSRegularExpression alloc] initWithPattern:pattAll options:0 error:nil];
    
    //定义一个常量来保存我们替换图片以后的字符串的偏移量
    __block NSUInteger LengthCount = 0;
    
    NSRange range = NSMakeRange(0, string.length);
    [regularExpression enumerateMatchesInString:string options:0 range:range usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        
        NSString *subString = [string substringWithRange:result.range];
        
        NSLog(@"%@",subString);
        
        NSString *imageName = [EmotionManager emotionPNGFromName:subString];
        
        
        if (imageName != nil) {
         
            NSTextAttachment  *textAttachment = [[NSTextAttachment alloc] init];
            textAttachment.image = [UIImage imageNamed:imageName];
            textAttachment.bounds = CGRectMake(0, 0, 15, 15);
            
            NSAttributedString *shortAttributedString = [NSAttributedString attributedStringWithAttachment:textAttachment];
            
            //这里的range会随着我们替换了图片字符串以后，会改变它的长度，所以我们需要重新计算她的长度，
            NSRange emotionRange = {result.range.location - LengthCount, subString.length};
            
            [attributedString replaceCharactersInRange:emotionRange withAttributedString:shortAttributedString];
            
            LengthCount += subString.length - 1;
        
        }else{
            [attributedString addAttribute:NSLinkAttributeName value:subString range:NSMakeRange(result.range.location - LengthCount, subString.length)];
        }
    }];
    
    
    
    return attributedString;
}


@end
