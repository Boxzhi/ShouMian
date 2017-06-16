//
//  SMChatConsultController.m
//  Shoumian
//
//  Created by 何志志 on 2017/2/24.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMChatConsultController.h"
#import "SMChatCell.h"

@interface SMChatConsultController ()

@end

@implementation SMChatConsultController

static NSString * const consultCellId = @"consultCellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.contentTabPlain];
    self.contentTabPlain.frame = CGRectMake(0, 0, S_Width, S_Height - 64 - 50);
    [self.contentTabPlain registerNib:[UINib nibWithNibName:NSStringFromClass([SMChatCell class]) bundle:nil] forCellReuseIdentifier:consultCellId];
    self.contentTabPlain.rowHeight = 88;
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
    SMChatCell *consultCell = [tableView dequeueReusableCellWithIdentifier:consultCellId forIndexPath:indexPath];
    return consultCell;
}

@end
