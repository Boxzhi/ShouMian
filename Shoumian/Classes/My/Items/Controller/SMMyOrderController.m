//
//  SMMyOrderController.m
//  Shoumian
//
//  Created by 何志志 on 2017/3/20.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMMyOrderController.h"
#import "SMMyOrderHeaderView.h"
#import "SMMyOrderCell.h"
#import "SMMyOrderFooterView.h"
#import "SMOrderDetailsController.h"
#import "JSDropDownMenu.h"


@interface SMMyOrderController ()<JSDropDownMenuDelegate, JSDropDownMenuDataSource>{
    
    NSMutableArray *_menuData;
    NSInteger _currentDataIndex;
    JSDropDownMenu *_menu;
}

@end

@implementation SMMyOrderController

static NSString * const moHeadViewId = @"moHeadViewId";
static NSString * const moCellId = @"moCellId";
static NSString * const moFootViewId = @"moFootViewId";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的订单";
    [self setMenuView];
    [self.view addSubview:self.contentTabGrouped];
    self.contentTabGrouped.frame = CGRectMake(0, SMMenuHeight, S_Width, S_Height - SMNavHeight - SMMenuHeight);
    [self.contentTabGrouped registerNib:[UINib nibWithNibName:NSStringFromClass([SMMyOrderHeaderView class]) bundle:nil] forHeaderFooterViewReuseIdentifier:moHeadViewId];
    [self.contentTabGrouped registerNib:[UINib nibWithNibName:NSStringFromClass([SMMyOrderCell class]) bundle:nil] forCellReuseIdentifier:moCellId];
    [self.contentTabGrouped registerNib:[UINib nibWithNibName:NSStringFromClass([SMMyOrderFooterView class]) bundle:nil] forHeaderFooterViewReuseIdentifier:moFootViewId];
    self.contentTabGrouped.rowHeight = 103;
}

- (void)setMenuView{
    
//    NSArray *titleArr = [NSArray arrayWithObject:@"全部订单"];
//    HZZClassifyMenuView *menuView = [[HZZClassifyMenuView alloc] initWithRect:CGRectMake(0, 0, S_Width, SMMenuHeight) buttonTitles:titleArr titleColor:nil image:nil clickBlock:^(int index, HZZButton *btn) {
//        [UIView animateWithDuration:0.3 animations:^{
//            btn.imageView.transform = CGAffineTransformMakeRotation(M_PI);
//        }];
//    }];
//
//    [self.view addSubview:menuView];
    _menuData = [NSMutableArray arrayWithObjects:@"全部订单", @"待付款", @"待消费", @"已消费", @"退款", nil];
    _menu = [[JSDropDownMenu alloc] initWithOrigin:CGPointMake(0, 0) andHeight:SMMenuHeight];
    _menu.indicatorColor = [UIColor blackColor];
    _menu.separatorColor = RGBA(222, 223, 224, 1.0);
    _menu.textColor = UIColor666;
    _menu.delegate = self;
    _menu.dataSource = self;
    [self.view addSubview:_menu];
}

#pragma mark -- JSDropDownMenu
- (NSInteger)numberOfColumnsInMenu:(JSDropDownMenu *)menu {
    
    return 1;
}

-(BOOL)displayByCollectionViewInColumn:(NSInteger)column{
    return NO;
}

-(BOOL)haveRightTableViewInColumn:(NSInteger)column{
    return NO;
}

-(CGFloat)widthRatioOfLeftColumn:(NSInteger)column{
    return 1;
}

-(NSInteger)currentLeftSelectedRow:(NSInteger)column{
    return _currentDataIndex;
}

- (NSInteger)menu:(JSDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column leftOrRight:(NSInteger)leftOrRight leftRow:(NSInteger)leftRow{
    return _menuData.count;
}

- (NSString *)menu:(JSDropDownMenu *)menu titleForColumn:(NSInteger)column{
    return _menuData[_currentDataIndex];

}

- (NSString *)menu:(JSDropDownMenu *)menu titleForRowAtIndexPath:(JSIndexPath *)indexPath {
    return _menuData[indexPath.row];
}

- (void)menu:(JSDropDownMenu *)menu didSelectRowAtIndexPath:(JSIndexPath *)indexPath {
    _currentDataIndex = indexPath.row;
}



#pragma mark -- UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 160;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    SMMyOrderHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:moHeadViewId];
    headerView.contentView.backgroundColor = [UIColor whiteColor];
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    SMMyOrderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:moFootViewId];
    footerView.contentView.backgroundColor = ViewBackgroundColor;
    return footerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SMMyOrderCell *moCell = [tableView dequeueReusableCellWithIdentifier:moCellId forIndexPath:indexPath];
    moCell.appointmentBtn.hidden = YES;
    moCell.bottomView.hidden = YES;
    return moCell;
};

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SMOrderDetailsController *odVc = [[SMOrderDetailsController alloc] init];
    [self.navigationController pushViewController:odVc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
