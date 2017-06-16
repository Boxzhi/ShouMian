//
//  SMMyProjectController.m
//  Shoumian
//
//  Created by 何志志 on 2017/2/13.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMMyProjectController.h"
#import "SMMyProjectCell.h"
#import "SMNOMyProjectFirstCell.h"
#import "SMNOMyProjectSecondCell.h"
#import "SMNOMyProjectThirdCell.h"

@interface SMMyProjectController ()

@property (nonatomic, assign, getter=isBuy) BOOL buy;

@end

@implementation SMMyProjectController

static NSString * const myProjectCellId = @"myProjectCellId";
static NSString * const noFirstCellId = @"noFirstCellId";
static NSString * const noSecondCellId = @"noSecondCellId";
static NSString * const noThirdCellId = @"noThirdCellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"精品项目";
    
    [self.view addSubview:self.contentTabGrouped];
    self.contentTabGrouped.backgroundColor = UIColorFromRGB(0xf8f8f8);
    [self.contentTabGrouped registerNib:[UINib nibWithNibName:NSStringFromClass([SMMyProjectCell class]) bundle:nil] forCellReuseIdentifier:myProjectCellId];
    [self.contentTabGrouped registerNib:[UINib nibWithNibName:NSStringFromClass([SMNOMyProjectFirstCell class]) bundle:nil] forCellReuseIdentifier:noFirstCellId];
    [self.contentTabGrouped registerNib:[UINib nibWithNibName:NSStringFromClass([SMNOMyProjectSecondCell class]) bundle:nil] forCellReuseIdentifier:noSecondCellId];
    [self.contentTabGrouped registerNib:[UINib nibWithNibName:NSStringFromClass([SMNOMyProjectThirdCell class]) bundle:nil] forCellReuseIdentifier:noThirdCellId];
    
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
        
        if (section == 0) {
            return 2;
        }else{
            return 2;
        }
    }else{
        
        return 1;
    }
}

// cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_buy) {
        
        if (indexPath.section == 0) {  // 进行中Cell高度
            
            return 175;
        }else{   // 已结束Cell高度
            
            return 150;
        }
    }else{
        
        if (indexPath.section == 0) {
            
            return 165;
        }else if (indexPath.section == 1){
            
            return 163;
        }else{
            
            return 215;
        }
    }
}

/**
 *  headerView高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (_buy) {
        
        return 47;
    }else{
        return 0.01;
    }
}

/**
 *  footerView高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (_buy) {
        
        if (section == 0) {
            
            return 10;
        }else{
            return 0.01;
        }
    }else{
        
        if (section == 2) {
            
            return 54;
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
            lab1.textColor = [UIColor blackColor];
        }else{
            
            UILabel *lab2 = [UILabel hyb_labelWithText:@"已结束" font:17 superView:headerView constraints:^(MASConstraintMaker *make) {
                make.left.mas_offset(12.5);
                make.top.mas_offset(20);
            }];
            lab2.textColor = [UIColor blackColor];
        }
        
        return headerView;
    }else{
        
        return nil;
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
    
    if (_buy) {  // 已购买过项目
        
        SMMyProjectCell *myProjectCell = [tableView dequeueReusableCellWithIdentifier:myProjectCellId forIndexPath:indexPath];
        myProjectCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        myProjectCell.appBtnBlock = ^{
            SMLog(@"点击");
            self.buy = NO;
            [self.contentTabGrouped reloadData];
            [self setBottomButton];
        };
        
        if (indexPath.section == 0) {
            myProjectCell.appointmentBtn.hidden = NO;
            myProjectCell.surplusNumberLab.textColor = UIColorRed;
            if (indexPath.row == 0) {
                myProjectCell.shiyongLab.text = @"使用中";
                myProjectCell.timeLab.hidden = NO;
                myProjectCell.surplusNumberLab.text = @"剩余2次";
                [myProjectCell.appointmentBtn setTitle:@"再次预约" forState:UIControlStateNormal];
            }else{
                myProjectCell.shiyongLab.text = @"未使用";
                myProjectCell.timeLab.hidden = YES;
                myProjectCell.treatmentNumberLab.text = @"治疗次数：0 次";
            }
            
        }else{
            myProjectCell.shiyongLab.hidden = YES;
            myProjectCell.timeLab.hidden = YES;
            myProjectCell.surplusNumberLab.textColor = UIColor999;
            myProjectCell.treatmentNumberLab.text = @"治疗次数： 3/3 次";
            myProjectCell.surplusNumberLab.textColor = UIColor999;
            myProjectCell.surplusNumberLab.text = @"所有服务已使用";
            myProjectCell.appointmentBtn.hidden = YES;
        }
        return myProjectCell;
        
    }else{   // 未购买过项目
        
        if (indexPath.section == 0) {
            
            SMNOMyProjectFirstCell *firstCell = [tableView dequeueReusableCellWithIdentifier:noFirstCellId];
            return firstCell;
        }else if (indexPath.section == 1){
            
            SMNOMyProjectSecondCell *secondCell = [tableView dequeueReusableCellWithIdentifier:noSecondCellId];
            return secondCell;
        }else{
            
            SMNOMyProjectThirdCell *thirdCell = [tableView dequeueReusableCellWithIdentifier:noThirdCellId];
            return thirdCell;
        }
    }
    
}

#pragma mark - 未购买时底部“去逛逛”的按钮
- (void)setBottomButton{
    if (!_buy) {
        
        UIButton *bottomBtn = [UIButton hyb_buttonWithTitle:@"去逛逛" superView:self.view constraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.height.mas_equalTo(44);
        } touchUp:^(UIButton *sender) {
            SMLog(@"点击去逛逛按钮");
        }];
        [bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [bottomBtn setBackgroundColor:UIColorFromRGB(0xff5050)];
        [bottomBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    }
}

//去掉UItableview headerview黏性  ，table滑动到最上端时，header view消失掉。
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if (scrollView == self.contentTabPlain)
//    {
//        CGFloat sectionHeaderHeight = 40;
//        if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0) {
//            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//        } else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
//            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//        }
//    }
//}

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
