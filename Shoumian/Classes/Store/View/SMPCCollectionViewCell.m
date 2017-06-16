//
//  SMPCCollectionViewCell.m
//  Shoumian
//
//  Created by 何志志 on 2017/3/2.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMPCCollectionViewCell.h"

@implementation SMPCCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 4.0f;
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = UIColorFromRGB(0xe8c8c8).CGColor;
}

@end
