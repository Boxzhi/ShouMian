//
//  SMMyController.m
//  Shoumian
//
//  Created by 何志志 on 2017/1/19.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMMyController.h"
#import "SMMyHeaderCell.h"
#import "SMCategoryCell.h"
#import "SMMyLastCell.h"
#import "SMSettingController.h"
#import "SMPersonalHomepageController.h"
#import "SMRegisterViewController.h"
#import "SMNavigationController.h"
#import "SMMyAppointmentController.h"
#import "SMMyPrivateCustomController.h"
#import "SMMyOrderController.h"
#import "SMCollectionController.h"
#import "SMShoppingCartController.h"

#define cellW (S_Width / 3)

@interface SMMyController ()

@property(nonatomic, weak) UICollectionView *collectionView;

@end

@implementation SMMyController

static NSString * const headerCellId = @"headerCellId";
static NSString * const CategoryCellId = @"CategoryCellId";
static NSString * const lastCellId = @"lastCellId";

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"我的";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem createItemWithImage:[UIImage imageNamed:@"my_set"] highImage:nil target:self action:@selector(clickSetting) title:nil];

    [self setTableView];
}

- (void)setTableView{
    [self.view addSubview:self.contentTabPlain];
    self.contentTabPlain.backgroundColor = [UIColor whiteColor];
    self.contentTabPlain.frame = CGRectMake(0, 0, S_Width, S_Height - 49 - 64);
    [self.contentTabPlain registerNib:[UINib nibWithNibName:NSStringFromClass([SMMyHeaderCell class]) bundle:nil] forCellReuseIdentifier:headerCellId];
    [self.contentTabPlain registerNib:[UINib nibWithNibName:NSStringFromClass([SMCategoryCell class]) bundle:nil] forCellReuseIdentifier:CategoryCellId];
    [self.contentTabPlain registerNib:[UINib nibWithNibName:NSStringFromClass([SMMyLastCell class]) bundle:nil] forCellReuseIdentifier:lastCellId];
}

//- (void)viewWillLayoutSubviews
//{
//    [super viewWillLayoutSubviews];
//    self.contentTabPlain.contentInset = UIEdgeInsetsZero;
//    self.contentTabPlain.scrollIndicatorInsets = UIEdgeInsetsZero;
//}

- (void)clickSetting{
    SMLog(@"进入设置页面");
    SMSettingController *settingVc = [[SMSettingController alloc] init];
    [self.navigationController pushViewController:settingVc animated:YES];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 212;
    }else if (indexPath.row == 1){
        return 80;
    }
    return 245;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SMWeakSelf;
    if (indexPath.row == 0) {
        SMMyHeaderCell *headerCell = [tableView dequeueReusableCellWithIdentifier:headerCellId];
        headerCell.registerLoginBtnClick = ^{
            //  跳转到注册页面
            SMRegisterViewController *registerVc = [[SMRegisterViewController alloc] init];
            SMNavigationController *naVc = [[SMNavigationController alloc] initWithRootViewController:registerVc];
            [weakSelf presentViewController:naVc animated:YES completion:nil];
        };
        headerCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return headerCell;
    }else if (indexPath.row == 1){
        SMCategoryCell *categoryCell = [tableView dequeueReusableCellWithIdentifier:CategoryCellId];
        categoryCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //  跳转到购物车、收藏、优惠券
        SMWeakSelf;
        categoryCell.clickBtnBlock = ^(NSInteger index){
            switch (index) {
                case 0:
                {
                    SMShoppingCartController *scVc = [[SMShoppingCartController alloc] init];
                    [self.navigationController pushViewController:scVc animated:YES];
                    break;
                }
                    
                case 1:
                {
                    SMCollectionController *ctVc = [[SMCollectionController alloc] init];
                    [weakSelf.navigationController pushViewController:ctVc animated:YES];
                    break;
                }
                case 2:
                    
                    break;
                default:
                    break;
            }
        };
        return categoryCell;
        
    }else{
        SMMyLastCell *lastCell = [tableView dequeueReusableCellWithIdentifier:lastCellId];
        lastCell.selectionStyle = UITableViewCellSelectionStyleNone;
        //  点击item跳转到对应的界面---我的订单、我的预约、会员中心、分享给好友、客服中心、私人订制
        SMWeakSelf;
        lastCell.clickItemViewBlock = ^(NSInteger index){
            switch (index) {
                case 0:
                {
                    SMMyOrderController *moVc = [[SMMyOrderController alloc] init];
                    [weakSelf.navigationController pushViewController:moVc animated:YES];
                    break;
                }
                case 1:
                {
                    
                    SMMyAppointmentController *maVc = [[SMMyAppointmentController alloc] init];
                    [weakSelf.navigationController pushViewController:maVc animated:YES];
                    break;
                }
                case 2:
                    
                    break;
                case 3:
                    
                    break;
                case 4:
                    
                    break;
                case 5:
                {
                    SMMyPrivateCustomController *pcVc = [[SMMyPrivateCustomController alloc] init];
                    [weakSelf.navigationController pushViewController:pcVc animated:YES];
                    break;
                }
                    
                default:
                    break;
            }
        };
        return lastCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        SMPersonalHomepageController *phVc = [[SMPersonalHomepageController alloc] init];
        [self.navigationController pushViewController:phVc animated:YES];
    }
}

@end
