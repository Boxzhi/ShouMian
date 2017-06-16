//
//  SMPriCusCell.m
//  Shoumian
//
//  Created by 何志志 on 2017/2/13.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMPriCusCell.h"

@interface SMPriCusCell()

@end

@implementation SMPriCusCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.appointmentsBtn.layer.borderColor = UIColorFromRGB(0xff5050).CGColor;
}

- (IBAction)appBtnClick:(UIButton *)sender {
    if (self.pricusAppBtnBlock) {
        self.pricusAppBtnBlock();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
