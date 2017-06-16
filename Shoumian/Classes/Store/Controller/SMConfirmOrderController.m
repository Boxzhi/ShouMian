//
//  SMConfirmOrderController.m
//  Shoumian
//
//  Created by 何志志 on 2017/3/9.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMConfirmOrderController.h"
#import "SMConfirmOrderCell.h"
#import "SMUseCouponController.h"
#import "SMPayOrderViewController.h"

@interface SMConfirmOrderController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIButton *aliBtn;
@property (nonatomic, strong) UIButton *wxBtn;

@property (nonatomic, copy) NSString *CommodityName;
@property (nonatomic, copy) NSString *Number;
@property (nonatomic, copy) NSString *Price;

@end

@implementation SMConfirmOrderController

//  底部View的高度
#define bottomViewHeight 45.0f

static NSString * const coCellId = @"coCellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"确认订单";
    
    [self.view addSubview:self.contentTabGrouped];
    self.contentTabGrouped.frame = CGRectMake(0, 0, S_Width, S_Height - SMNavHeight - bottomViewHeight);
    [self.contentTabGrouped registerNib:[UINib nibWithNibName:NSStringFromClass([SMConfirmOrderCell class]) bundle:nil] forCellReuseIdentifier:coCellId];
    self.contentTabGrouped.rowHeight = 117;
    [self setHeaderFooterView];
    
    [self setBottomView];
}

#pragma mark - tableView的headerView和FooterView
- (void)setHeaderFooterView{
    
    //  HeaderView
    UIView *supHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, S_Width, 60)];
    supHeadView.backgroundColor = ViewBackgroundColor;
    
    UIView *headView = [UIView hyb_viewWithSuperView:supHeadView constraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(supHeadView);
        make.height.mas_equalTo(supHeadView.sm_height * 5 / 6);
    }];
    headView.backgroundColor = [UIColor whiteColor];
    
    UILabel *hospitalLab = [UILabel hyb_labelWithText:@"医院名称" font:15 superView:headView constraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(SMMargin);
        make.centerY.equalTo(headView.mas_centerY);
    }];
    hospitalLab.textColor = UIColor333;
    
    UILabel *hospitalNameLab = [UILabel hyb_labelWithFont:15 superView:headView constraints:^(MASConstraintMaker *make) {
        make.left.equalTo(hospitalLab.mas_right).offset(40);
        make.centerY.equalTo(headView.mas_centerY);
    }];
    hospitalNameLab.text = @"圣爱医院";
    hospitalNameLab.textColor = UIColor666;
    
    self.contentTabGrouped.tableHeaderView = supHeadView;
    
    //  FooterView
    UIView *supFootView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, S_Width, 100)];
    
    UIView *line1 = [UIView hyb_viewWithSuperView:supFootView constraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(supFootView);
        make.centerY.equalTo(supFootView.mas_centerY);
        make.height.mas_equalTo(SMLineViewHeight);
    }];
    line1.backgroundColor = LineViewBackgroundColor;
    line1.alpha = 0.5;
    UIView *line2 = [UIView hyb_viewWithSuperView:supFootView constraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(supFootView);
        make.height.mas_equalTo(SMLineViewHeight);
    }];
    line2.backgroundColor = LineViewBackgroundColor;
    // 手机号
    UIView *view1 = [UIView hyb_viewWithSuperView:supFootView constraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(supFootView);
        make.bottom.equalTo(line1.mas_top);
    }];
    view1.backgroundColor = [UIColor whiteColor];
          //  联系手机
    UILabel *phoneNumLab = [UILabel hyb_labelWithText:@"联系手机" font:15 superView:view1 constraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(SMMargin);
        make.centerY.equalTo(view1.mas_centerY);
        make.width.mas_equalTo(70);
    }];
    phoneNumLab.textColor = UIColor333;
    UITextField *field = [UITextField hyb_textFieldWithHolder:nil delegate:self superView:view1 constraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneNumLab.mas_right).offset(40);
        make.top.bottom.right.equalTo(view1);
    }];
    field.textColor = UIColor666;
    field.font = [UIFont systemFontOfSize:15];
    field.text = @"13245098604";
    
    //  优惠券
    UIView *view2 = [UIView hyb_viewWithSuperView:supFootView constraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(supFootView);
        make.top.equalTo(line1.mas_bottom);
        make.bottom.equalTo(line2.mas_top);
    }];
    view2.backgroundColor = [UIColor whiteColor];
    SMWeakSelf;
    [view2 hyb_addTapGestureWithCallback:^(UITapGestureRecognizer *sender) {
          //  跳转到使用优惠券界面
        SMUseCouponController *ucVc = [[SMUseCouponController alloc] init];
        [weakSelf.navigationController pushViewController:ucVc animated:YES];
    }];
          //  已自动为你选择优惠券
    UILabel *couponLab = [UILabel hyb_labelWithText:@"已自动为你选择优惠券" font:15 superView:view2 constraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(SMMargin);
        make.centerY.equalTo(view2.mas_centerY);
        make.width.mas_equalTo(160);
    }];
    couponLab.textColor = UIColor333;
    UIImageView *intoImage = [UIImageView hyb_imageViewWithImage:@"community_into" superView:view2 constraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-SMMargin);
        make.centerY.equalTo(view2.mas_centerY);
        make.height.width.mas_equalTo(15);
    }];
    UILabel *couponLab2 = [UILabel hyb_labelWithFont:14 superView:view2 constraints:^(MASConstraintMaker *make) {
        make.left.equalTo(couponLab.mas_right).offset(40);
        make.centerY.equalTo(view2.mas_centerY);
        make.right.equalTo(intoImage.mas_left).offset(-10);
    }];
    couponLab2.textColor = UIColorRed;
    couponLab2.text = @"减50：新品优惠满100减50...";
    
    
    self.contentTabGrouped.tableFooterView = supFootView;
}

