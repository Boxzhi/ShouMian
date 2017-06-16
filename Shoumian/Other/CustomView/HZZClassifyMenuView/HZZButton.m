//
//  HZZButton.m
//  Shoumian
//
//  Created by 何志志 on 2017/2/23.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "HZZButton.h"

@implementation HZZButton

- (void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    [self setTitle:titleStr forState:UIControlStateNormal];
    [self layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:10];
}

@end
