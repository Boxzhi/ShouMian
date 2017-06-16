//
//  SMDoctorsAppointmentsController.m
//  Shoumian
//
//  Created by 何志志 on 2017/2/13.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMDoctorsAppointmentsController.h"
#import "SMDoctorsAppCell.h"
#import "SMNODoctorsAppFirstCell.h"
#import "SMNODoctorsAppSecondCell.h"
#import "SMNODoctorsAppThirdCell.h"
#import "SMThirdDoctorCell.h"

@interface SMDoctorsAppointmentsController ()

@property (nonatomic, assign, getter=isBuy) BOOL buy;

@end

@implementation SMDoctorsAppointmentsController

static NSString * const doctorsAppCellId = @"doctorsAppCellId";
static NSString * const doctorsAppFirstCellId = @"doctorsAppFirstCellId";
static NSString * const doctorsAppSecondCellId = @"doctorsAppSecondCellId";
static NSString * const doctorsAppThirdCellId = @"doctorsAppThirdCellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"大牌名医";
    
    [self.view addSubview:self.contentTabGrouped];
    self.contentTabGrouped.backgroundColor = UIColorFromRGB(0xf8f8f8);
    [self.contentTabGrouped registerNib:[UINib nibWithNibName:NSStringFromClass([SMDoctorsAppCell class]) bundle:nil] forCellReuseIdentifier:doctorsAppCellId];
    [self.contentTabGrouped registerNib:[UINib nibWithNibName:NSStringFromClass([SMNODoctorsAppFirstCell class]) bundle:nil] forCellReuseIdentifier:doctorsAppFirstCellId];
    [self.contentTabGrouped registerNib:[UINib nibWithNibName:NSStringFromClass([SMNODoctorsAppSecondCell class]) bundle:nil] forCellReuseIdentifier:doctorsAppSecondCellId];
    [self.contentTabGrouped registerNib:[UINib nibWithNibName:NSStringFromClass([SMThirdDoctorCell class]) bundle:nil] forCellReuseIdentifier:doctorsAppThirdCellId];
    
    self.buy = YES;
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_buy) {
        
        return 2;
    }else{
        
        return 3;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (_buy) {
        
        return 3;
    }else{
        
        if (section == 2) {
            return 3;
        }else{
            
            return 1;
        }
    }
}

// 高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_buy) {
        
        return 141;
    }else{
        
        if (indexPath.section == 0) {
            return 188;
        }else if (indexPath.section == 1){
            return 148;
        }else{
            return 122;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (_buy) {
        
        return 47;
    }else{
        
        if (section == 2) {
            
            return 37;
        }else{
            
            return 0.01;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (_buy) {
        
        if (section == 0) {
            return 10;
        }else{
            return 0.01;
        }
    }else{
        
        if (section == 2) {
            return 74;
        }else{
            return 10;
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (_buy) {
        
        UIView *headerView = [[UIView alloc] init];
        headerView.backgroundColor = [UIColor whiteColor];
        
        if (section == 0) {
            
            UILabel *lab1 = [UILabel hyb_labelWithText:@"进行中" font:17 superView:headerView constraints:^(MASConstraintMaker *make) {
                make.left.mas_offset(12.5);
                make.top.mas_offset(20);
            }];
            lab1.textColor = UIColorFromRGB(0xff5050);
        }else{
            
            UILabel *lab2 = [UILabel hyb_labelWithText:@"已结束" font:17 superView:headerView constraints:^(MASConstraintMaker *make) {
                make.left.mas_offset(12.5);
                make.top.mas_offset(20);
            }];
            lab2.textColor = UIColorFromRGB(0x333333);
        }
        
        return headerView;
    }else{
        
        if (section == 2) {  // 人气名医
            
            UIView *headerView = [[UIView alloc] init];
            headerView.backgroundColor = [UIColor whiteColor];
            
            UILabel *lab = [UILabel hyb_labelWithText:@"人气名医" font:17 superView:headerView constraints:^(MASConstraintMaker *make) {
                make.center.equalTo(headerView);
            }];
            lab.textColor = UIColor333;
            
            return headerView;
        }else{
            return nil;
        }
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = UIColorFromRGB(0xf8f8f8);
    return footerView;
}


/**
 *  cell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_buy) {
        
        SMDoctorsAppCell *doctorCell = [tableView dequeueReusableCellWithIdentifier:doctorsAppCellId];
        doctorCell.selectionStyle = UITableViewCellSelectionStyleNone;
        doctorCell.docAppBtnBlock = ^{
            SMLog(@"再次预约");
            self.buy = NO;
            [self.contentTabGrouped reloadData];
            [self setBottomButton];
        };
        return doctorCell;
    }else{    //  未购买时显示的Cell
        
        if (indexPath.section == 0) {
            SMNODoctorsAppFirstCell *firstCell = [tableView dequeueReusableCellWithIdentifier:doctorsAppFirstCellId];
            return firstCell;
        }else if (indexPath.section == 1) {
            SMNODoctorsAppSecondCell *secondCell = [tableView dequeueReusableCellWithIdentifier:doctorsAppSecondCellId];
            return secondCell;
        }else{
            SMThirdDoctorCell *thirdCell = [tableView dequeueReusableCellWithIdentifier:doctorsAppThirdCellId];
            return thirdCell;
        }
    }
}

#pragma mark - 未购买时底部“去逛逛”的按钮
- (void)setBottomButton{
    if (!_buy) {
        
        UIButton *bottomBtn = [UIButton hyb_buttonWithTitle:@"去预约" superView:self.view constraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.height.mas_equalTo(44);
        } touchUp:^(UIButton *sender) {
            SMLog(@"点击去预约按钮");
        }];
        [bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [bottomBtn setBackgroundColor:UIColorFromRGB(0xff5050)];
        [bottomBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    }
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
