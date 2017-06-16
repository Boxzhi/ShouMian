//
//  SMStoreSecondCell.m
//  Shoumian
//
//  Created by 何志志 on 2017/3/1.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMStoreSecondCell.h"

@interface SMStoreSecondCell()

@property (weak, nonatomic) IBOutlet UILabel *firstTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *firstPriceLab;
@property (weak, nonatomic) IBOutlet UILabel *secondTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *secondPriceLab;
@property (weak, nonatomic) IBOutlet UILabel *thirdTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *thirdPriceLab;

@end

@implementation SMStoreSecondCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    if (iPhone5) {
        self.firstTitleLab.font = self.secondTitleLab.font = self.thirdTitleLab.font = FONTSIZE(13);
        self.firstPriceLab.font = self.secondPriceLab.font = self.thirdPriceLab.font = FONTSIZE(11);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
