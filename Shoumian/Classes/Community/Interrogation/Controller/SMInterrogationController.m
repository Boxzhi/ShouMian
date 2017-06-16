//
//  SMInterrogationController.m
//  Shoumian
//
//  Created by 何志志 on 2017/2/24.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMInterrogationController.h"
#import "SMInterrogationCell.h"


@interface SMInterrogationController ()

@end

@implementation SMInterrogationController

static NSString * const inCellId = @"inCellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"问答";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupHeadView];
    [self.view addSubview:self.contentTabGrouped];
    self.contentTabGrouped.frame = CGRectMake(0, 49, S_Width, S_Height - 64 -49);
    [self.contentTabGrouped registerNib:[UINib nibWithNibName:NSStringFromClass([SMInterrogationCell class]) bundle:nil] forCellReuseIdentifier:inCellId];
    self.contentTabGrouped.rowHeight = UITableViewAutomaticDimension;
    self.contentTabGrouped.estimatedRowHeight = 160;
}

- (void)setupHeadView{
    
    NSArray *titleArr = [NSArray arrayWithObjects:@"地区", @"项目", nil];
    
    HZZClassifyMenuView *menuView = [[HZZClassifyMenuView alloc] initWithRect:CGRectMake(0, 0, S_Width, 49) buttonTitles:titleArr titleColor:nil image:nil clickBlock:^(int index, HZZButton *btn) {
        
    }];
    [self.view addSubview:menuView];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 132;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = [UIColor whiteColor];
    
    UIButton *quizBtn = [UIButton hyb_buttonWithTitle:@"提问并邀请更多医生问答" superView:footerView constraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(46);
        make.centerX.equalTo(footerView.mas_centerX);
        make.height.mas_equalTo(22);
    } touchUp:^(UIButton *sender) {
        SMLog(@"进入提问邀请医生回答页面");
    }];
    // 下划线
    NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName : [NSNumber numberWithInteger:NSUnderlineStyleSingle], NSFontAttributeName : [UIFont systemFontOfSize:15], NSForegroundColorAttributeName : UIColor666};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:@"提问并邀请更多医生回答" attributes:attribtDic];
    [quizBtn setAttributedTitle:attribtStr forState:UIControlStateNormal];
    
    [quizBtn setImage:[UIImage imageNamed:@"community_wenda"] forState:UIControlStateNormal];
    [quizBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:8];
    
    return footerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SMInterrogationCell *inCell = [tableView dequeueReusableCellWithIdentifier:inCellId forIndexPath:indexPath];
    return inCell;
}



@end
