//
//  HZZClassifyMenuView.h
//  Shoumian
//
//  Created by 何志志 on 2017/2/23.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HZZButton;
typedef void (^HZZButtonClickBlock)(int index, HZZButton *btn);

@interface HZZClassifyMenuView : UIView

/**
 *  按钮点击方法
 */
@property (nonatomic, copy) HZZButtonClickBlock hzzButtonClickBlock;


/**
 *  构造方法
 *
 *  @param rect       frame
 *  @param titles     按钮标题数组
 *  @param titleColor 按钮文字颜色
 *  @param image      按钮图标
 *
 *
 */
- (instancetype)initWithRect:(CGRect)rect buttonTitles:(NSArray *)titles titleColor:(UIColor *)titleColor image:(UIImage *)image clickBlock:(void(^)(int index, HZZButton *btn))clickBlock;

@end
