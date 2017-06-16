//
//  SMUseCouponController.m
//  Shoumian
//
//  Created by 何志志 on 2017/3/10.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMUseCouponController.h"
#import "SMCouponCell.h"

@interface SMUseCouponController ()

@end

@implementation SMUseCouponController

static NSString * const cellId1 = @"cellId1";
static NSString * const cellId2 = @"cellId2";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"使用优惠券";
    
    [self.view addSubview:self.contentTabGrouped];
    [self.contentTabGrouped registerNib:[UINib nibWithNibName:NSStringFromClass([SMCouponCell class]) bundle:nil] forCellReuseIdentifier:cellId1];
    [self.contentTabGrouped registerNib:[UINib nibWithNibName:NSStringFromClass([SMCouponCell class]) bundle:nil] forCellReuseIdentifier:cellId2];
    self.contentTabGrouped.rowHeight = 110;
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01;
    }else{
        return 40;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        
        UIView *headView = [[UIView alloc] init];
        headView.backgroundColor = [UIColor whiteColor];
        
        UILabel *lab = [UILabel hyb_labelWithText:@"不可用优惠券" font:15 superView:headView constraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(25);
            make.centerY.equalTo(headView.mas_centerY).offset(10);
        }];
        lab.textColor = UIColor666;
        
        return headView;
    }else{
        return nil;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        SMCouponCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId1 forIndexPath:indexPath];
        return cell;
    }else{
        SMCouponCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId2 forIndexPath:indexPath];
        cell.priceLab.textColor = UIColor333;
        cell.useBtn.hidden = YES;
        return cell;
    }
};

@end
