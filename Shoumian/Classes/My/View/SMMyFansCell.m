//
//  SMMyFansCell.m
//  Shoumian
//
//  Created by 何志志 on 2017/3/16.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMMyFansCell.h"

@interface SMMyFansCell()

@property (weak, nonatomic) IBOutlet UIButton *followButton;

@end

@implementation SMMyFansCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.followButton hzz_roundedCornerWithRadius:6.0f cornerColor:[UIColor whiteColor] corners:UIRectCornerAllCorners];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
