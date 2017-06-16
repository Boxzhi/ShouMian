//
//  SMDoctorsAppCell.m
//  Shoumian
//
//  Created by 何志志 on 2017/2/13.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMDoctorsAppCell.h"

@interface SMDoctorsAppCell()

@property (weak, nonatomic) IBOutlet UIButton *appointmentBtn;


@end
@implementation SMDoctorsAppCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.appointmentBtn.layer.borderColor = UIColorFromRGB(0xff5050).CGColor;
}

- (IBAction)doctorsAppBtnClick:(UIButton *)sender {
    if (self.docAppBtnBlock) {
        self.docAppBtnBlock();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
