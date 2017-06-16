//
//  HZZStarView.h
//  HZZ
//
//  Created by 何志志 on 16/9/5.
//  Copyright © 2016年 hezhizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HZZStarView : UIView
{
    UIView * bottomView;
    UIView *clipView;
}

//设置星星进度条
-(void)setStarProgress:(double)level;

@end
