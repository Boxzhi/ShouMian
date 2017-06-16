//
//  SMShoppingCartController.m
//  Shoumian
//
//  Created by 何志志 on 2017/3/21.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMShoppingCartController.h"
#import "SMShoppingCartHeadView.h"
#import "SMShoppingCartCell.h"


@interface SMShoppingCartController ()

@end

@implementation SMShoppingCartController

static NSString * const headViewId = @"headViewId";
static NSString * const scCellId = @"scCellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"购物车";
    [self.view addSubview:self.contentTabGrouped];
    self.contentTabGrouped.frame = CGRectMake(0, 0, S_Width, S_Height - SMNavHeight - SMBottomHeight);
    [self.contentTabGrouped registerNib:[UINib nibWithNibName:NSStringFromClass([SMShoppingCartHeadView class]) bundle:nil] forHeaderFooterViewReuseIdentifier:headViewId];
    [self.contentTabGrouped registerNib:[UINib nibWithNibName:NSStringFromClass([SMShoppingCartCell class]) bundle:nil] forCellReuseIdentifier:scCellId];
    [self setBottomView];
    
}

//  底部全选总价
- (void)setBottomView{
    UIView *bottomView = [UIView hyb_viewWithSuperView:self.view constraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(SMBottomHeight);
    }];
    bottomView.backgroundColor = [UIColor whiteColor];
    
    UIButton *settlementBtn = [UIButton hyb_buttonWithTitle:@"结算" superView:bottomView constraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(bottomView);
        make.width.mas_equalTo(S_Width * 92 / 375);
    } touchUp:^(UIButton *sender) {
        
    }];
    [settlementBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [settlementBtn setBackgroundColor:UIColorRed];
    [settlementBtn.titleLabel setFont:FONTSIZE(15)];
    
    UIView *lineView = [UIView hyb_viewWithSuperView:bottomView constraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(bottomView);
        make.right.equalTo(settlementBtn.mas_left);
        make.height.mas_equalTo(SMLineViewHeight);
    }];
    lineView.backgroundColor = LineViewBackgroundColor;
    
    UIButton *allSelectBtn = [UIButton hyb_buttonWithImage:@"my_xiala_quan_hui" selectedImage:@"my_gou_red" superView:bottomView constraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(SMMargin);
        make.top.bottom.equalTo(bottomView);
        make.width.mas_equalTo(60);
    } touchUp:^(UIButton *sender) {
        sender.selected = !sender.selected;
    }];
    [allSelectBtn setTitle:@"全选" forState:UIControlStateNormal];
    [allSelectBtn setTitleColor:UIColor333 forState:UIControlStateNormal];
    [allSelectBtn.titleLabel setFont:FONTSIZE(15)];
    [allSelectBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:5];
    
    UILabel *priceLab = [UILabel hyb_labelWithFont:15 superView:bottomView constraints:^(MASConstraintMaker *make) {
        make.left.equalTo(allSelectBtn.mas_right).offset(25);
        make.centerY.equalTo(allSelectBtn.mas_centerY);
    }];
    priceLab.attributedText = [NSString addTotalPriceAttributedString:@"合计：¥ 4800" leftColor:UIColor333 rightColor:UIColorRed];
    
    UILabel *freightLab = [UILabel hyb_labelWithText:@"不含运费" font:13 superView:bottomView constraints:^(MASConstraintMaker *make) {
        make.left.equalTo(priceLab.mas_right).offset(10);
        make.bottom.equalTo(priceLab.mas_bottom);
    }];
    freightLab.textColor = UIColor999;
    
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 3;
    }else{
        return 2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    SMShoppingCartHeadView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headViewId];
    headView.contentView.backgroundColor = [UIColor whiteColor];
    return headView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SMShoppingCartCell *cell = [tableView dequeueReusableCellWithIdentifier:scCellId forIndexPath:indexPath];
    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
