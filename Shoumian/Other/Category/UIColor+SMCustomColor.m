//
//  UIColor+SMCustomColor.m
//  Shoumian
//
//  Created by 何志志 on 2017/2/23.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "UIColor+SMCustomColor.h"

@implementation UIColor (SMCustomColor)

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha{
    
    //删除字符串中的空格
    
    NSString * cString = [[color stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String应该是6或8个字符
    
    if([cString length] < 6) {
        
        return [UIColor clearColor];
    };
    
    // strip 0X if it appears
    
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    
    if ([cString hasPrefix:@"0X"]) {
        cString = [cString substringFromIndex:2];
    };
    
    //如果是＃开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    
    if([cString hasPrefix:@"＃"]){
        
        cString = [cString substringFromIndex:1];
    }
    
    if ([cString length] != 6){
        
        return [UIColor clearColor];
    }
    
    
    //分成r，g，b子字符串
    //NSRange范围;
    NSRange range = NSRangeFromString(color);
    
    // r
    range.location = 0;
    range.length = 2;
    NSString * rString = [cString substringWithRange:range];
    
    //G
    range.location = 2;
    NSString * gString = [cString substringWithRange:range];
    
    // b
    range.location = 4;
    NSString * bString = [cString substringWithRange:range];

//扫描值

    unsigned int r,g,b;

    [[NSScanner scannerWithString: rString] scanHexInt: &r];

    [[NSScanner scannerWithString: gString] scanHexInt: &g];

    [[NSScanner scannerWithString: bString] scanHexInt: &b];

    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f)blue: ((float)b / 255.0f) alpha:alpha];
    
}

@end
