//
//  SMPrivateCustomController.m
//  Shoumian
//
//  Created by 何志志 on 2017/2/13.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMPrivateCustomController.h"
#import "SMPriCusCell.h"

@interface SMPrivateCustomController ()

@property (nonatomic, assign, getter=isBuy) BOOL buy;

@end

@implementation SMPrivateCustomController

static NSString * const priCusCellId = @"priCusCellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"私人定制";
    
    [self.view addSubview:self.contentTabGrouped];
    self.contentTabGrouped.backgroundColor = UIColorFromRGB(0xf8f8f8);
    [self.contentTabGrouped registerNib:[UINib nibWithNibName:NSStringFromClass([SMPriCusCell class]) bundle:nil] forCellReuseIdentifier:priCusCellId];
    
    self.buy = YES;
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_buy) {
        return 2;
    }else{
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

// 高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_buy) {
        
        if (indexPath.section == 0) {  // 进行中
            
            return 145;
        }else{   // 已结束
            
            return 125;
        }
    }else{
        
        return 262;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (_buy) {
        
        return 47;
    }else{
        
        return 55;
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
        
        return 50;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor whiteColor];
    
    if (_buy) {
        
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
            lab2.textColor = UIColor333;
        }
        
        return headerView;
    }else{
        UILabel *srdzsmLab = [UILabel hyb_labelWithText:@"私人订制说明" font:17 superView:headerView constraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(25);
            make.centerX.equalTo(headerView.mas_centerX);
        }];
        srdzsmLab.textColor = UIColor333;
        
        return headerView;
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
        
        SMPriCusCell *priCusCell = [tableView dequeueReusableCellWithIdentifier:priCusCellId];
        
        if (indexPath.section == 0) {
            
            priCusCell.pricusAppBtnBlock = ^{
                SMLog(@"点击立即预约按钮");
                self.buy = NO;
                [self.contentTabGrouped reloadData];
                [self setBottomButton];
            };
            
        }else{
            priCusCell.remainingNumberLab.hidden = YES;
            priCusCell.appointmentsBtn.hidden = YES;
        }
        
        return priCusCell;
    }else{
        
        UITableViewCell *firstCell = [[UITableViewCell alloc] init];
        
        UIImageView *firstImage = [UIImageView hyb_imageViewWithSuperView:firstCell constraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(firstCell);
        }];
        firstImage.image = [UIImage imageNamed:@"home_shuoming"];
        
        return firstCell;

    }

}

#pragma mark - 未购买时底部“去逛逛”的按钮
- (void)setBottomButton{
    if (!_buy) {
        
        UIButton *bottomBtn = [UIButton hyb_buttonWithTitle:@"查看我的定制" superView:self.view constraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.height.mas_equalTo(44);
        } touchUp:^(UIButton *sender) {
            SMLog(@"点击去看看按钮");
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
