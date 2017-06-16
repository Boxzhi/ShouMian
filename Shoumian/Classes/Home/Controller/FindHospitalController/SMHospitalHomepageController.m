//
//  SMHospitalHomepageController.m
//  Shoumian
//
//  Created by 何志志 on 2017/2/16.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMHospitalHomepageController.h"

#import "SMHospitalHomepageFirstCell.h"
#import "SMHospitalHomepageSecondCell.h"
#import "SMHospitalHomepageThirdCell.h"
#import "SMHospitalHomepageFifthCell.h"
#import "SMHomeFifthCell.h"
#import "SMDoctorTeamController.h"
#import "SMUserEvaluationController.h"
#import "SMSupportProjectController.h"
#import "SMUserDiaryController.h"

@interface SMHospitalHomepageController ()

@end

@implementation SMHospitalHomepageController

static NSString * const firstCellId = @"firstCellId";
static NSString * const secondCellId = @"secondCellId";
static NSString * const thirdCellId = @"thirdCellId";
static NSString * const fourthCellId = @"fourthCellId";
static NSString * const fifthCellId = @"fifthCellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"医院主页";
    [self.view addSubview:self.contentTabGrouped];
    self.contentTabGrouped.backgroundColor = ViewBackgroundColor;
    
    [self.contentTabGrouped registerNib:[UINib nibWithNibName:NSStringFromClass([SMHospitalHomepageFirstCell class]) bundle:nil] forCellReuseIdentifier:firstCellId];
    [self.contentTabGrouped registerNib:[UINib nibWithNibName:NSStringFromClass([SMHospitalHomepageSecondCell class]) bundle:nil] forCellReuseIdentifier:secondCellId];
    [self.contentTabGrouped registerNib:[UINib nibWithNibName:NSStringFromClass([SMHospitalHomepageThirdCell class]) bundle:nil] forCellReuseIdentifier:thirdCellId];
    [self.contentTabGrouped registerNib:[UINib nibWithNibName:NSStringFromClass([SMHomeFifthCell class]) bundle:nil] forCellReuseIdentifier:fourthCellId];
    [self.contentTabGrouped registerNib:[UINib nibWithNibName:NSStringFromClass([SMHospitalHomepageFifthCell class]) bundle:nil] forCellReuseIdentifier:fifthCellId];
    
    [self setBottomButton];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1 || section == 3) {
        return 2;
    }else if (section == 4){
        return 3;
    }else{
        
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 285;
    }else if (indexPath.section == 1){
        return 135;
    }else if (indexPath.section == 2){
        return 172;
    }else if (indexPath.section == 3){
        return (S_Width - 45) * 12 / 22 + 180;     
    }else{
        self.contentTabGrouped.rowHeight = UITableViewAutomaticDimension;
        self.contentTabGrouped.estimatedRowHeight = 195;
        return self.contentTabGrouped.rowHeight;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01;
    }else{
        return 60;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 4) {
        return 100;
    }else{
        
        return 47;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return nil;
    }else if (section == 1){
        return [self setHeaderViewWithText:@"医生团队"];
    }else if (section == 2){
        return [self setHeaderViewWithText:@"支持项目"];
    }else if (section == 3){
        return [self setHeaderViewWithText:@"用户日记"];
    }else{
        return [self setHeaderViewWithText:@"用户评价"];
    }
}

- (UIView *)setHeaderViewWithText:(NSString *)text{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UILabel *lab = [UILabel hyb_labelWithText:text font:17 superView:headerView constraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headerView.mas_centerX);
        make.centerY.mas_equalTo(headerView.mas_centerY).offset(10);
    }];
    lab.textColor = UIColor333;
//    lab.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:17];
    lab.font = [UIFont systemFontOfSize:18];
    
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return [self setFooterViewWithText:@"查看更多" section:section];
    }else if (section == 1){
        return [self setFooterViewWithText:@"查看全部医生" section:section];
    }else if (section == 2){
        return [self setFooterViewWithText:@"查看全部项目" section:section];
    }else if (section == 3){
        return [self setFooterViewWithText:@"查看全部日记" section:section];
    }else{
        return [self setFooterViewWithText:@"查看全部评价" section:section];
    }
}

