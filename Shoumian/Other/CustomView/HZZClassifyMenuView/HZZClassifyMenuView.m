//
//  HZZClassifyMenuView.m
//  Shoumian
//
//  Created by 何志志 on 2017/2/23.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "HZZClassifyMenuView.h"
#import "HZZButton.h"

@interface HZZClassifyMenuView()

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIImage *image;

@end

@implementation HZZClassifyMenuView

#pragma mark - 构造
- (instancetype)initWithRect:(CGRect)rect buttonTitles:(NSArray *)titles titleColor:(UIColor *)titleColor image:(UIImage *)image clickBlock:(void(^)(int index, HZZButton *btn))clickBlock{
    
    if (self = [super initWithFrame:rect]) {
        
        if (image && image != nil) {
            self.image = image;
        }else{
            self.image = [UIImage imageNamed:@"home_xiala"];
        }
        if (titleColor && titleColor != nil) {
            self.titleColor = titleColor;
        }else{
            self.titleColor = UIColor666;
        }
        self.titles = titles;
        self.hzzButtonClickBlock = clickBlock;
        [self setupLayout];
    }
    return self;
}


#pragma mark - UI
- (void)setupLayout{
    
    self.backgroundColor = [UIColor whiteColor];
    
    // 底部一条分割线
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = LineViewBackgroundColor;
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
    
    
    NSInteger count = self.titles.count;
    for (int i = 0; i < count; i++) {
        
        HZZButton *btn = ({    // 按钮
            
            btn = [HZZButton buttonWithType:UIButtonTypeCustom];
            btn.backgroundColor = [UIColor whiteColor];
            [btn setImage:self.image forState:UIControlStateNormal];
            [btn setTitle:self.titles[i] forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
            [btn setTitleColor:self.titleColor forState:UIControlStateNormal];
            btn.index = i;
            [btn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:10];
            [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.mas_top);
                make.bottom.equalTo(lineView.mas_top);
                make.left.mas_offset(S_Width / count * i);
                make.width.mas_equalTo(S_Width / count);
            }];
            btn;
            
        });
        
        if (count > 1) {
            CGFloat lineNum = count - 1;
            for (int y = 0; y < lineNum; y++) {
                
                UIView *verticalLine = ({    // 中间分割线
                   
                    verticalLine = [[UIView alloc] init];
                    verticalLine.backgroundColor = LineViewBackgroundColor;
                    [self addSubview:verticalLine];
                    [verticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.mas_offset(S_Width / count * (y + 1));
                        make.centerY.equalTo(self.mas_centerY);
                        make.height.mas_equalTo(self.sm_height * 14 / 45);
                        make.width.mas_equalTo(1);
                    }];
                    verticalLine;
                    
                });
            }
            
        }
        
    }
}


#pragma mark - 按钮点击
- (void)clickBtn:(HZZButton *)btn{
    if (self.hzzButtonClickBlock) {
        self.hzzButtonClickBlock(btn.index, btn);
    }
}

@end
