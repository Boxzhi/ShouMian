//
//  SMRecommendFriendsController.m
//  Shoumian
//
//  Created by 何志志 on 2017/2/22.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMRecommendFriendsController.h"
#import "SMRFCell.h"

@interface SMRecommendFriendsController ()

@property (nonatomic, weak) UIButton *activeBtn;  // 活跃用户
@property (nonatomic, weak) UIButton *interestBtn;  //兴趣相似
@property (nonatomic, weak) UIButton *nearbyBtn;  //附近的人
@property (nonatomic, weak) UISwitch *switchView;  //附近的人开关
@property (nonatomic, assign) BOOL isOn; //附近的人开关状态

@end

@implementation SMRecommendFriendsController

static NSString * const rfCellId = @"rfCellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.contentTabGrouped];
    self.contentTabGrouped.frame = CGRectMake(0, 41, S_Width, S_Height - 110);
    self.contentTabGrouped.backgroundColor = [UIColor whiteColor];
    [self.contentTabGrouped registerNib:[UINib nibWithNibName:NSStringFromClass([SMRFCell class]) bundle:nil] forCellReuseIdentifier:rfCellId];
    
    [self setupHeadView];
}

- (void)setupHeadView{
    
    UIView *headView = [UIView hyb_viewWithSuperView:self.view constraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(41);
    }];
    headView.backgroundColor = RGB(248, 248, 248);
    
    [headView addSubview:[self setupSupView:headView title:@"活跃用户" num:0]];
    [headView addSubview:[self setupSupView:headView title:@"兴趣相似" num:1]];
    [headView addSubview:[self setupSupView:headView title:@"附近的人" num:2]];
}

- (UIButton *)setupSupView:(UIView *)supView title:(NSString *)title num:(NSInteger)num{
    SMWeakSelf;
    UIButton *btn = [UIButton hyb_buttonWithTitle:title superView:supView constraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(supView.mas_centerY);
        make.left.mas_offset(S_Width / 3 * num);
        make.width.mas_equalTo(S_Width / 3);
    } touchUp:^(UIButton *sender) {
        
        if (num == 0) {
            sender.selected = YES;
            self.interestBtn.selected = self.nearbyBtn.selected = NO;
        }else if (num == 1){
            sender.selected = YES;
            self.activeBtn.selected = self.nearbyBtn.selected = NO;
        }else if (num == 2){
            sender.selected = YES;
            self.activeBtn.selected = self.interestBtn.selected = NO;
        }
        [weakSelf.contentTabGrouped reloadData];
    }];
    [btn setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
    [btn setTitleColor:UIColorFromRGB(0xff5050) forState:UIControlStateSelected];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    if (num == 0) {
        btn.selected = YES;
        self.activeBtn = btn;
    }else if (num == 1){
        self.interestBtn = btn;
    }else if (num == 2){
        self.nearbyBtn = btn;
    }
    return btn;
}

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.nearbyBtn.selected) {
        if (self.switchView.on) {
            return 0;
        }else{
            return 3;
        }
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.nearbyBtn.selected) {
        return 70;
    }else{
        return 0.01;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    self.contentTabGrouped.rowHeight = UITableViewAutomaticDimension;
    self.contentTabGrouped.estimatedRowHeight = 144;
    return self.contentTabGrouped.rowHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (self.nearbyBtn.selected) {

        UIView *headView = [[UIView alloc] init];
        headView.backgroundColor = [UIColor whiteColor];
        
        UILabel *switchLab = [UILabel hyb_labelWithFont:15 superView:headView constraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(headView.mas_centerY);
            make.centerX.equalTo(headView.mas_centerX).offset(-20);
        }];
        switchLab.text = @"关闭附近的人";
        
        UISwitch *switchView = [UISwitch hyb_viewWithSuperView:headView constraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(52);
            make.height.mas_equalTo(32);
            make.left.equalTo(switchLab.mas_right).offset(15);
            make.centerY.equalTo(switchLab.mas_centerY);
        }];
        switchView.on = self.isOn;
        self.switchView = switchView;
        [switchView addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        
        UIView *lineView = [UIView hyb_viewWithSuperView:headView constraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(18);
            make.right.mas_offset(-18);
            make.bottom.equalTo(headView.mas_bottom);
            make.height.mas_equalTo(0.5);
        }];
        lineView.backgroundColor = LineViewBackgroundColor;
        
        return headView;
    }else{
        
        return nil;
    }
}

- (void)switchAction:(id)sender{
    
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        SMLog(@"开启");
        self.isOn = YES;
    }else {
        self.isOn = NO;
        SMLog(@"关闭");
    }
    [self.contentTabGrouped reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SMRFCell *cell = [tableView dequeueReusableCellWithIdentifier:rfCellId forIndexPath:indexPath];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
