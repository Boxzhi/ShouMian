//
//  NSString+AttributeString.h
//  Shoumian
//
//  Created by 何志志 on 2017/2/15.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AttributeString)


/**
 *  医生主页的“用户案例”和“用户评价”
 */
+ (NSMutableAttributedString *)attributStringWithString:(NSString *)Str;

/**
 *  添加照片----添加照片（0/9）
 */
+ (NSMutableAttributedString *)addPhotoAttributStringWithString:(NSString *)Str;

/**
 *  个人主页的“帖子”、“日记”、“圈子”
 */
+ (NSMutableAttributedString *)personalHomepageAttributStringWithClassifyStr:(NSString *)classifyStr leftColor:(UIColor *)leftColor numberStr:(NSString *)numberStr rightColor:(UIColor *)rightColor;

/**
 *  提交订单时的商品名称
 */
+ (NSMutableAttributedString *)confirmOrderAttributStringWithCommodityStr:(NSString *)commodityStr leftColor:(UIColor *)leftColor numberStr:(NSString *)numberStr rightColor:(UIColor *)rightColor;

/**
 *  下划线
 */
+ (NSMutableAttributedString *)addNSUnderlineStyleAttributeName:(NSString *)Str;

/**
 *  中划线
 */
+ (NSMutableAttributedString *)addNSStrikethroughStyleAttributeName:(NSString *)Str;

/**
 *  个人主页的关注、粉丝
 */
+ (NSMutableAttributedString *)addFollowFansAttributedString:(NSString *)str leftColor:(UIColor *)leftColor rightColor:(UIColor *)rightColor;

/**
 *  购物车总价  如：合计：¥4800
 */
+ (NSMutableAttributedString *)addTotalPriceAttributedString:(NSString *)str leftColor:(UIColor *)leftColor rightColor:(UIColor *)rightColor;

/**
 *  价格  如：¥ 1800
 */
+ (NSMutableAttributedString *)addPriceAttributedString:(NSString *)str;

@end
