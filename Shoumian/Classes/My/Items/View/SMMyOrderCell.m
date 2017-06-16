//
//  SMMyOrderCell.m
//  Shoumian
//
//  Created by 何志志 on 2017/3/20.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMMyOrderCell.h"

@interface SMMyOrderCell()

@property (weak, nonatomic) IBOutlet UIButton *evaluateBtn;
@property (weak, nonatomic) IBOutlet UIButton *writeDiaryBtn;


@end

@implementation SMMyOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.appointmentBtn hzz_roundedCornerWithCornerRadii:CGSizeMake(6, 0) cornerColor:[UIColor clearColor] corners:UIRectCornerAllCorners borderColor:UIColorRed borderWidth:SMLineViewHeight];
    [self.evaluateBtn hzz_roundedCornerWithCornerRadii:CGSizeMake(6, 0) cornerColor:[UIColor clearColor] corners:UIRectCornerAllCorners borderColor:UIColorRed borderWidth:SMLineViewHeight];
    [self.writeDiaryBtn hzz_roundedCornerWithCornerRadii:CGSizeMake(6, 0) cornerColor:[UIColor clearColor] corners:UIRectCornerAllCorners borderColor:UIColorRed borderWidth:SMLineViewHeight];
}

- (IBAction)appointmentBtnClick:(id)sender {
    if (self.appointmentBtnClickBlock) {
        self.appointmentBtnClickBlock();
    }
}

- (IBAction)WriteDiaryBtnClick:(id)sender {
    if (self.writeDiaryBtnClickBlock) {
        self.writeDiaryBtnClickBlock();
    }
}

- (IBAction)evaluateBtnClick:(id)sender {
    if (self.evaluationBtnClickBlock) {
        self.evaluationBtnClickBlock();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
