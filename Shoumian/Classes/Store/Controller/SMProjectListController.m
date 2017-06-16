//
//  SMProjectListController.m
//  Shoumian
//
//  Created by 何志志 on 2017/3/6.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMProjectListController.h"
#import "SMProjectListCell.h"
#import "SMConfirmOrderController.h"

@interface SMProjectListController ()

@end

@implementation SMProjectListController

static NSString * const plCellId = @"plCellId";
#define menuViewHeight 50

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"项目列表";
    UIBarButtonItem *rightF = [UIBarButtonItem createItemWithImage:[UIImage imageNamed:@"mall_gouwuche_23"] highImage:nil target:self action:@selector(clickShopBtn) title:@"  "];
    UIBarButtonItem *rightS = [UIBarButtonItem createItemWithImage:[UIImage imageNamed:@"mall_search"] highImage:nil target:self action:@selector(clickSearchBtn) title:nil];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:rightS, rightF, nil];
    
    [self setupMenuView];
    
    [self.view addSubview:self.contentTabGrouped];
    self.contentTabGrouped.frame = CGRectMake(0, menuViewHeight, S_Width, S_Height - SMNavHeight - menuViewHeight);
    [self.contentTabGrouped registerNib:[UINib nibWithNibName:NSStringFromClass([SMProjectListCell class]) bundle:nil] forCellReuseIdentifier:plCellId];
    self.contentTabGrouped.rowHeight = 160;
}

- (void)setupMenuView{
    NSArray *titleArr = [NSArray arrayWithObjects:@"全国", @"项目", @"排序",  nil];
    HZZClassifyMenuView *menuView = [[HZZClassifyMenuView alloc] initWithRect:CGRectMake(0, 0, S_Width, menuViewHeight) buttonTitles:titleArr titleColor:nil image:nil clickBlock:^(int index, HZZButton *btn) {
        
    }];
    [self.view addSubview:menuView];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
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
    SMProjectListCell *listCell = [tableView dequeueReusableCellWithIdentifier:plCellId forIndexPath:indexPath];
    return listCell;
}

#pragma mark - 购物车搜索点击方法
- (void)clickShopBtn{
    SMLog(@"点击购物车");
}

- (void)clickSearchBtn{
    SMLog(@"点击搜索");
    SMConfirmOrderController *coVc = [[SMConfirmOrderController alloc] init];
    [self.navigationController pushViewController:coVc animated:YES];
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
