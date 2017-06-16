//
//  SMCategoryButton.m
//  Shoumian
//
//  Created by 何志志 on 2017/2/7.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMCategoryButton.h"
#import "UIButton+ImageTitleSpacing.h"

@implementation SMCategoryButton

- (void)loadView{
    [self setImage:[UIImage imageNamed:@"enter"] forState:UIControlStateNormal];
    [self setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
    [self.titleLabel setFont:[UIFont fontWithName:@"STHeitiJ-Medium" size:16]];
    [self layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:10];
}

@end
