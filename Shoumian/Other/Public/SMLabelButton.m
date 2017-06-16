//
//  SMLabelButton.m
//  Shoumian
//
//  Created by 何志志 on 2017/2/15.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMLabelButton.h"

@implementation SMLabelButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.titleLabel.textColor = UIColorFromRGB(0x8099c9);
        [self.titleLabel setFont:[UIFont systemFontOfSize:13]];
        
        [self hzz_roundedCornerWithCornerRadii:CGSizeMake(10, 0) cornerColor:[UIColor clearColor] corners:UIRectCornerAllCorners borderColor:UIColorFromRGB(0xc8d3e8) borderWidth:1];
    }
    
    return self;
}


//  通过xib创建会调用该方法
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        self.titleLabel.textColor = UIColorFromRGB(0x8099c9);
        [self.titleLabel setFont:[UIFont systemFontOfSize:13]];

        [self hzz_roundedCornerWithCornerRadii:CGSizeMake(10, 0) cornerColor:[UIColor clearColor] corners:UIRectCornerAllCorners borderColor:UIColorFromRGB(0xc8d3e8) borderWidth:1];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted{
    
}

@end
