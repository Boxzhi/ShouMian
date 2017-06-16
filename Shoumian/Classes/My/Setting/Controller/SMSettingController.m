//
//  SMSettingController.m
//  Shoumian
//
//  Created by 何志志 on 2017/3/11.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMSettingController.h"
#import "SMSettingCell.h"
#import "SMPersonalDataController.h"
#import "SMAccountSecurityController.h"
#import "SMFeedbackViewController.h"
#import "SMPrivacyViewController.h"
#import "SMAboutUsViewController.h"

@interface SMSettingController ()

@property (nonatomic, strong) NSArray *imageArr;
@property (nonatomic, strong) NSArray *titleArr;

@end

@implementation SMSettingController

static NSString * const settingCellId = @"settingCellId";

- (NSArray *)imageArr{
    if (!_imageArr) {
        _imageArr = [NSArray array];
    }
    return _imageArr;
}

- (NSArray *)titleArr{
    if (!_titleArr) {
        _titleArr = [NSArray array];
    }
    return _titleArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"设置";
    self.imageArr = @[@"my_set_ziliao", @"my_set_mima", @"my_set_huancun", @"my_set_yijianfankui", @"my_set_banben", @"my_set_yinsi", @"my_set_guanyuwom"];
    self.titleArr = @[@"个人资料", @"账号密码", @"清除缓存", @"意见反馈", @"版本更新", @"隐私设置", @"关于我们"];
    
    [self.view addSubview:self.contentTabGrouped];
    [self.contentTabGrouped registerNib:[UINib nibWithNibName:NSStringFromClass([SMSettingCell class]) bundle:nil] forCellReuseIdentifier:settingCellId];
    self.contentTabGrouped.rowHeight = 60;
    [self setFooterView];
}

- (void)setFooterView{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, S_Width, 100)];
    footerView.backgroundColor = ViewBackgroundColor;
    
    UIButton *outLoginBtn = [UIButton hyb_buttonWithTitle:@"退出登录" superView:footerView constraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(S_Width * 350 / 375);
        make.height.mas_equalTo(40);
        make.center.equalTo(footerView);
    } touchUp:^(UIButton *sender) {
        SMLog(@"退出登录");
    }];
    [outLoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [outLoginBtn setBackgroundColor:UIColorRed];
    [outLoginBtn.titleLabel setFont:[UIFont systemFontOfSize:17]];
    outLoginBtn.layer.masksToBounds = YES;
    outLoginBtn.layer.cornerRadius = 5;
    
    self.contentTabGrouped.tableFooterView = footerView;
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SMSettingCell *settingCell = [tableView dequeueReusableCellWithIdentifier:settingCellId forIndexPath:indexPath];
    settingCell.imageTitle = @[self.imageArr[indexPath.row], self.titleArr[indexPath.row]];
    if (indexPath.row == 2) {
        settingCell.auxiliaryLab.hidden = NO;
        settingCell.auxiliaryLab.text = @"28M";
    }else if (indexPath.row == 4){
        settingCell.auxiliaryLab.hidden = NO;
        settingCell.auxiliaryLab.attributedText = [NSString addNSUnderlineStyleAttributeName:@"当前版本v1.2"];
    }else{
        settingCell.auxiliaryLab.hidden = YES;
    }
    return settingCell;
};

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) { // 个人资料
        
        SMPersonalDataController *pdVc = [[SMPersonalDataController alloc] init];
        [self.navigationController pushViewController:pdVc animated:YES];
    }else if (indexPath.row == 1) {   //  账号密码
        SMAccountSecurityController *asVc = [[SMAccountSecurityController alloc] init];
        [self.navigationController pushViewController:asVc animated:YES];
    }else if (indexPath.row == 2){   //  清除缓存
        
    }else if (indexPath.row == 3){
        SMFeedbackViewController *fbVc = [[SMFeedbackViewController alloc] init];
        [self.navigationController pushViewController:fbVc animated:YES];
    }else if (indexPath.row == 4){
        
    }else if (indexPath.row == 5){  //  隐私设置
        SMPrivacyViewController *prVc = [[SMPrivacyViewController alloc] init];
        [self.navigationController pushViewController:prVc animated:YES];
    }else{   //  关于我们
        SMAboutUsViewController *auVc = [[SMAboutUsViewController alloc] init];
        [self.navigationController pushViewController:auVc animated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
