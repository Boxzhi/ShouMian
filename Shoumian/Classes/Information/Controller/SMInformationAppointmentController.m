//
//  SMInformationAppointmentController.m
//  Shoumian
//
//  Created by 何志志 on 2017/2/24.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMInformationAppointmentController.h"
#import "SMInformationOrderCell.h"
#import "SMReservationInformationController.h"

@interface SMInformationAppointmentController ()

@end

@implementation SMInformationAppointmentController

static NSString * const orderCellId = @"orderCellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"预约";
    
    [self.view addSubview:self.contentTabPlain];
    [self.contentTabPlain registerNib:[UINib nibWithNibName:NSStringFromClass([SMInformationOrderCell class]) bundle:nil] forCellReuseIdentifier:orderCellId];
    self.contentTabPlain.rowHeight = UITableViewAutomaticDimension;
    self.contentTabPlain.estimatedRowHeight = 95;
    
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SMInformationOrderCell *orderCell = [tableView dequeueReusableCellWithIdentifier:orderCellId forIndexPath:indexPath];
    return orderCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SMReservationInformationController *riVc = [[SMReservationInformationController alloc] init];
    [self.navigationController pushViewController:riVc animated:YES];
}

@end
