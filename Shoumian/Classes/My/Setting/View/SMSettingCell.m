//
//  SMSettingCell.m
//  Shoumian
//
//  Created by 何志志 on 2017/3/11.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMSettingCell.h"

@interface SMSettingCell()

@property (weak, nonatomic) IBOutlet UIImageView *iv;

@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@end

@implementation SMSettingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setImageTitle:(NSArray *)imageTitle{
    _imageTitle = imageTitle;
    
    self.iv.image = [UIImage imageNamed:_imageTitle[0]];
    self.titleLab.text = _imageTitle[1];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
