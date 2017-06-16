//
//  SMCollectionController.m
//  Shoumian
//
//  Created by 何志志 on 2017/3/21.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMCollectionController.h"
#import "JSDropDownMenu.h"
#import "SMCollectionHospitalCell.h"
#import "SMCollectionCellMenuView.h"
#import "ABMenuTableViewCell.h"

@interface SMCollectionController ()<JSDropDownMenuDelegate, JSDropDownMenuDataSource>{
    
    NSMutableArray *_menuData;
    NSInteger _currentDataIndex;
    JSDropDownMenu *_menu;
}

@property (nonatomic, assign) BOOL isCanSideBack;

@end

@implementation SMCollectionController

static NSString * const chCellId = @"chCellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的收藏";
    [self setMenuView];
    [self.view addSubview:self.contentTabGrouped];
    [self.contentTabGrouped registerNib:[UINib nibWithNibName:NSStringFromClass([SMCollectionHospitalCell class]) bundle:nil] forCellReuseIdentifier:chCellId];
    self.contentTabGrouped.frame = CGRectMake(0, SMMenuHeight, S_Width, S_Height - SMMenuHeight - SMNavHeight);
}

- (void)setMenuView{
    _menuData = [NSMutableArray arrayWithObjects:@"全部", @"项目", @"医院", @"百科", @"帖子", @"日记", nil];
    _menu = [[JSDropDownMenu alloc] initWithOrigin:CGPointMake(0, 0) andHeight:SMMenuHeight];
    _menu.indicatorColor = [UIColor blackColor];
    _menu.separatorColor = RGBA(222, 223, 224, 1.0);
    _menu.textColor = UIColor666;
    _menu.delegate = self;
    _menu.dataSource = self;
    [self.view addSubview:_menu];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 124;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"ABMenuTableViewCell111";
    ABMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[ABMenuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    // use your own custom menu view
    SMCollectionCellMenuView *menuView = [SMCollectionCellMenuView viewFromXib];
    menuView.shareDeleteBtnClick = ^(NSInteger index){
        
    };
    cell.rightMenuView = menuView;
    
    return cell;

}

#pragma mark - 左滑删除所有方法
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//}
//
//- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return @"取消收藏";
//}
//
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
//    return YES;
//}
//
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return UITableViewCellEditingStyleDelete;
//}
//
//- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"取消收藏" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//        
//    }];
//    
//    deleteRowAction.backgroundColor = RGB(255, 37, 55);
//    
//    return @[deleteRowAction];
//}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
