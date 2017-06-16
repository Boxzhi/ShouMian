//
//  HZZBottomView.h
//  Shoumian
//
//  Created by 何志志 on 2017/2/23.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^HZZBottomClickBlock)(NSInteger index);

@interface HZZBottomView : UIView

/**
 *  按钮点击方法
 */
@property (nonatomic, copy) HZZBottomClickBlock hZZBottomClickBlock;

/**
 *  底部View构造方法
 *
 *  @param rect   frame
 *  @param titles  文字
 *  @param images 图片
 *  @param colors 背景颜色
 *
 */
- (instancetype)initWithRect:(CGRect)rect titles:(NSArray *)titles images:(NSArray *)images colors:(NSArray *)colors tagBase:(NSInteger)tagBase;

@end
