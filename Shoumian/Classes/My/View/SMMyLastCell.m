//
//  SMMyLastCell.m
//  Shoumian
//
//  Created by 何志志 on 2017/1/22.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMMyLastCell.h"

@interface SMMyLastCell()

@property (weak, nonatomic) IBOutlet UIView *orderItemView;
@property (weak, nonatomic) IBOutlet UIView *appointmentItemView;
@property (weak, nonatomic) IBOutlet UIView *memberItemView;
@property (weak, nonatomic) IBOutlet UIView *shareItemView;
@property (weak, nonatomic) IBOutlet UIView *serviceItemView;
@property (weak, nonatomic) IBOutlet UIView *privateItemView;

@end

@implementation SMMyLastCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    SMWeakSelf;
    [self.orderItemView hyb_addTapGestureWithCallback:^(UITapGestureRecognizer *sender) {
        [weakSelf clickItemViewWithIndex:0];
    }];
    [self.appointmentItemView hyb_addTapGestureWithCallback:^(UITapGestureRecognizer *sender) {
        [weakSelf clickItemViewWithIndex:1];
    }];
    [self.memberItemView hyb_addTapGestureWithCallback:^(UITapGestureRecognizer *sender) {
        [weakSelf clickItemViewWithIndex:2];
    }];
    [self.shareItemView hyb_addTapGestureWithCallback:^(UITapGestureRecognizer *sender) {
        [weakSelf clickItemViewWithIndex:3];
    }];
    [self.serviceItemView hyb_addTapGestureWithCallback:^(UITapGestureRecognizer *sender) {
        [weakSelf clickItemViewWithIndex:4];
    }];
    [self.privateItemView hyb_addTapGestureWithCallback:^(UITapGestureRecognizer *sender) {
        [weakSelf clickItemViewWithIndex:5];
    }];
}

- (void)clickItemViewWithIndex:(NSInteger)index{
    if (self.clickItemViewBlock) {
        self.clickItemViewBlock(index);
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
