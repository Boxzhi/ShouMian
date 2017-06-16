//
//  NSString+AttributeString.m
//  Shoumian
//
//  Created by 何志志 on 2017/2/15.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "NSString+AttributeString.h"

@implementation NSString (AttributeString)

+ (NSMutableAttributedString *)attributStringWithString:(NSString *)Str{
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:Str];
    
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0, 4)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:UIColor333 range:NSMakeRange(0, 4)];
    
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(5, Str.length - 5)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:UIColor666 range:NSMakeRange(5, Str.length - 5)];
    
    return attributedString;
}

// 添加照片----添加照片（0/9）
+ (NSMutableAttributedString *)addPhotoAttributStringWithString:(NSString *)Str{
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:Str];
    
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, 4)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:UIColor333 range:NSMakeRange(0, 4)];
    
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(4, Str.length - 4)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:UIColorRed range:NSMakeRange(4, Str.length - 4)];
    
    return attributedString;
}

/**
 *  个人主页的“帖子”、“日记”、“圈子”
 */
+ (NSMutableAttributedString *)personalHomepageAttributStringWithClassifyStr:(NSString *)classifyStr leftColor:(UIColor *)leftColor numberStr:(NSString *)numberStr rightColor:(UIColor *)rightColor{
    
    NSString *str = [NSString stringWithFormat:@"%@  %@", classifyStr, numberStr];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, classifyStr.length)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:leftColor range:NSMakeRange(0, classifyStr.length)];
    
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(classifyStr.length, numberStr.length + 2)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:rightColor range:NSMakeRange(classifyStr.length, numberStr.length + 2)];
    
    return attributedString;
}

/**
 *  提交订单时的商品名称
 */
+ (NSMutableAttributedString *)confirmOrderAttributStringWithCommodityStr:(NSString *)commodityStr leftColor:(UIColor *)leftColor numberStr:(NSString *)numberStr rightColor:(UIColor *)rightColor{
    
    NSString *str = [NSString stringWithFormat:@"%@ x%@", commodityStr, numberStr];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0, commodityStr.length)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:leftColor range:NSMakeRange(0, commodityStr.length)];
    
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(commodityStr.length, numberStr.length + 2)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:rightColor range:NSMakeRange(commodityStr.length, numberStr.length + 2)];
    
    return attributedString;
}

/**
 *  下划线
 */
+ (NSMutableAttributedString *)addNSUnderlineStyleAttributeName:(NSString *)Str{
    
    NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:Str attributes:attribtDic];
    return attribtStr;
}

/**
 *  中划线
 */
+ (NSMutableAttributedString *)addNSStrikethroughStyleAttributeName:(NSString *)Str{
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:Str attributes:attribtDic];
    return attribtStr;
}

/**
 *  个人主页的关注、粉丝
 */
+ (NSMutableAttributedString *)addFollowFansAttributedString:(NSString *)str leftColor:(UIColor *)leftColor rightColor:(UIColor *)rightColor{
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    [attributedString addAttribute:NSForegroundColorAttributeName value:leftColor range:NSMakeRange(0, 2)];
    
    [attributedString addAttribute:NSForegroundColorAttributeName value:rightColor range:NSMakeRange(2, str.length - 2)];
    
    return attributedString;
}

/**
 *  购物车总价  如：合计：¥4800
 */
+ (NSMutableAttributedString *)addTotalPriceAttributedString:(NSString *)str leftColor:(UIColor *)leftColor rightColor:(UIColor *)rightColor{
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, 3)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:leftColor range:NSMakeRange(0, 3)];
    
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(3, 2)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:rightColor range:NSMakeRange(3, 2)];
    
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(5, str.length - 5)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:rightColor range:NSMakeRange(5, str.length - 5)];
    
    return attributedString;
}

/**
 *  价格  如：¥ 1800
 */
+ (NSMutableAttributedString *)addPriceAttributedString:(NSString *)str {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, 1)];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(2, str.length - 2)];
    
    return attributedString;
}

@end
