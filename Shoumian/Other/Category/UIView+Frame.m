//
//  UIView+Frame.m
//  01-BuDeJie
//
//  Created by xmg on 16/1/18.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

+ (instancetype)viewFromXib{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

+ (instancetype)initWithNib:(NSString *)nibName bundle:(NSBundle *)bundle {
    if (!bundle)
        bundle = [NSBundle mainBundle];
    
    NSArray *viewsArray = [bundle loadNibNamed:nibName owner:nil options:nil];
    if (!viewsArray.count) {
        NSLog(@"%@ - no nib found for name %@", NSStringFromClass([self class]), nibName);
        
        return nil;
    }
    
    for (id aView in viewsArray) {
        if ([aView isKindOfClass:[self class]])
            return aView;
    }
    
    return nil;
}

- (BOOL)sm_intersectWithView:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    
    CGRect rect1 = [self convertRect:self.bounds toView:nil];
    CGRect rect2 = [view convertRect:view.bounds toView:nil];
    return CGRectIntersectsRect(rect1, rect2);
}

- (CGFloat)sm_height
{
    return self.frame.size.height;
}
- (void)setsm_height:(CGFloat)sm_height
{
    CGRect frame = self.frame;
    frame.size.height = sm_height;
    self.frame = frame;
}
- (CGFloat)sm_width
{
     return self.frame.size.width;
}

- (void)setsm_width:(CGFloat)sm_width
{
    CGRect frame = self.frame;
    frame.size.width = sm_width;
    self.frame = frame;
}

- (void)setsm_x:(CGFloat)sm_x
{
    CGRect frame = self.frame;
    frame.origin.x = sm_x;
    self.frame = frame;

}
- (CGFloat)sm_x
{
    return self.frame.origin.x;
}

- (void)setsm_y:(CGFloat)sm_y
{
    CGRect frame = self.frame;
    frame.origin.y = sm_y;
    self.frame = frame;
}
- (CGFloat)sm_y
{
    return self.frame.origin.y;
}

- (void)setsm_centerX:(CGFloat)sm_centerX
{
    CGPoint center = self.center;
    center.x = sm_centerX;
    self.center = center;
}
- (CGFloat)sm_centerX
{
    return self.center.x;
}
- (void)setsm_centerY:(CGFloat)sm_centerY
{
    CGPoint center = self.center;
    center.y = sm_centerY;
    self.center = center;
}
- (CGFloat)sm_centerY
{
    return self.center.y;
}

/**
 *  快速创建导航栏的titleView
 *
 *  @param target       调用的控制器
 *  @param firstAction  扫一扫的点击方法
 *  @param secondAction 搜索框的点击方法
 *  @param thirdAction  搜索🔍的点击方法
 */
+ (UIView *)setTitleViewWithTarget:(id)target firstAction:(SEL)firstAction secondAction:(SEL)secondAction thirdAction:(SEL)thirdAction{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, S_Width, 44)];
    titleView.backgroundColor = [UIColor whiteColor];
    
    UIButton *saoBtn = [UIButton hyb_viewWithSuperView:titleView constraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.width.height.mas_equalTo(32);
        make.centerY.equalTo(titleView.mas_centerY);
    }];
    [saoBtn addTarget:target action:firstAction forControlEvents:UIControlEventTouchUpInside];
    [saoBtn setBackgroundImage:[UIImage imageNamed:@"community_saoyisao"] forState:UIControlStateNormal];
    
    UIButton *sosuoBtn = [UIButton hyb_viewWithSuperView:titleView constraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(0);
        make.width.height.mas_equalTo(32);
        make.centerY.equalTo(titleView.mas_centerY);
    }];
    [sosuoBtn addTarget:target action:secondAction forControlEvents:UIControlEventTouchUpInside];
    [sosuoBtn setBackgroundImage:[UIImage imageNamed:@"community_search_32"] forState:UIControlStateNormal];
    
    UIButton *sosuokuangBtn = [UIButton hyb_viewWithSuperView:titleView constraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(saoBtn.mas_right).offset(10);
        make.right.mas_equalTo(sosuoBtn.mas_left).offset(-6);
        make.height.mas_equalTo(35);
        make.centerY.equalTo(titleView.mas_centerY);
    }];
    [sosuokuangBtn addTarget:target action:thirdAction forControlEvents:UIControlEventTouchUpInside];
    [sosuokuangBtn setBackgroundImage:[UIImage imageNamed:@"sosuokuang"] forState:UIControlStateNormal];
    
    return titleView;
}
@end
