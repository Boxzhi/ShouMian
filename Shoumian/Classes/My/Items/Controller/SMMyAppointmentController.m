//
//  SMMyAppointmentController.m
//  Shoumian
//
//  Created by 何志志 on 2017/3/17.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMMyAppointmentController.h"
#import "SMMyAppointmentCell.h"
#import "SMBookingDetailsController.h"

@interface SMMyAppointmentController ()

@end

@implementation SMMyAppointmentController

static NSString * const maCellId = @"maCellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的预约";
    
    [self.view addSubview:self.contentTabGrouped];
    [self.contentTabGrouped registerNib:[UINib nibWithNibName:NSStringFromClass([SMMyAppointmentCell class]) bundle:nil] forCellReuseIdentifier:maCellId];
}

#pragma mark -- UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 125;
    }else{
        return 153;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc] init];
    headView.backgroundColor = [UIColor whiteColor];
    
    UILabel *orderNumberLab = [UILabel hyb_labelWithText:@"订单号：120201372767323" font:15 superView:headView constraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(SMMargin);
        make.centerY.equalTo(headView.mas_centerY);
    }];
    orderNumberLab.textColor = UIColor666;
    
    NSString *stateStr;
    if (section == 0) {
        stateStr = @"等待确认";
    }else if (section == 1){
        stateStr = @"已确认";
    }
    UILabel *stateLab = [UILabel hyb_labelWithText:stateStr font:14 superView:headView constraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-SMMargin);
        make.centerY.equalTo(headView.mas_centerY);
    }];
    stateLab.textColor = UIColorRed;
    
    return headView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SMMyAppointmentCell *maCell = [tableView dequeueReusableCellWithIdentifier:maCellId forIndexPath:indexPath];
    if (indexPath.section == 0) {
        maCell.confirmTimeLab.hidden = YES;
    }else{
        maCell.confirmTimeLab.hidden = NO;
    }
    return maCell;
};


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SMBookingDetailsController *bdVc = [[SMBookingDetailsController alloc] init];
    [self.navigationController pushViewController:bdVc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
