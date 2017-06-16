//
//  SMPersonalHomepageDiaryCell.m
//  Shoumian
//
//  Created by 何志志 on 2017/3/16.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMPersonalHomepageDiaryCell.h"

@interface SMPersonalHomepageDiaryCell()
@property (weak, nonatomic) IBOutlet UIButton *shouHouBtn;

@end

@implementation SMPersonalHomepageDiaryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    NSString *btnStr = @" 术后\n第8天";
    [self.shouHouBtn setTitle:btnStr forState:UIControlStateNormal];
    self.shouHouBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
