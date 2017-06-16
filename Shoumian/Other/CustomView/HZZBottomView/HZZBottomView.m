//
//  HZZBottomView.m
//  Shoumian
//
//  Created by 何志志 on 2017/2/23.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "HZZBottomView.h"
#import "UIColor+SMCustomColor.h"

@interface HZZBottomView()

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSArray *colors;
@property (nonatomic, assign) NSInteger tagBase;

@end

@implementation HZZBottomView


- (instancetype)initWithRect:(CGRect)rect titles:(NSArray *)titles images:(NSArray *)images colors:(NSArray *)colors tagBase:(NSInteger)tagBase {
    self = [super initWithFrame:rect];
    
    self.titles = titles;
    self.images = images;
    self.colors = colors;
    self.tagBase = tagBase;
    [self setupLayout];
    
    return self;
}

- (void)setupLayout{
    
    CGFloat count = self.titles.count;
    for (int i = 0; i < count; i++) {
        UIButton *btn = ({
            btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:self.titles[i] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:self.images[i]] forState:UIControlStateNormal];
            [btn setBackgroundColor:[UIColor colorWithHexString:self.colors[i] alpha:1]];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.tag = self.tagBase + i;
            [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
            [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
            [btn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:10];
            [self addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(self);
                make.width.mas_equalTo(S_Width / count);
                make.left.mas_offset(S_Width / count * i);
            }];
            btn;
        });
    }
}

- (void)clickBtn:(UIButton *)btn{
    if (self.hZZBottomClickBlock) {
        self.hZZBottomClickBlock(btn.tag - self.tagBase);
    }
}

@end
