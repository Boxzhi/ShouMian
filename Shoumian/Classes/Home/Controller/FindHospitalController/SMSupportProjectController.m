//
//  SMSupportProjectController.m
//  Shoumian
//
//  Created by 何志志 on 2017/2/17.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMSupportProjectController.h"
#import "SMSupportProjectCell.h"
#import "SMProjectListCell.h"

@interface SMSupportProjectController ()

@end

@implementation SMSupportProjectController

static NSString * const spCellId = @"spCellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"支持项目";
    [self setHeaderView];
//    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.contentTabPlain];
    self.contentTabPlain.frame = CGRectMake(0, SMMenuHeight, S_Width, S_Height - SMMenuHeight - SMNavHeight);
    [self.contentTabPlain registerNib:[UINib nibWithNibName:NSStringFromClass([SMProjectListCell class]) bundle:nil] forCellReuseIdentifier:spCellId];
    self.contentTabPlain.rowHeight = 160;
}

- (void)setHeaderView{
    NSArray *arr = [NSArray arrayWithObjects:@"全部项目", @"智能排序", nil];
    HZZClassifyMenuView *menuView = [[HZZClassifyMenuView alloc] initWithRect:CGRectMake(0, 0, S_Width, SMMenuHeight)buttonTitles:arr titleColor:nil image:nil clickBlock:^(int index, HZZButton *btn) {
        
    }];
    [self.view addSubview:menuView];
}

#pragma mark -- UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footView = [[UIView alloc] init];
    footView.backgroundColor = ViewBackgroundColor;
    return footView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SMProjectListCell *spCell = [tableView dequeueReusableCellWithIdentifier:spCellId forIndexPath:indexPath];
    return spCell;
};

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
