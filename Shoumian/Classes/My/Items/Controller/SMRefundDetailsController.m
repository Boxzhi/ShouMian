//
//  SMRefundDetailsController.m
//  Shoumian
//
//  Created by 何志志 on 2017/3/20.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMRefundDetailsController.h"
#import "SMRefundDetailsCell.h"

@interface SMRefundDetailsController ()

@property (nonatomic, assign) BOOL isYN;

@end

@implementation SMRefundDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.isYN = NO;
    [self.view addSubview:self.contentTabPlain];
    self.contentTabPlain.backgroundColor = [UIColor whiteColor];
    self.contentTabPlain.rowHeight = Reality_Height(180);
    [self setFooterView];
}

- (void)setFooterView{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, S_Width, 300)];
    footerView.backgroundColor = [UIColor whiteColor];
    
    CGFloat font = 13.0f;
    CGFloat leftMargin = 45.0f;
    CGFloat margin = 15.0f;
    if (_isYN) {  //  退款成功
        self.title = @"退款成功";
        UILabel *lab1 = [UILabel hyb_labelWithText:@"退款去向：微信/支付宝账户" font:font superView:footerView constraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(2 * SMMargin);
            make.left.mas_offset(leftMargin);
        }];
        UILabel *lab2 = [UILabel hyb_labelWithText:@"退款时间：2017/03/20" font:font superView:footerView constraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(leftMargin);
            make.top.equalTo(lab1.mas_bottom).offset(margin);
        }];
        UILabel *lab3 = [UILabel hyb_labelWithText:@"退款金额：¥ 455" font:font superView:footerView constraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(leftMargin);
            make.top.equalTo(lab2.mas_bottom).offset(margin);
        }];
        UILabel *lab4 = [UILabel hyb_labelWithText:@"退款原因：我暂时不太需要。" font:font superView:footerView constraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(leftMargin);
            make.top.equalTo(lab3.mas_bottom).offset(margin);
            make.right.mas_offset(-leftMargin);
        }];
        lab4.numberOfLines = 0;
        UILabel *lab5 = [UILabel hyb_labelWithText:@"申请时间：2017/02/20" font:font superView:footerView constraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(leftMargin);
            make.top.equalTo(lab4.mas_bottom).offset(margin);
        }];
        lab1.textColor = lab2.textColor = lab3.textColor = lab4.textColor = lab5.textColor = UIColor666;
    }else{  //  退款详情
        self.title = @"退款详情";
        UILabel *lab1 = [UILabel hyb_labelWithText:@"退款金额：¥ 455" font:font superView:footerView constraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(2 * SMMargin);
            make.left.mas_offset(leftMargin);
        }];
        UILabel *lab2 = [UILabel hyb_labelWithText:@"退款原因：我暂时不太需要。" font:font superView:footerView constraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(leftMargin);
            make.top.equalTo(lab1.mas_bottom).offset(margin);
            make.right.mas_offset(-leftMargin);
        }];
        lab2.numberOfLines = 0;
        UILabel *lab3 = [UILabel hyb_labelWithText:@"申请时间：2017/02/20" font:font superView:footerView constraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(leftMargin);
            make.top.equalTo(lab2.mas_bottom).offset(margin);
        }];
        lab1.textColor = lab2.textColor = lab3.textColor = UIColor666;
    }
    
    UILabel *phoneLab = [UILabel hyb_labelWithFont:13.0f superView:footerView constraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(footerView.mas_bottom);
        make.centerX.equalTo(footerView.mas_centerX);
    }];
    phoneLab.textColor = UIColor666;
    phoneLab.attributedText = [NSString addNSUnderlineStyleAttributeName:@"客服电话：0512-28734627"];
    
    self.contentTabPlain.tableFooterView = footerView;
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SMRefundDetailsCell *cell = [SMRefundDetailsCell viewFromXib];
    if (_isYN) {
        cell.successImage.image = [UIImage imageNamed:@"my_gou_blue"];
    }else{
        cell.successImage.image = [UIImage imageNamed:@"my_quan_blue"];
    }
    return cell;
};


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
