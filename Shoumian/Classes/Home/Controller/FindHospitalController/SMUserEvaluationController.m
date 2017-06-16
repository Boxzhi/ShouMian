//
//  SMUserEvaluationController.m
//  Shoumian
//
//  Created by 何志志 on 2017/2/17.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMUserEvaluationController.h"
#import "SMHospitalHomepageFifthCell.h"

@interface SMUserEvaluationController ()

@end

@implementation SMUserEvaluationController

static NSString *const usevCellId = @"usevCellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title = @"用户评价";
    [self.view addSubview:self.contentTabPlain];
    [self.contentTabPlain registerNib:[UINib nibWithNibName:NSStringFromClass([SMHospitalHomepageFifthCell class]) bundle:nil] forCellReuseIdentifier:usevCellId];
    self.contentTabPlain.rowHeight = UITableViewAutomaticDimension;
    self.contentTabPlain.estimatedRowHeight = 195;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor whiteColor];
    
    [headerView addSubview:[self setHeaderViewSubView:headerView number:0]];
    [headerView addSubview:[self setHeaderViewSubView:headerView number:1]];
    [headerView addSubview:[self setHeaderViewSubView:headerView number:2]];
    
    return headerView;
}

- (UIView *)setHeaderViewSubView:(UIView *)view number:(NSInteger)num{

    UIView *subView = [UIView hyb_viewWithSuperView:view constraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(S_Width / 3 * num);
        make.top.bottom.equalTo(view);
        make.width.mas_equalTo(S_Width / 3);
    }];
    subView.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton hyb_viewWithSuperView:subView constraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(subView.mas_centerX);
        make.height.mas_equalTo(30);
        make.bottom.equalTo(subView.mas_bottom);
    }];
    
    
    NSString *str;
    if (num == 0) {
        str = @"    全部 827    ";
    }else if (num == 1){
        str = @"    满意 606    ";
    }else if (num == 2){
        str = @"    一般 221    ";
    }
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, 6)];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(7, str.length - 7)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:UIColor666 range:NSMakeRange(0, str.length)];
    
    NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc] initWithString:str];
    [attributedString1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, 6)];
    [attributedString1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(7, str.length - 7)];
    [attributedString1 addAttribute:NSForegroundColorAttributeName value:UIColorRed range:NSMakeRange(0, str.length)];


    [btn setAttributedTitle:attributedString forState:UIControlStateNormal];
    [btn setAttributedTitle:attributedString1 forState:UIControlStateSelected];
    btn.tag = num + 100;
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 8;
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = UIColor666.CGColor;
    if (num == 0) {  // 一进入到当前页面，就把“全部”评价按钮设为选中状态
        btn.selected = YES;
        btn.layer.borderColor = UIColorRed.CGColor;
    }
    
    [btn hyb_addTapGestureWithCallback:^(UITapGestureRecognizer *sender) {
        UIButton *btn1 =  (UIButton *)[self.view viewWithTag:100];
        UIButton *btn2 =  (UIButton *)[self.view viewWithTag:101];
        UIButton *btn3 =  (UIButton *)[self.view viewWithTag:102];
        if (sender.view.tag == 100) {
            SMLog(@"第一个按钮");
            btn1.selected = YES;
            btn2.selected = btn3.selected = NO;
            btn1.layer.borderColor = UIColorRed.CGColor;
            btn2.layer.borderColor = btn3.layer.borderColor = UIColor666.CGColor;
        }else if (sender.view.tag == 101){
            SMLog(@"第二个按钮");
            btn2.selected = YES;
            btn1.selected = btn3.selected = NO;
            btn2.layer.borderColor = UIColorRed.CGColor;
            btn1.layer.borderColor = btn3.layer.borderColor = UIColor666.CGColor;
        }else if (sender.view.tag == 102){
            SMLog(@"第三个按钮");
            btn3.selected = YES;
            btn1.selected = btn2.selected = NO;
            btn3.layer.borderColor = UIColorRed.CGColor;
            btn1.layer.borderColor = btn2.layer.borderColor = UIColor666.CGColor;
        }
    }];
    
    return subView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SMHospitalHomepageFifthCell *usevCell = [tableView dequeueReusableCellWithIdentifier:usevCellId forIndexPath:indexPath];
    usevCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return usevCell;
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
