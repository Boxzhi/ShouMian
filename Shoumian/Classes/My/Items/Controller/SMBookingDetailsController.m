//
//  SMBookingDetailsController.m
//  Shoumian
//
//  Created by 何志志 on 2017/3/17.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMBookingDetailsController.h"
#import "SMBookingDetailsCell.h"
#import "SMBookingDetailsIsExistCell.h"

@interface SMBookingDetailsController ()

@property (nonatomic, assign) BOOL isExist;

@end

@implementation SMBookingDetailsController

static NSString * const ieCellId = @"ieCellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"预约详情";
    self.isExist = YES;
    
    [self.view addSubview:self.contentTabGrouped];
    self.contentTabGrouped.backgroundColor = [UIColor whiteColor];
    [self setHeaderFooterView];
}

- (void)setHeaderFooterView{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, S_Width, 60)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UILabel *orderNumLab = [UILabel hyb_labelWithText:@"订单号：120202017031738" font:15 superView:headerView constraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(SMMargin);
        make.centerY.equalTo(headerView.mas_centerY);
    }];
    orderNumLab.textColor = UIColor333;
    UILabel *stateLab = [UILabel hyb_labelWithText:@"已确认" font:14 superView:headerView constraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-SMMargin);
        make.centerY.equalTo(headerView.mas_centerY);
    }];
    stateLab.textColor = UIColorRed;
    
    self.contentTabGrouped.tableHeaderView = headerView;
    
    
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, S_Width, 200)];
    footerView.backgroundColor = [UIColor whiteColor];
    
    UILabel *nameLab = [UILabel hyb_labelWithText:@"用户名称：一只黛二" font:15 superView:footerView constraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(SMMargin);
        make.top.mas_offset(18);
        make.right.mas_offset(-SMMargin);
    }];
    UILabel *idLab = [UILabel hyb_labelWithText:@"362818199412032738" font:15 superView:footerView constraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(SMMargin);
        make.right.mas_offset(-SMMargin);
        make.top.equalTo(nameLab.mas_bottom).offset(12);
    }];
    UILabel *phoneNumLab = [UILabel hyb_labelWithText:@"15270905023" font:15 superView:footerView constraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(SMMargin);
        make.right.mas_offset(-SMMargin);
        make.top.equalTo(idLab.mas_bottom).offset(12);
    }];
    nameLab.textColor = idLab.textColor = phoneNumLab.textColor = UIColor666;
    
    UILabel *submitLab = [UILabel hyb_labelWithText:@"提交时间" font:13 superView:footerView constraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneNumLab.mas_bottom).offset(25);
        make.right.mas_offset(-SMMargin);
    }];
    UILabel *timeLab = [UILabel hyb_labelWithText:@"2017/03/17" font:13 superView:footerView constraints:^(MASConstraintMaker *make) {
        make.top.equalTo(submitLab.mas_bottom).offset(3);
        make.right.mas_offset(-SMMargin);
    }];
    submitLab.textColor = timeLab.textColor = UIColor999;
    
    self.contentTabGrouped.tableFooterView = footerView;
}


#pragma mark -- UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_isExist) {
        
        return 2;
    }else{
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (_isExist) {
        if (section == 0) {
            return 10;
        }else{
            return 0.01;
        }
    }else{
        
        return 10;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isExist) {
        if (indexPath.section == 0) {
            self.contentTabGrouped.rowHeight = UITableViewAutomaticDimension;
            self.contentTabGrouped.estimatedRowHeight = 80;
            return self.contentTabGrouped.rowHeight;
        }else{
            return 253;
        }
    }else{
        return 253;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc] init];
    headView.backgroundColor = ViewBackgroundColor;
    return headView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = ViewBackgroundColor;
    return footerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_isExist) {
        if (indexPath.section == 0) {
            SMBookingDetailsIsExistCell *ieCell = [[SMBookingDetailsIsExistCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ieCellId];
            return ieCell;
        }else{
            SMBookingDetailsCell *bdCell = [SMBookingDetailsCell viewFromXib];
            bdCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return bdCell;
        }
    }else{
        
        SMBookingDetailsCell *bdCell = [SMBookingDetailsCell viewFromXib];
        bdCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return bdCell;
    }
};



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
