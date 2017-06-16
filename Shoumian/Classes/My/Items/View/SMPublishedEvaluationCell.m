//
//  SMPublishedEvaluationCell.m
//  Shoumian
//
//  Created by 何志志 on 2017/3/21.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMPublishedEvaluationCell.h"

@implementation SMPublishedEvaluationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUI];
    }
    return self;
}

- (void)setUI{
    UIImageView *image = [UIImageView hyb_imageViewWithSuperView:self.contentView constraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(SMMargin);
        make.width.mas_equalTo(83);
        make.height.mas_equalTo(73);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    image.image = [UIImage imageNamed:@"my_img_xiangmu"];
    
    UILabel *priceLab = [UILabel hyb_labelWithFont:17 superView:self.contentView constraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-SMMargin);
        make.top.equalTo(image.mas_top).offset(10);
        make.width.mas_equalTo(80);
    }];
    priceLab.textColor = UIColorRed;
    priceLab.text = @"¥ 500990";
    priceLab.textAlignment = NSTextAlignmentRight;
    
    UILabel *lab1 = [UILabel hyb_labelWithFont:15 superView:self.contentView constraints:^(MASConstraintMaker *make) {
        make.left.equalTo(image.mas_right).offset(15);
        make.top.equalTo(image.mas_top).offset(10);
        make.right.equalTo(priceLab.mas_left).offset(-10);
    }];
    lab1.textColor = UIColor333;
    lab1.text = @"激光美白";
    
    UILabel *lab2 = [UILabel hyb_labelWithFont:13 superView:self.contentView constraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lab1.mas_left);
        make.top.equalTo(lab1.mas_bottom).offset(10);
    }];
    lab2.textColor = UIColor666;
    lab2.text = @"单次/全身";
    
    UILabel *numLab = [UILabel hyb_labelWithFont:15 superView:self.contentView constraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-SMMargin);
        make.centerY.equalTo(lab2.mas_centerY);
    }];
    numLab.textColor = UIColor333;
    numLab.text = @"x2";
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
