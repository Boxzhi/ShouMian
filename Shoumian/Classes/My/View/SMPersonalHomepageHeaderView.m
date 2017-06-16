//
//  SMPersonalHomepageHeaderView.m
//  Shoumian
//
//  Created by 何志志 on 2017/3/15.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMPersonalHomepageHeaderView.h"

@interface SMPersonalHomepageHeaderView()

@property (weak, nonatomic) IBOutlet UILabel *fansLab;

@property (weak, nonatomic) IBOutlet UILabel *followLab;

@end

@implementation SMPersonalHomepageHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.privateletterBtn.layer.borderWidth = 0.5f;
    self.privateletterBtn.layer.borderColor = UIColorRed.CGColor;
    
    SMWeakSelf;
    self.fansLab.attributedText = [NSString addFollowFansAttributedString:@"粉丝  2631" leftColor:UIColor666 rightColor:UIColorRed];
    [self.fansLab hyb_addTapGestureWithCallback:^(UITapGestureRecognizer *sender) {
        if (weakSelf.fansLabClick) {
            weakSelf.fansLabClick();
        }
    }];
    self.followLab.attributedText  = [NSString addFollowFansAttributedString:@"关注  432" leftColor:UIColor666 rightColor:UIColorRed];
    [self.followLab hyb_addTapGestureWithCallback:^(UITapGestureRecognizer *sender) {
        if (weakSelf.followLabClick) {
            weakSelf.followLabClick();
        }
    }];
}

@end
