//
//  SMMyFansController.m
//  Shoumian
//
//  Created by 何志志 on 2017/3/16.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMMyFansController.h"
#import "SMMyFansCell.h"

@interface SMMyFansController ()

@end

@implementation SMMyFansController

static NSString * const cellId = @"cellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的粉丝";
    [self.view addSubview:self.contentTabGrouped];
    [self.contentTabGrouped registerNib:[UINib nibWithNibName:NSStringFromClass([SMMyFansCell class]) bundle:nil] forCellReuseIdentifier:cellId];
    self.contentTabGrouped.rowHeight = 157;
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SMMyFansCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    return cell;
};

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