#pragma mark - 底部提交订单View
- (void)setBottomView{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, S_Height - bottomViewHeight - SMNavHeight, S_Width, bottomViewHeight)];
    bottomView.backgroundColor = [UIColor whiteColor];
    
    //  总计
    UILabel *totalLab = [UILabel hyb_labelWithText:@"总计" font:14 superView:bottomView constraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(SMMargin);
        make.centerY.equalTo(bottomView.mas_centerY);
    }];
    totalLab.textColor = UIColor666;
    
    //  价格
    UILabel *priceLab = [UILabel hyb_labelWithFont:17 superView:bottomView constraints:^(MASConstraintMaker *make) {
        make.left.equalTo(totalLab.mas_right).offset(10);
        make.centerY.equalTo(bottomView.mas_centerY);
    }];
    priceLab.textColor = UIColorRed;
    priceLab.text = @"¥ 500";

    
    // 提交订单按钮
    SMWeakSelf;
    UIButton *submitBtn = [UIButton hyb_buttonWithTitle:@"提交订单" superView:bottomView constraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(bottomView);
        make.width.mas_equalTo(S_Width * 125 / 375);
    } touchUp:^(UIButton *sender) {
        SMLog(@"提交订单");
        [weakSelf setCoverView];
    }];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn setBackgroundColor:UIColorRed];
    
    UIView *lineView = [UIView hyb_viewWithSuperView:bottomView constraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(bottomView);
        make.height.mas_equalTo(0.5);
        make.right.equalTo(submitBtn.mas_left);
    }];
    lineView.backgroundColor = LineViewBackgroundColor;
    
    [self.view addSubview:bottomView];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SMConfirmOrderCell *coCell = [tableView dequeueReusableCellWithIdentifier:coCellId forIndexPath:indexPath];
    self.CommodityName = coCell.commodityNameLab.text;
    self.Number = coCell.numLab.text;
    self.Price = coCell.priceLab.text;
    return coCell;
};

