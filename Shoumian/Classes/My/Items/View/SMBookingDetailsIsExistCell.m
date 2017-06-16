//
//  SMBookingDetailsIsExistCell.m
//  Shoumian
//
//  Created by 何志志 on 2017/3/20.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMBookingDetailsIsExistCell.h"

@implementation SMBookingDetailsIsExistCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUI];
    }
    return self;
}

- (void)setUI{
    UILabel *lab1 = [UILabel hyb_labelWithFont:15 superView:self.contentView constraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(SMMargin);
        make.top.mas_offset(20);
        make.right.mas_offset(-SMMargin);
    }];
    lab1.text = @"医院确认时间：2017/03/20";
    
    UILabel *lab2 = [UILabel hyb_labelWithFont:15 superView:self.contentView constraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(SMMargin);
        make.top.equalTo(lab1.mas_bottom).offset(10);
        make.right.mas_offset(-SMMargin);
        make.bottom.mas_offset(-20);
    }];
    lab2.text = @"备注：术前不要喝水。还晒哈萨克活动卡时间的话静安寺的好时机安徽按实际回到家昂山素季电视剧爱上达克赛德哈酒金沙江的哈师大按时接电话静安寺带回家按时";
    lab2.numberOfLines = 0;
    
    lab1.textColor = lab2.textColor = UIColor333;
}


@end
