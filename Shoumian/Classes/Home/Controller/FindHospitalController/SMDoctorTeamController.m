//
//  SMDoctorTeamController.m
//  Shoumian
//
//  Created by 何志志 on 2017/2/17.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMDoctorTeamController.h"
#import "SMHospitalHomepageSecondCell.h"
#import "SMDoctorHomepageController.h"

@interface SMDoctorTeamController ()

@end

@implementation SMDoctorTeamController

static NSString * const cellId = @"cellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"医生团队";
    
    [self.view addSubview:self.contentTabGrouped];
    [self.contentTabGrouped registerNib:[UINib nibWithNibName:NSStringFromClass([SMHospitalHomepageSecondCell class]) bundle:nil] forCellReuseIdentifier:cellId];
    self.contentTabGrouped.rowHeight = 135;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;{
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SMHospitalHomepageSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.lineView.hidden = YES;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SMLog(@"点击cell");
    SMDoctorHomepageController *dohoVc = [[SMDoctorHomepageController alloc] init];
    [self.navigationController pushViewController:dohoVc animated:YES];
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
