//
//  SMSearchCollectionViewCell.m
//  Shoumian
//
//  Created by 何志志 on 2017/2/18.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMSearchCollectionViewCell.h"

@implementation SMSearchCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
//    self.layer.masksToBounds = YES;
//    self.layer.cornerRadius = 4;
//    self.layer.borderWidth = 1;
//    self.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    [self hzz_roundedCornerWithCornerRadii:CGSizeMake(4, 0) cornerColor:[UIColor clearColor] corners:UIRectCornerAllCorners borderColor:UIColorFromRGB(0xdddddd) borderWidth:1];
}

@end
