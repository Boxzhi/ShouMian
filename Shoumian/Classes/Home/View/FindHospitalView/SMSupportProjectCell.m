//
//  SMSupportProjectCell.m
//  Shoumian
//
//  Created by 何志志 on 2017/2/17.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMSupportProjectCell.h"

@interface SMSupportProjectCell()

@property (weak, nonatomic) IBOutlet UILabel *suprLab1;

@property (weak, nonatomic) IBOutlet UILabel *suprLab2;

@property (weak, nonatomic) IBOutlet UILabel *suprLab3;

@end

@implementation SMSupportProjectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.suprLab1 hzz_roundedCornerWithCornerRadii:CGSizeMake(4, 0) cornerColor:[UIColor whiteColor] corners:UIRectCornerAllCorners borderColor:UIColorFromRGB(0xc8d3e8) borderWidth:1];
    [self.suprLab2 hzz_roundedCornerWithCornerRadii:CGSizeMake(4, 0) cornerColor:[UIColor whiteColor] corners:UIRectCornerAllCorners borderColor:UIColorFromRGB(0xe8c8c8) borderWidth:1];
    [self.suprLab3 hzz_roundedCornerWithCornerRadii:CGSizeMake(4, 0) cornerColor:[UIColor whiteColor] corners:UIRectCornerAllCorners borderColor:UIColorFromRGB(0xe8c99d) borderWidth:1];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
