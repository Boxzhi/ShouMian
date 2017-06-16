//
//  SMShoppingCartCell.m
//  Shoumian
//
//  Created by 何志志 on 2017/3/23.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMShoppingCartCell.h"

@interface SMShoppingCartCell()

@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *subButton;
@property (weak, nonatomic) IBOutlet UILabel *numberLab;

@property (weak, nonatomic) IBOutlet UILabel *unitPriceLab;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLab;

@end

@implementation SMShoppingCartCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.addButton.layer.borderWidth = self.subButton.layer.borderWidth = self.numberLab.layer.borderWidth = SMLineViewHeight;
    self.addButton.layer.borderColor = self.subButton.layer.borderColor = self.numberLab.layer.borderColor = LineViewBackgroundColor.CGColor;
    
    self.unitPriceLab.attributedText = [NSString addPriceAttributedString:@"¥ 1800"];
    self.totalPriceLab.attributedText = [NSString addPriceAttributedString:@"¥ 1800"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