#pragma mark - 支付方式选择
- (void)setCoverView{
    SMWeakSelf;
    UIView *coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, S_Width, S_Height)];
    coverView.backgroundColor = RGBA(0, 0, 0, 0.5);
    [coverView hyb_addTapGestureWithCallback:^(UITapGestureRecognizer *sender) {
        [coverView removeFromSuperview];
    }];
    
    UIView *whiteView = [UIView hyb_viewWithSuperView:coverView constraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(350);
        make.left.right.bottom.equalTo(coverView);
    }];
    whiteView.backgroundColor = [UIColor whiteColor];
    
    //   商品名称、需支付、支付方式
    UIView *firstView = [UIView hyb_viewWithSuperView:whiteView constraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(whiteView);
        make.height.mas_equalTo(140);
    }];
    firstView.backgroundColor = [UIColor whiteColor];
    UIView *fViewF = [UIView hyb_viewWithSuperView:firstView constraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(firstView);
        make.height.mas_equalTo(140 / 3);
    }];
    UIView *fViewS = [UIView hyb_viewWithSuperView:firstView constraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(firstView);
        make.top.equalTo(fViewF.mas_bottom);
        make.height.mas_equalTo(fViewF.mas_height);
    }];
    UIView *fViewT = [UIView hyb_viewWithSuperView:firstView constraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(firstView);
        make.top.equalTo(fViewS.mas_bottom);
        make.bottom.equalTo(firstView.mas_bottom);
    }];
    fViewF.backgroundColor = fViewS.backgroundColor = fViewT.backgroundColor = [UIColor whiteColor];
    
    UILabel *commodityLab = [UILabel hyb_labelWithText:@"商品名称：" font:15 superView:fViewF constraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(SMMargin);
        make.centerY.equalTo(fViewF.mas_centerY);
        make.width.mas_equalTo(80);
    }];
    
    // 商品名称及数量
    UILabel *commodityNameLab = [UILabel hyb_viewWithSuperView:fViewF constraints:^(MASConstraintMaker *make) {
        make.left.equalTo(commodityLab.mas_right).offset(0);
        make.centerY.equalTo(commodityLab.mas_centerY);
        make.right.mas_offset(-SMMargin);
    }];
    NSString *commodityNum = [self.Number substringFromIndex:3];
    commodityNameLab.attributedText = [NSString confirmOrderAttributStringWithCommodityStr:self.CommodityName leftColor:UIColor666 numberStr:commodityNum rightColor:UIColor999];
    
    
    UILabel *xuzhifuLab = [UILabel hyb_labelWithText:@"需支付：" font:15 superView:fViewS constraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(SMMargin);
        make.centerY.equalTo(fViewS.mas_centerY);
        make.width.mas_equalTo(65);
    }];
    //  价格
    UILabel *priceLab = [UILabel hyb_labelWithText:self.Price font:17 superView:fViewS constraints:^(MASConstraintMaker *make) {
        make.left.equalTo(xuzhifuLab.mas_right).offset(0);
        make.centerY.equalTo(fViewS.mas_centerY);
    }];
    priceLab.textColor = UIColorRed;
    
    
    UILabel *zffsLab = [UILabel hyb_labelWithText:@"支付方式" font:15 superView:fViewT constraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(SMMargin);
        make.centerY.equalTo(fViewT.mas_centerY);
    }];
    commodityLab.textColor = xuzhifuLab.textColor = zffsLab.textColor = UIColor333;
    UIView *lineView = [UIView hyb_addBottomLineToView:firstView height:SMLineViewHeight color:LineViewBackgroundColor];
    
    //   支付宝、微信
    CGFloat awH = 60;
         // 支付宝
    UIView *aliView = [UIView hyb_viewWithSuperView:whiteView constraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(whiteView);
        make.top.equalTo(firstView.mas_bottom);
        make.height.mas_equalTo(awH);
    }];
    [aliView hyb_addTapGestureWithCallback:^(UITapGestureRecognizer *sender) {
        weakSelf.aliBtn.selected = YES;
        weakSelf.wxBtn.selected = NO;
    }];
    UIButton *aliBtn = [UIButton hyb_buttonWithImage:@"mall_icon_quan" selectedImage:@"mall_icon_gou_red" superView:aliView constraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(SMMargin);
        make.height.width.mas_equalTo(18);
        make.centerY.equalTo(aliView.mas_centerY);
    } touchUp:^(UIButton *sender) {
        weakSelf.aliBtn.selected = YES;
        weakSelf.wxBtn.selected = NO;
    }];
    self.aliBtn = aliBtn;
    aliBtn.selected = YES;
    UIImageView *aliImage = [UIImageView hyb_imageViewWithImage:@"mall_zhifub" superView:aliView constraints:^(MASConstraintMaker *make) {
        make.left.equalTo(aliBtn.mas_right).offset(30);
        make.height.width.mas_equalTo(40);
        make.centerY.equalTo(aliView.mas_centerY);
    }];
    UILabel *aliLab = [UILabel hyb_labelWithText:@"支付宝支付" font:15 superView:aliView constraints:^(MASConstraintMaker *make) {
        make.left.equalTo(aliImage.mas_right).offset(25);
        make.centerY.equalTo(aliView.mas_centerY);
    }];
    aliLab.textColor = UIColor333;
    UIView *aliLine = [UIView hyb_addBottomLineToView:aliView height:SMLineViewHeight color:LineViewBackgroundColor];
    
         //  微信
    UIView *wxView = [UIView hyb_viewWithSuperView:whiteView constraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(whiteView);
        make.top.equalTo(aliView.mas_bottom);
        make.height.mas_equalTo(awH);
    }];
    [wxView hyb_addTapGestureWithCallback:^(UITapGestureRecognizer *sender) {
        weakSelf.aliBtn.selected = NO;
        weakSelf.wxBtn.selected = YES;
    }];
    UIButton *wxBtn = [UIButton hyb_buttonWithImage:@"mall_icon_quan" selectedImage:@"mall_icon_gou_red" superView:wxView constraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(SMMargin);
        make.height.width.mas_equalTo(18);
        make.centerY.equalTo(wxView.mas_centerY);
    } touchUp:^(UIButton *sender) {
        weakSelf.aliBtn.selected = NO;
        weakSelf.wxBtn.selected = YES;
    }];
    self.wxBtn = wxBtn;
    UIImageView *wxImage = [UIImageView hyb_imageViewWithImage:@"mall_weixin" superView:wxView constraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wxBtn.mas_right).offset(30);
        make.height.width.mas_equalTo(40);
        make.centerY.equalTo(wxView.mas_centerY);
    }];
    UILabel *wxLab = [UILabel hyb_labelWithText:@"微信支付" font:15 superView:wxView constraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wxImage.mas_right).offset(25);
        make.centerY.equalTo(wxView.mas_centerY);
    }];
    wxLab.textColor = UIColor333;
    UIView *wxLine = [UIView hyb_addBottomLineToView:wxView height:SMLineViewHeight color:LineViewBackgroundColor];
    
    UIView *payView = [UIView hyb_viewWithSuperView:whiteView constraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wxView.mas_bottom);
        make.left.right.bottom.equalTo(whiteView);
    }];
    UIButton *payBtn = [UIButton hyb_buttonWithTitle:@"确认支付" superView:whiteView constraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(S_Width * 275 / 375);
        make.height.mas_equalTo(40);
        make.center.equalTo(payView);
    } touchUp:^(UIButton *sender) {
        SMLog(@"确认支付");
        [coverView removeFromSuperview];
        SMPayOrderViewController *poVc = [[SMPayOrderViewController alloc] init];
        [self.navigationController pushViewController:poVc animated:YES];
    }];
    [payBtn.titleLabel setFont:FONTSIZE(15)];
    [payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [payBtn setBackgroundColor:UIColorRed];
    payBtn.layer.masksToBounds = YES;
    payBtn.layer.cornerRadius = 15;
    
    [SMKeyWindow addSubview:coverView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
