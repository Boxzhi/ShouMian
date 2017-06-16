//
//  SMMyHeaderCell.m
//  Shoumian
//
//  Created by 何志志 on 2017/1/22.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMMyHeaderCell.h"

@interface SMMyHeaderCell()

@property (weak, nonatomic) IBOutlet UIButton *registerLoginBtn;

@end

@implementation SMMyHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.registerLoginBtn.layer.masksToBounds = YES;
    self.registerLoginBtn.layer.cornerRadius = 6;
    self.registerLoginBtn.layer.borderColor = UIColorRed.CGColor;
    self.registerLoginBtn.layer.borderWidth = SMLineViewHeight;
}

- (IBAction)registerLoginBtnClick:(id)sender {
    if (self.registerLoginBtnClick) {
        self.registerLoginBtnClick();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
