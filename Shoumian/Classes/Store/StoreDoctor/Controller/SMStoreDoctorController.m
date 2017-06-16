//
//  SMStoreDoctorController.m
//  Shoumian
//
//  Created by 何志志 on 2017/3/3.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMStoreDoctorController.h"
#import "SMThirdDoctorCell.h"
#import "SMStoreDoctorHomepageController.h"

@interface SMStoreDoctorController ()

@property (nonatomic, strong) HZZClassifyMenuView *menuView;

@end

@implementation SMStoreDoctorController

static CGFloat const headViewHegiht = 50;
static NSString * const doctorCellId = @"doctorCellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"名医在线";
    
    [self setupHeadView];
    [self.view addSubview:self.contentTabGrouped];
    self.contentTabGrouped.frame = CGRectMake(0, headViewHegiht, S_Width, S_Height - SMNavHeight - headViewHegiht);
    [self.contentTabGrouped registerNib:[UINib nibWithNibName:NSStringFromClass([SMThirdDoctorCell class]) bundle:nil] forCellReuseIdentifier:doctorCellId];
    self.contentTabGrouped.rowHeight = 120;
}

- (void)setupHeadView{
    
    NSArray *titleArr = [NSArray arrayWithObjects:@"地区", @"项目", @"排序", nil];
    self.menuView = [[HZZClassifyMenuView alloc] initWithRect:CGRectMake(0, 0, S_Width, 50) buttonTitles:titleArr titleColor:nil image:nil clickBlock:^(int index, HZZButton *btn) {
        
    }];
    self.menuView.hzzButtonClickBlock = ^(int index, HZZButton *btn){
        NSLog(@"%d", index);
        btn.titleStr = @"点赞数最多";
    };
    [self.view addSubview:self.menuView];
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
    SMThirdDoctorCell *doctorCell = [tableView dequeueReusableCellWithIdentifier:doctorCellId forIndexPath:indexPath];
    return doctorCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SMLog(@"点击cell");
    SMStoreDoctorHomepageController *sdhpVc = [[SMStoreDoctorHomepageController alloc] init];
    [self.navigationController pushViewController:sdhpVc animated:YES];
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
