//
//  SMPublishedEvaluationSecondCell.m
//  Shoumian
//
//  Created by 何志志 on 2017/3/21.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMPublishedEvaluationSecondCell.h"
#import "XHStarRateView.h"

@interface SMPublishedEvaluationSecondCell()

@property (weak, nonatomic) IBOutlet UIView *startView;
@property (weak, nonatomic) IBOutlet UIView *tagView;

@end

@implementation SMPublishedEvaluationSecondCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    XHStarRateView *starRateView = [[XHStarRateView alloc] initWithFrame:CGRectMake(0, 0, self.startView.sm_width, self.startView.sm_height) finish:^(CGFloat currentScore) {
        
    }];
    [self.startView addSubview:starRateView];
    
    NSArray *arr = [NSArray arrayWithObjects:@"哈哈哈", @"很好", @"专业", @"服务好", @"医生专业", @"回访尽责", @"非常棒", @"完美", @"还会来", @"下次再来来来", @"啊哈哈哈哈哈哈", nil];
    
    CGFloat totalW = 0;  //
    CGFloat margin = 15;  //  左右上下间距
    CGFloat btnH = 20;  //  按钮高度
    CGFloat y = 0;
    
    for (int i = 0; i < arr.count; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn setTitleColor:UIColorBlue forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn.titleLabel setFont:FONTSIZE(13)];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 10;
        btn.layer.borderWidth = SMLineViewHeight;
        btn.layer.borderColor = UIColorBlue.CGColor;
        
        // 根据文字算出按钮宽度
        NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:13]};
        CGFloat btnW = [arr[i] sizeWithAttributes:attrs].width + 20;
        
        if (totalW + btnW + self.tagView.sm_x > S_Width) {  // 换行
            totalW = 0;
            y = y + btnH + margin;
        }
        btn.frame = CGRectMake(totalW, y, btnW, btnH);
        totalW = totalW + btnW + margin;
        
        [self.tagView addSubview:btn];
    }
}

- (void)btnClick:(UIButton *)button{
    
    if (!button.selected) {  // 如果该按钮不是选中状态
        button.selected = YES;
        [button setBackgroundColor:UIColorBlue];
        if (self.tagBtnClickBlock) {
            self.tagBtnClickBlock(button.titleLabel.text);
        }
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
