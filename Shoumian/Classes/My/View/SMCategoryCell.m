//
//  SMCategoryCell.m
//  Shoumian
//
//  Created by 何志志 on 2017/1/22.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMCategoryCell.h"

@implementation SMCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)shoppingCartBtn:(id)sender {
    if (self.clickBtnBlock) {
        self.clickBtnBlock(0);
    }
}

- (IBAction)collectionBtn:(id)sender {
    if (self.clickBtnBlock) {
        self.clickBtnBlock(1);
    }
}

- (IBAction)couponBtn:(id)sender {
    if (self.clickBtnBlock) {
        self.clickBtnBlock(2);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
