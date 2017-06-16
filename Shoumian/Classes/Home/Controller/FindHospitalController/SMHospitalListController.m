//
//  SMHospitalListController.m
//  Shoumian
//
//  Created by 何志志 on 2017/2/16.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMHospitalListController.h"
#import "SMHospitalListCell.h"
#import "SMHospitalHomepageController.h"

@interface SMHospitalListController ()

@end

@implementation SMHospitalListController

static NSString * const listCellId = @"listCellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"医院列表";
    [self setHeadView];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem createItemWithImage:[UIImage imageNamed:@"home_search_23"] highImage:nil target:self action:@selector(navRightClick) title:nil];
    
    [self.view addSubview:self.contentTabPlain];
    self.contentTabPlain.frame = CGRectMake(0, SMMenuHeight, S_Width, S_Height - SMMenuHeight - SMNavHeight);
    self.contentTabPlain.backgroundColor = ViewBackgroundColor;
    [self.contentTabPlain registerNib:[UINib nibWithNibName:NSStringFromClass([SMHospitalListCell class]) bundle:nil] forCellReuseIdentifier:listCellId];
    self.contentTabPlain.rowHeight = 168;
}

#pragma mark - 下拉菜单
- (void)setHeadView{
    NSArray *titleArr = [NSArray arrayWithObjects:@"全国", @"全部项目", @"智能排序", nil];
    HZZClassifyMenuView *menu = [[HZZClassifyMenuView alloc] initWithRect:CGRectMake(0, 0, S_Width, SMMenuHeight) buttonTitles:titleArr titleColor:nil image:nil clickBlock:^(int index, HZZButton *btn) {
        
    }];
    [self.view addSubview:menu];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

#pragma mark - Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SMHospitalListCell *hlCell = [tableView dequeueReusableCellWithIdentifier:listCellId forIndexPath:indexPath];
    return hlCell;
};

#pragma mark - cell的点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SMLog(@"点击cell");
    SMHospitalHomepageController *hohoVc = [[SMHospitalHomepageController alloc] init];
    [self.navigationController pushViewController:hohoVc animated:YES];
}

/**
 *  右上角搜索
 */
- (void)navRightClick{
    SMLog(@"点击搜索");
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
