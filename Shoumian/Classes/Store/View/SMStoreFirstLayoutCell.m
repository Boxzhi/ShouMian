//
//  SMStoreFirstLayoutCell.m
//  Shoumian
//
//  Created by 何志志 on 2017/3/1.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMStoreFirstLayoutCell.h"

@implementation SMStoreFirstLayoutCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 9;
    self.layer.borderWidth = 1;
    self.layer.borderColor = LineViewBackgroundColor.CGColor;
}

@end
