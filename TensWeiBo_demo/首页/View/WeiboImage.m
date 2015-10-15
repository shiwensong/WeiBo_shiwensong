//
//  weiboImage.m
//  TensWeiBo_demo
//
//  Created by tens on 15-10-10.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "WeiboImage.h"

@implementation WeiboImage


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.delegate clickTheImageViewWithTag:self.tag];
}





@end
