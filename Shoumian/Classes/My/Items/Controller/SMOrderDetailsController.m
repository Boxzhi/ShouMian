//
//  SMOrderDetailsController.m
//  Shoumian
//
//  Created by 何志志 on 2017/3/20.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMOrderDetailsController.h"
#import "SMMyOrderHeaderView.h"
#import "SMMyOrderCell.h"
#import "SMMyOrderFooterView.h"
#import "SMRefundRequestController.h"
#import "SMPublishedEvaluationController.h"

@interface SMOrderDetailsController ()

@end

@implementation SMOrderDetailsController

static NSString * const odCellId = @"odCellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"订单详情";
    [self.view addSubview:self.contentTabGrouped];
    self.contentTabGrouped.backgroundColor = [UIColor whiteColor];
    [self.contentTabGrouped registerNib:[UINib nibWithNibName:NSStringFromClass([SMMyOrderCell class]) bundle:nil] forCellReuseIdentifier:odCellId];
    [self setFooterView];
}

- (void)setFooterView{
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, S_Width, 230)];
    footView.backgroundColor = ViewBackgroundColor;
    
    UIView *fView = [UIView hyb_viewWithSuperView:footView constraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(footView);
        make.height.mas_equalTo(130);
    }];
    fView.backgroundColor = [UIColor whiteColor];
    CGFloat font = 14.0f;
    CGFloat margin = 10.0f;
    UILabel *lab1 = [UILabel hyb_labelWithText:@"订单号：115025687729" font:font superView:fView constraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(SMMargin);
        make.top.mas_offset(20);
        make.right.mas_offset(-SMMargin);
    }];
    UILabel *lab2 = [UILabel hyb_labelWithText:@"联系手机号：15270904724" font:font superView:fView constraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(SMMargin);
        make.right.mas_offset(-SMMargin);
        make.top.equalTo(lab1.mas_bottom).offset(margin);
    }];
    UILabel *lab3 = [UILabel hyb_labelWithText:@"下单时间：2017/03/20" font:font superView:fView constraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(SMMargin);
        make.right.mas_offset(-SMMargin);
        make.top.equalTo(lab2.mas_bottom).offset(margin);
    }];
    UILabel *lab4 = [UILabel hyb_labelWithText:@"支付方式：微信支付" font:font superView:fView constraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(SMMargin);
        make.right.mas_offset(-SMMargin);
        make.top.equalTo(lab3.mas_bottom).offset(margin);
    }];
    lab1.textColor = lab2.textColor = lab3.textColor = lab4.textColor = UIColor999;
    
    UIView *sView = [UIView hyb_viewWithSuperView:footView constraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(footView);
        make.top.equalTo(fView.mas_bottom).offset(margin);
    }];
    sView.backgroundColor = [UIColor whiteColor];
    
    // 根据订单类型决定按钮的类型
    BOOL isPay = NO;
    CGFloat btnFont = 14.0f;
    CGFloat btnHeight = 40.0f;
    SMWeakSelf;
    if (isPay) {
        
        UIButton *payBtn = [UIButton hyb_buttonWithTitle:@"付款" superView:sView constraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-SMMargin);
            make.centerY.equalTo(sView.mas_centerY);
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(btnHeight);
        } touchUp:^(UIButton *sender) {
            
        }];
        [payBtn.titleLabel setFont:FONTSIZE(btnFont)];
        [payBtn setBackgroundColor:UIColorRed];
        [payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [payBtn hzz_roundedCornerWithRadius:6 cornerColor:[UIColor whiteColor]];
        UIButton *cancelBtn = [UIButton hyb_buttonWithTitle:@"取消订单" superView:sView constraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(sView.mas_centerY);
            make.right.equalTo(payBtn.mas_left).offset(-25);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(btnHeight);
        } touchUp:^(UIButton *sender) {
            
        }];
        [cancelBtn setBackgroundColor:[UIColor whiteColor]];
        [cancelBtn setTitleColor:UIColorRed forState:UIControlStateNormal];
        [cancelBtn hzz_roundedCornerWithCornerRadii:CGSizeMake(6, 0) cornerColor:[UIColor clearColor] corners:UIRectCornerAllCorners borderColor:UIColorRed borderWidth:SMLineViewHeight];
        [cancelBtn.titleLabel setFont:FONTSIZE(btnFont)];
    }else{
        
        UIButton *refundBtn = [UIButton hyb_buttonWithTitle:@"申请退款" superView:sView constraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-SMMargin);
            make.centerY.equalTo(sView.mas_centerY);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(btnHeight);
        } touchUp:^(UIButton *sender) {
            SMRefundRequestController *rrVc = [[SMRefundRequestController alloc] init];
            [weakSelf.navigationController pushViewController:rrVc animated:YES];
        }];
        [refundBtn.titleLabel setFont:FONTSIZE(btnFont)];
        [refundBtn setTitleColor:UIColorRed forState:UIControlStateNormal];
        [refundBtn hzz_roundedCornerWithCornerRadii:CGSizeMake(6, 0) cornerColor:[UIColor clearColor] corners:UIRectCornerAllCorners borderColor:UIColorRed borderWidth:SMLineViewHeight];
    }
    
    self.contentTabGrouped.tableFooterView = footView;
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 160;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 150;
    }else{
        return 103;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    SMMyOrderHeaderView *headerView = [SMMyOrderHeaderView viewFromXib];
    headerView.contentView.backgroundColor = [UIColor whiteColor];
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    SMMyOrderFooterView *footerView = [SMMyOrderFooterView viewFromXib];
    footerView.contentView.backgroundColor = ViewBackgroundColor;
    footerView.orderBtn.hidden = YES;
    footerView.reimburseSumLab.hidden = YES;
    return footerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SMMyOrderCell *moCell = [tableView dequeueReusableCellWithIdentifier:odCellId forIndexPath:indexPath];
    SMWeakSelf;
    if (indexPath.row == 0) {
        moCell.bottomView.hidden = NO;
        moCell.evaluationBtnClickBlock = ^{  // 评价按钮
            SMPublishedEvaluationController *peVc = [[SMPublishedEvaluationController alloc] init];
            [weakSelf.navigationController pushViewController:peVc animated:YES];
        };
    }else{
        moCell.bottomView.hidden = YES;
    }
    return moCell;
};

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
