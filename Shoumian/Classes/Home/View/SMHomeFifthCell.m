//
//  SMHomeFifthCell.m
//  Shoumian
//
//  Created by 何志志 on 2017/2/13.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMHomeFifthCell.h"

@interface SMHomeFifthCell()

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *signatureLab;
@property (weak, nonatomic) IBOutlet UILabel *tagLab;
@property (weak, nonatomic) IBOutlet UILabel *anliNumLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@property (weak, nonatomic) IBOutlet UIButton *tagButton;

@property (weak, nonatomic) IBOutlet UIButton *browseBtn;
@property (weak, nonatomic) IBOutlet UIButton *praiseBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;

@property (weak, nonatomic) IBOutlet UIButton *homeBqButton;

@end

@implementation SMHomeFifthCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    if (iPhone5) {
        self.nameLab.font = FONTSIZE(14);
        self.signatureLab.font = self.tagLab.font = self.anliNumLab.font = self.timeLab.font = FONTSIZE(11);
        [self.tagButton.titleLabel setFont:FONTSIZE(11)];
        [self.browseBtn.titleLabel setFont:FONTSIZE(11)];
        [self.praiseBtn.titleLabel setFont:FONTSIZE(11)];
        [self.commentBtn.titleLabel setFont:FONTSIZE(11)];
    }
    
    self.tagButton.layer.borderColor = UIColorFromRGB(0xc8d3e8).CGColor;
    
    NSString *btnStr = @" 术后\n第8天";
    [self.homeBqButton setTitle:btnStr forState:UIControlStateNormal];
    self.homeBqButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
