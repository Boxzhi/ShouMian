//
//  UIView+Frame.h
//  01-BuDeJie
//
//  Created by xmg on 16/1/18.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property CGFloat sm_x;
@property CGFloat sm_y;
@property CGFloat sm_width;
@property CGFloat sm_height;
@property CGFloat sm_centerX;
@property CGFloat sm_centerY;

/**
 *  通过xib创建View
 *
 */
+ (instancetype)viewFromXib;


+ (instancetype)initWithNib:(NSString *)nibName bundle:(NSBundle *)bundle;

/**
 *  判断self和view是否重叠
 */
- (BOOL)sm_intersectWithView:(UIView *)view;

/**
 *  创建导航栏的titleView
 */
+ (UIView *)setTitleViewWithTarget:(id)target firstAction:(SEL)firstAction secondAction:(SEL)secondAction thirdAction:(SEL)thirdAction;

@end
