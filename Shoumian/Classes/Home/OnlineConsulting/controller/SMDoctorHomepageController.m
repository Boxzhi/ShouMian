//
//  SMDoctorHomepageController.m
//  Shoumian
//
//  Created by 何志志 on 2017/2/15.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMDoctorHomepageController.h"
#import "SMDoctorHomepageHeaderView.h"
#import "SMHomeFifthCell.h"
#import "SMHospitalHomepageFifthCell.h"
#import "SMLeavewordController.h"
#import "HZZBottomView.h"

@interface SMDoctorHomepageController ()

@property (nonatomic, assign) BOOL isFirst;

@end

@implementation SMDoctorHomepageController

static NSString * const userCaseCellId = @"userCaseCellId";
static NSString * const userEvaluationCellId = @"userEvaluationCellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"医生主页";
//    self.view.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:self.contentTabGrouped];
    self.contentTabGrouped.backgroundColor = ViewBackgroundColor;
    
    self.contentTabGrouped.tableHeaderView = [SMDoctorHomepageHeaderView viewFromXib];
    [self.contentTabGrouped registerNib:[UINib nibWithNibName:NSStringFromClass([SMHomeFifthCell class]) bundle:nil] forCellReuseIdentifier:userCaseCellId];
    [self.contentTabGrouped registerNib:[UINib nibWithNibName:NSStringFromClass([SMHospitalHomepageFifthCell class]) bundle:nil] forCellReuseIdentifier:userEvaluationCellId];
    self.isFirst = YES;
    
    // 底部留言咨询按钮
    [self setBottomButton];
}

#pragma mark -- UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_isFirst) {  // 用户案例
        
        return 2;
    }else{  // 用户评价
        
        return 3;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 44 + 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isFirst) {
        if (iPhone5) {
            return 320;
        }else if (iPhone6){
            return 360;
        }else{
            return 380;
        }
    }else{
        self.contentTabGrouped.rowHeight = UITableViewAutomaticDimension;
        self.contentTabGrouped.estimatedRowHeight = 170;
        return self.contentTabGrouped.rowHeight;
    }
}

