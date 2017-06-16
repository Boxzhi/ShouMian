//
//  SMInformationOrderController.m
//  Shoumian
//
//  Created by 何志志 on 2017/2/24.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMInformationOrderController.h"
#import "SMInformationNoticeCell.h"

@interface SMInformationOrderController ()

@end

@implementation SMInformationOrderController

static NSString * const orderCellId = @"orderCellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 消息模块的订单界面
    self.title = @"订单";
    [self.view addSubview:self.contentTabPlain];
    [self.contentTabPlain registerNib:[UINib nibWithNibName:NSStringFromClass([SMInformationNoticeCell class]) bundle:nil] forCellReuseIdentifier:orderCellId];
    self.contentTabPlain.rowHeight = 60;
    
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SMInformationNoticeCell *orderCell = [tableView dequeueReusableCellWithIdentifier:orderCellId forIndexPath:indexPath];
    return orderCell;
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