- (UIView *)setFooterViewWithText:(NSString *)text section:(NSInteger)section{
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = ViewBackgroundColor;
    
    
    //  查看更多...
    UIView *view1 = [UIView hyb_viewWithSuperView:footerView constraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(footerView);
        make.height.mas_equalTo(37);
    }];
    view1.backgroundColor = [UIColor whiteColor];
    UIButton *textBtn = [UIButton hyb_buttonWithTitle:text superView:view1 constraints:^(MASConstraintMaker *make) {
        make.center.equalTo(view1);
    } touchUp:^(UIButton *sender) {
        if (section == 0) {
            SMLog(@"%@", text);
        }else if (section == 1){  // 医生团队
            SMLog(@"%@", text);
            SMDoctorTeamController *doctorTeamVc = [[SMDoctorTeamController alloc] init];
            [self.navigationController pushViewController:doctorTeamVc animated:YES];
        }else if (section == 2){  // 支持项目
            SMLog(@"%@", text);
            SMSupportProjectController *suprVc = [[SMSupportProjectController alloc] init];
            [self.navigationController pushViewController:suprVc animated:YES];
        }else if (section == 3){
            SMLog(@"%@", text);
            SMUserDiaryController *udVc = [[SMUserDiaryController alloc] init];
            [self.navigationController pushViewController:udVc animated:YES];
        }else{  // 用户评价
            SMUserEvaluationController *usevVc = [[SMUserEvaluationController alloc] init];
            [self.navigationController pushViewController:usevVc animated:YES];
            SMLog(@"%@", text);
        }
    }];
    [textBtn setTitleColor:UIColor666 forState:UIControlStateNormal];
    [textBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    
    UIView *view2 = [UIView hyb_viewWithSuperView:footerView constraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view1.mas_bottom);
        make.left.right.bottom.equalTo(footerView);
    }];
    view2.backgroundColor = ViewBackgroundColor;
    
    return footerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        SMHospitalHomepageFirstCell *firstCell = [tableView dequeueReusableCellWithIdentifier:firstCellId forIndexPath:indexPath];
        return firstCell;
    }else if (indexPath.section == 1){
        SMHospitalHomepageSecondCell *secondCell = [tableView dequeueReusableCellWithIdentifier:secondCellId forIndexPath:indexPath];
        if (indexPath.row == 1) {
            secondCell.lineView.hidden = YES;
        }else{
            secondCell.lineView.hidden = NO;
        }
        return secondCell;
    }else if (indexPath.section == 2){
        SMHospitalHomepageThirdCell *thirdCell = [tableView dequeueReusableCellWithIdentifier:thirdCellId forIndexPath:indexPath];
        return thirdCell;
    }else if (indexPath.section == 3){
        SMHomeFifthCell *fourthCell = [tableView dequeueReusableCellWithIdentifier:fourthCellId forIndexPath:indexPath];
        if (indexPath.row == 1) {
            fourthCell.lineView.hidden = YES;
        }else{
            fourthCell.lineView.hidden = NO;
        }
        return fourthCell;
    }else{
        SMHospitalHomepageFifthCell *fifthCell = [tableView dequeueReusableCellWithIdentifier:fifthCellId forIndexPath:indexPath];
        if (indexPath.row == 2) {
            fifthCell.lineView.hidden = YES;
        }else{
            fifthCell.lineView.hidden = NO;
        }

        return fifthCell;
    }
}

#pragma mark - 底部留言咨询按钮
- (void)setBottomButton{
    // 留言
    UIView *bottomView = [UIView hyb_viewWithSuperView:self.view constraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(44);
        make.left.bottom.right.equalTo(self.view);
    }];
    bottomView.backgroundColor = [UIColor whiteColor];
    
    UIButton *lmBtn = [UIButton hyb_buttonWithTitle:@"电话咨询" superView:bottomView constraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(bottomView);
        make.width.mas_equalTo(S_Width / 2);
    } touchUp:^(UIButton *sender) {
        SMLog(@"电话咨询");
    }];
    [self setButtonCategoryWithButton:lmBtn image:[UIImage imageNamed:@"home_tel"] backgroundColor:RGB(160, 160, 160)];
    
    // 咨询
    UIButton *csBtn = [UIButton hyb_buttonWithTitle:@"医院客服" superView:bottomView constraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lmBtn.mas_right);
        make.top.right.bottom.equalTo(bottomView);
    } touchUp:^(UIButton *sender) {
        SMLog(@"医院客服");
    }];
    [self setButtonCategoryWithButton:csBtn image:[UIImage imageNamed:@"home_kefu"] backgroundColor:UIColorRed];
    
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
