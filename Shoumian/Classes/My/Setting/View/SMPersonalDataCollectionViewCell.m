//
//  SMPersonalDataCollectionViewCell.m
//  Shoumian
//
//  Created by 何志志 on 2017/3/13.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMPersonalDataCollectionViewCell.h"

@implementation SMPersonalDataCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    
//    [self hzz_roundedCornerWithCornerRadii:CGSizeMake(4, 0) cornerColor:[UIColor clearColor] corners:UIRectCornerAllCorners borderColor:UIColorFromRGB(0xeeeeee) borderWidth:1];
    [self hzz_roundedCornerWithCornerRadii:CGSizeMake(4, 0) cornerColor:[UIColor clearColor] corners:UIRectCornerAllCorners borderColor:RGB(229, 229, 229) borderWidth:1];
}

@end
