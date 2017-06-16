//
//  SMCouponCell.m
//  Shoumian
//
//  Created by 何志志 on 2017/3/10.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMCouponCell.h"

@interface SMCouponCell()

@end

@implementation SMCouponCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.useBtn hzz_roundedCornerWithCornerRadii:CGSizeMake(6, 0) cornerColor:[UIColor whiteColor] corners:UIRectCornerAllCorners borderColor:UIColorRed borderWidth:0.5];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
