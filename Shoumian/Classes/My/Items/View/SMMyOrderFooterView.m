//
//  SMMyOrderFooterView.m
//  Shoumian
//
//  Created by 何志志 on 2017/3/20.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMMyOrderFooterView.h"

@interface SMMyOrderFooterView()

@end

@implementation SMMyOrderFooterView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self.orderBtn hzz_roundedCornerWithCornerRadii:CGSizeMake(6, 0) cornerColor:[UIColor clearColor] corners:UIRectCornerAllCorners borderColor:UIColorRed borderWidth:0.5f];
    self.reimburseSumLab.hidden = YES;
}

@end
