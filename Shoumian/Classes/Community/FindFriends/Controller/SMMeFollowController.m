//
//  SMMeFollowController.m
//  Shoumian
//
//  Created by 何志志 on 2017/2/22.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMMeFollowController.h"
#import "SMRFCell.h"

@interface SMMeFollowController ()

@end

@implementation SMMeFollowController

static NSString * const mfCellId = @"mfCellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.contentTabPlain];
    self.contentTabPlain.frame = CGRectMake(0, 0, S_Width, S_Height - 108);
    [self.contentTabPlain registerNib:[UINib nibWithNibName:NSStringFromClass([SMRFCell class]) bundle:nil] forCellReuseIdentifier:mfCellId];
}

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    self.contentTabPlain.rowHeight = UITableViewAutomaticDimension;
    self.contentTabPlain.estimatedRowHeight = 144;
    return self.contentTabPlain.rowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SMRFCell *cell = [tableView dequeueReusableCellWithIdentifier:mfCellId forIndexPath:indexPath];
    cell.followBtn.backgroundColor = RGB(204, 204, 204);
    [cell.followBtn setTitle:@"已关注" forState:UIControlStateNormal];
    return cell;
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