/**
 *  HeaderView
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UIView *lineView = [UIView hyb_addBottomLineToView:headerView height:1 color:ViewBackgroundColor];
    
    //  用户案例
    UIView *userCaseView = [UIView hyb_viewWithSuperView:headerView constraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(headerView);
        make.bottom.equalTo(lineView.mas_top);
        make.width.mas_equalTo(S_Width / 2);
    }];
    UILabel *userCaseLab = [UILabel hyb_viewWithSuperView:userCaseView constraints:^(MASConstraintMaker *make) {
        make.center.equalTo(userCaseView);
    }];
    userCaseLab.attributedText = [NSString attributStringWithString:@"用户日记 28"];
    //  下划线
    UIView *underlineView1 = [UIView hyb_viewWithSuperView:userCaseView constraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(userCaseView.mas_bottom);
        make.centerX.equalTo(userCaseView.mas_centerX);
        make.height.mas_equalTo(2);
        make.width.mas_equalTo(userCaseLab.mas_width);
    }];
    underlineView1.backgroundColor = UIColorRed;
    
    //  用户评价
    UIView *userEvaluationView = [UIView hyb_viewWithSuperView:headerView constraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userCaseView.mas_right);
        make.top.right.equalTo(headerView);
        make.bottom.equalTo(lineView.mas_top);
    }];
    UILabel *userEvaluationLab = [UILabel hyb_viewWithSuperView:userEvaluationView constraints:^(MASConstraintMaker *make) {
        make.center.equalTo(userEvaluationView);
    }];
    userEvaluationLab.attributedText = [NSString attributStringWithString:@"用户评价 435"];
    //  下划线
    UIView *underlineView2 = [UIView hyb_viewWithSuperView:userEvaluationView constraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(userEvaluationView.mas_bottom);
        make.centerX.equalTo(userEvaluationView.mas_centerX);
        make.height.mas_equalTo(2);
        make.width.mas_equalTo(userEvaluationLab.mas_width);
    }];
    underlineView2.backgroundColor = UIColorRed;

    if (_isFirst) {
        underlineView1.hidden = NO;
        underlineView2.hidden = YES;
    }else{
        underlineView1.hidden = YES;
        underlineView2.hidden = NO;
    }
    
    //  点击用户案例

    [userCaseView hyb_addTapGestureWithCallback:^(UITapGestureRecognizer *sender) {
        self.isFirst = YES;
        [self.contentTabGrouped reloadData];
    }];
    //  点击用户评价
    [userEvaluationView hyb_addTapGestureWithCallback:^(UITapGestureRecognizer *sender) {
        self.isFirst = NO;
        [self.contentTabGrouped reloadData];
    }];
    
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = [UIColor whiteColor];
    UILabel *lab = [UILabel hyb_labelWithText:@"点击查看更多" font:14 superView:footerView constraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(footerView.mas_centerX);
        make.top.mas_offset(5);
    }];
    lab.textColor = UIColor666;
    [lab hyb_addTapGestureWithCallback:^(UITapGestureRecognizer *sender) {
        SMLog(@"点击查看更多");
    }];

    return footerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isFirst) {
        SMHomeFifthCell *userCaseCell = [tableView dequeueReusableCellWithIdentifier:userCaseCellId forIndexPath:indexPath];
        return userCaseCell;
    }else{
        SMHospitalHomepageFifthCell *userEvaluationCell = [tableView dequeueReusableCellWithIdentifier:userEvaluationCellId forIndexPath:indexPath];
        return userEvaluationCell;
    }
    
};

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SMLog(@"点击cell");
}

#pragma mark - 底部留言咨询按钮
- (void)setBottomButton{
    NSArray *titleArr = [NSArray arrayWithObjects:@"留言", @"咨询", nil];
    NSArray *imageArr = [NSArray arrayWithObjects:@"home_liuyan", @"home_zixun", nil];
    NSArray *colorArr = [NSArray arrayWithObjects:@"A0A0A0", @"ff5050", nil];
    HZZBottomView *bottomView = [[HZZBottomView alloc] initWithRect:CGRectMake(0, S_Height - SMNavHeight - SMBottomHeight, S_Width, SMBottomHeight) titles:titleArr images:imageArr colors:colorArr tagBase:10020];
    [self.view addSubview:bottomView];
//    // 留言
//    UIView *bottomView = [UIView hyb_viewWithSuperView:self.view constraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(44);
//        make.left.bottom.right.equalTo(self.view);
//    }];
//    bottomView.backgroundColor = [UIColor whiteColor];
//    
//    UIButton *lmBtn = [UIButton hyb_buttonWithTitle:@"留言" superView:bottomView constraints:^(MASConstraintMaker *make) {
//        make.left.top.bottom.equalTo(bottomView);
//        make.width.mas_equalTo(S_Width / 2);
//    } touchUp:^(UIButton *sender) {
//        SMLog(@"留言");
//        SMLeavewordController *lwVc = [[SMLeavewordController alloc] init];
//        [self.navigationController pushViewController:lwVc animated:YES];
//    }];
//    [self setButtonCategoryWithButton:lmBtn image:[UIImage imageNamed:@"home_liuyan"] backgroundColor:RGB(160, 160, 160)];
//    
//    // 咨询
//    UIButton *csBtn = [UIButton hyb_buttonWithTitle:@"咨询" superView:bottomView constraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(lmBtn.mas_right);
//        make.top.right.bottom.equalTo(bottomView);
//    } touchUp:^(UIButton *sender) {
//        SMLog(@"咨询");
//    }];
//    [self setButtonCategoryWithButton:csBtn image:[UIImage imageNamed:@"home_zixun"] backgroundColor:UIColorRed];

}

- (void)setButtonCategoryWithButton:(UIButton *)btn image:(UIImage *)image backgroundColor:(UIColor *)backgroundColor{
    [btn setImage:image forState:UIControlStateNormal];
    btn.titleLabel.textColor = [UIColor whiteColor];
    [btn setBackgroundColor:backgroundColor];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [btn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:12.5];
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
