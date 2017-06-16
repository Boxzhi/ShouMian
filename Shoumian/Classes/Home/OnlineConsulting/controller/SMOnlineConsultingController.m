//
//  SMOnlineConsultingController.m
//  Shoumian
//
//  Created by 何志志 on 2017/2/14.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMOnlineConsultingController.h"
#import "SMOnlineConsultingCell.h"
#import "SMDoctorHomepageController.h"

@interface SMOnlineConsultingController ()

@end

@implementation SMOnlineConsultingController

static NSString * const ocCellId = @"ocCellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"在线咨询";
    [self.view addSubview:self.contentTabPlain];
    self.contentTabPlain.backgroundColor = ViewBackgroundColor;
    [self.contentTabPlain registerNib:[UINib nibWithNibName:NSStringFromClass([SMOnlineConsultingCell class]) bundle:nil] forCellReuseIdentifier:ocCellId];
}


#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 55;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 141;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UIView *lineView = [UIView hyb_viewWithSuperView:headerView constraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(14);
        make.width.mas_equalTo(1);
        make.center.equalTo(headerView);
    }];
    lineView.backgroundColor = RGB(184, 184, 184);
    UIView *acrossLineView = [UIView hyb_addBottomLineToView:headerView height:1 color:ViewBackgroundColor];
    acrossLineView.backgroundColor = ViewBackgroundColor;
    
    UIButton *btn1 = [UIButton hyb_buttonWithTitle:@"擅长项目" superView:headerView constraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(headerView);
        make.right.equalTo(lineView.mas_left);
        make.bottom.equalTo(acrossLineView.mas_top);
    } touchUp:^(UIButton *sender) {
        SMLog(@"点击擅长项目");
    }];
    [btn1 setXialaMenuButton];
    
    UIButton *btn2 = [UIButton hyb_buttonWithTitle:@"排序" superView:headerView constraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineView.mas_right);
        make.top.right.equalTo(headerView);
        make.bottom.equalTo(acrossLineView.mas_top);
    } touchUp:^(UIButton *sender) {
        SMLog(@"点击排序");
    }];
    [btn2 setXialaMenuButton];
    
    return headerView;
}

/**
 *  cell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SMOnlineConsultingCell *oncoCell = [tableView dequeueReusableCellWithIdentifier:ocCellId forIndexPath:indexPath];
    return oncoCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SMLog(@"跳转到医生主页");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];// 取消选中
    SMDoctorHomepageController *dhpVc = [[SMDoctorHomepageController alloc] init];
    [self.navigationController pushViewController:dhpVc animated:YES];
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
