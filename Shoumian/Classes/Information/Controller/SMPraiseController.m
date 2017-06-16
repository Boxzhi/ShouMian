//
//  SMPraiseController.m
//  Shoumian
//
//  Created by 何志志 on 2017/2/24.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMPraiseController.h"
#import "SMInformationPraiseCell.h"

@interface SMPraiseController ()

@end

@implementation SMPraiseController

static NSString * const praiseCellId = @"praiseCellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.contentTabPlain];
    self.contentTabPlain.frame = CGRectMake(0, 0, S_Width, S_Height - 64 - 50);
    [self.contentTabPlain registerNib:[UINib nibWithNibName:NSStringFromClass([SMInformationPraiseCell class]) bundle:nil] forCellReuseIdentifier:praiseCellId];
    self.contentTabPlain.rowHeight = 176;
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = LineViewBackgroundColor;
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SMInformationPraiseCell *praiseCell = [tableView dequeueReusableCellWithIdentifier:praiseCellId forIndexPath:indexPath];
    return praiseCell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
