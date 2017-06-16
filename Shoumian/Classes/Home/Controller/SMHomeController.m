//
//  SMHomeController.m
//  Shoumian
//
//  Created by 何志志 on 2017/1/19.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMHomeController.h"
#import <HYBLoopScrollView/HYBLoopScrollView.h>

#import "SMHomeHeaderView.h"
#import "SMHomeFirstCell.h"
#import "SMHomeSecondCell.h"
#import "SMHomeThirdCell.h"
#import "SMHomeFourthCell.h"
#import "SMHomeFifthCell.h"

#import "SMMyProjectController.h"
#import "SMDoctorsAppointmentsController.h"
#import "SMPrivateCustomController.h"
#import "SMOnlineConsultingController.h"
#import "SMMedicalEncyclopediaController.h"
#import "SMHospitalListController.h"
#import "SMSearchController.h"
#import "SMNavigationController.h"

@interface SMHomeController ()<UISearchBarDelegate>

//@property (nonatomic, strong) UITableView *contentTab;

@end

@implementation SMHomeController

static NSString * const homeFirstCellId = @"homeFirstCellId";
static NSString * const homeSecondCellId = @"homeSecondCellId";
static NSString * const homeThirdCellId = @"homeThirdCellId";
static NSString * const homeFourthCellId = @"homeFourthCellId";
static NSString * const homeFifthCellId = @"homeFifthCellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitleView];
    [self.view addSubview:self.contentTabGrouped];
    self.contentTabGrouped.backgroundColor = ViewBackgroundColor;
    self.contentTabGrouped.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    [self.contentTabGrouped registerNib:[UINib nibWithNibName:NSStringFromClass([SMHomeFirstCell class]) bundle:nil] forCellReuseIdentifier:homeFirstCellId];
    [self.contentTabGrouped registerNib:[UINib nibWithNibName:NSStringFromClass([SMHomeSecondCell class]) bundle:nil] forCellReuseIdentifier:homeSecondCellId];
    [self.contentTabGrouped registerNib:[UINib nibWithNibName:NSStringFromClass([SMHomeThirdCell class]) bundle:nil] forCellReuseIdentifier:homeThirdCellId];
    [self.contentTabGrouped registerNib:[UINib nibWithNibName:NSStringFromClass([SMHomeFourthCell class]) bundle:nil] forCellReuseIdentifier:homeFourthCellId];
    [self.contentTabGrouped registerNib:[UINib nibWithNibName:NSStringFromClass([SMHomeFifthCell class]) bundle:nil] forCellReuseIdentifier:homeFifthCellId];
    
    self.contentTabGrouped.tableHeaderView = [self getHeaderView];
}

- (void)setTitleView{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, S_Width - 30, 44)];
    titleView.backgroundColor = [UIColor whiteColor];
    
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.backgroundColor = [UIColor whiteColor];
    searchBar.delegate = self;
    searchBar.placeholder = @"搜索医院/项目/日记/帖子/圈子";
    [searchBar hzz_roundedCornerWithCornerRadii:CGSizeMake(12.5, 0) cornerColor:[UIColor whiteColor] corners:UIRectCornerAllCorners borderColor:LineViewBackgroundColor borderWidth:1.0f];
    [titleView addSubview:searchBar];
    [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(titleView);
        make.height.mas_equalTo(30);
        make.centerY.equalTo(titleView.mas_centerY);
    }];
    
    self.navigationItem.titleView = titleView;
}

#pragma mark -- UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    SMSearchController *searchVc = [[SMSearchController alloc] init];
    SMNavigationController *nav = [[SMNavigationController alloc] initWithRootViewController:searchVc];
    [self presentViewController:nav animated:YES completion:nil];
    return NO;
}

#pragma mark - UITableViewDelegate
- (UIView *)getHeaderView{
    
    /**
     *  首页轮播图
     */
    SMHomeHeaderView *headerView = [SMHomeHeaderView viewFromXib];
    CGRect headFrame = headerView.frame;
    headFrame.size.height = Reality_Height(305);
    headerView.frame = headFrame;
    NSArray *imageUrlArr = @[[UIImage imageNamed:@"banner"], @"http://pic39.nipic.com/20140226/18071023_162553457000_2.jpg", [UIImage imageNamed:@"banner"], [UIImage imageNamed:@"banner"]];
    HYBLoopScrollView *loopScrollView = [HYBLoopScrollView loopScrollViewWithFrame:CGRectMake(0, 0, S_Width, S_Width * 8 / 15) imageUrls:imageUrlArr timeInterval:3 didSelect:^(NSInteger atIndex) {
        
    } didScroll:^(NSInteger toIndex) {
        
    }];
    loopScrollView.shouldAutoClipImageToViewSize = YES;
    loopScrollView.alignment = kPageControlAlignCenter;
    [headerView.headerImageView addSubview:loopScrollView];
    
    // 查项目
    [headerView.checkItemView hyb_addTapGestureWithCallback:^(UITapGestureRecognizer *sender) {
        SMLog(@"点击查项目");
    }];
    // 找医院
    [headerView.findHospitalView hyb_addTapGestureWithCallback:^(UITapGestureRecognizer *sender) {
        SMLog(@"点击找医院");
        SMHospitalListController *hospitalListVc = [[SMHospitalListController alloc] init];
        [self.navigationController pushViewController:hospitalListVc animated:YES];
    }];
    // 看案例
    [headerView.seeCaseView hyb_addTapGestureWithCallback:^(UITapGestureRecognizer *sender) {
        SMLog(@"点击看案例");
    }];
    // 进圈子
    [headerView.enterCircleView hyb_addTapGestureWithCallback:^(UITapGestureRecognizer *sender) {
        SMLog(@"点击进圈子");
    }];
    
    return headerView;
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 3) {
        return 3;
    }else if (section == 4){
        return 2;
    }else{
        return 1;
    }
}

// 高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return Reality_Height(140);
    }else if (indexPath.section == 1){
        return 232;
    }else if (indexPath.section == 2){
        return Reality_Height(389);
    }else if (indexPath.section == 3){
        self.contentTabGrouped.rowHeight = UITableViewAutomaticDimension;
        self.contentTabGrouped.estimatedRowHeight = 188;
        return self.contentTabGrouped.rowHeight;
    }else{   // 真人案例
//        if (iPhone5) {
//            return 320;
//        }else if (iPhone6){
//            return 360;
//        }else{
//            return 380;
//        }
        return (S_Width - 45) * 12 / 22 + 180;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return Reality_Height(45);
    }else if (section == 1){
        return Reality_Height(60);
    }else if (section == 2){
        return Reality_Height(76);
    }else if (section == 3){
        return Reality_Height(56);
    }else{
        return Reality_Height(53);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 3) {
        return 9;
    }else if (section == 4){
        return 120;
    }else{
        return 0.01;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return [self setTitle:@"医美服务" topOffset:7 imageTitleSpace:0 WithSection:section];
    }else if (section == 1){
        return [self setTitle:@"医美百科" topOffset:25 imageTitleSpace:10 WithSection:section];
    }else if (section == 2){
        return [self setTitle:@"项目推荐" topOffset:38 imageTitleSpace:10 WithSection:section];
    }else if (section == 3){
        return [self setTitle:@"热门帖子" topOffset:23 imageTitleSpace:10 WithSection:section];
    }else{
        return [self setTitle:@"精选日记" topOffset:20 imageTitleSpace:10 WithSection:section];
    }
}

- (UIView *)setTitle:(NSString *)title topOffset:(CGFloat)topOffset imageTitleSpace:(CGFloat)imageTitleSpace WithSection:(NSInteger)section{
    
    UIView *sectionView = [[UIView alloc] init];
    sectionView.backgroundColor = [UIColor whiteColor];
    
    SMWeakSelf;
    UIButton *btn = [UIButton hyb_buttonWithTitle:title superView:sectionView constraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(topOffset);
        make.centerX.equalTo(sectionView.mas_centerX);
    } touchUp:^(UIButton *sender) {
        if (section == 0) {
            SMLog(@"点击我的服务");
        }else if (section == 1){
            SMLog(@"点击医美百科");
            SMMedicalEncyclopediaController *meVc = [[SMMedicalEncyclopediaController alloc] init];
            [weakSelf.navigationController pushViewController:meVc animated:YES];
        }else if (section == 2){
            SMLog(@"点击项目推荐");
        }else if (section == 3){
            SMLog(@"点击热门帖子");
        }else if (section == 4){
            SMLog(@"点击真人案例");
        }
    }];
//    [btn setTitleAndColor];
    if (section != 0) {
        [btn setImage:[UIImage imageNamed:@"home_into"] forState:UIControlStateNormal];
    }
    [btn setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [btn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:imageTitleSpace];
    
    return sectionView;
}



#pragma mark - 底部意见反馈
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 3) {
        
        UIView *fourthFooterView = [[UIView alloc] init];
        fourthFooterView.backgroundColor = UIColorFromRGB(0xf8f8f8);
        return fourthFooterView;
        
    }else if (section == 4){
        
        UIView *fifthFooterView = [[UIView alloc] init];
        fifthFooterView.backgroundColor = UIColorFromRGB(0xf8f8f8);
        
        [self getFifthFooterViewWithSuperView:fifthFooterView title:@"意见反馈" tagNum:0];
//        [self getFifthFooterViewWithSuperView:fifthFooterView title:@"在线咨询" tagNum:1];
        
        return fifthFooterView;

    }else{
        return nil;
    }
}

- (UIView *)getFifthFooterViewWithSuperView:(UIView *)superView title:(NSString *)title tagNum:(NSInteger)tagNum{
    
    CGFloat topOffset;
    if (tagNum == 0) {
        topOffset  = 10;
    }else{
        topOffset  = 10 * 2 + 45;
    }
    
    UIView *cellView = [UIView hyb_viewWithSuperView:superView constraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(topOffset);
        make.left.right.equalTo(superView);
        make.height.mas_equalTo(45);
    } onTaped:^(UITapGestureRecognizer *sender) {
        if (tagNum == 0) {
            SMLog(@"意见反馈");
        }else{
            SMLog(@"在线咨询");
            SMOnlineConsultingController *oncoVc = [[SMOnlineConsultingController alloc] init];
            [self.navigationController pushViewController:oncoVc animated:YES];
        }
    }];
    UILabel *titleLab = [UILabel hyb_labelWithText:title font:16 superView:cellView constraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(12.5);
        make.centerY.equalTo(cellView.mas_centerY);
    }];
    titleLab.textColor = UIColorFromRGB(0x333333);
    UIImageView *cellImage = [UIImageView hyb_imageViewWithImage:@"home_into" superView:cellView constraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(15);
        make.right.mas_offset(-15);
        make.centerY.equalTo(cellView.mas_centerY);
    }];

    return cellView;
}

/**
 *  cell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        SMHomeFirstCell *firstCell = [tableView dequeueReusableCellWithIdentifier:homeFirstCellId];
        /**
         *  跳转-->我的项目
         */
        [firstCell.firstCellImageViewA hyb_addTapGestureWithCallback:^(UITapGestureRecognizer *sender) {
            SMMyProjectController *myProjectVc = [[SMMyProjectController alloc] init];
            [self.navigationController pushViewController:myProjectVc animated:YES];
        }];
        /**
         *  跳转-->预约名医
         */
        [firstCell.firstCellImageViewB hyb_addTapGestureWithCallback:^(UITapGestureRecognizer *sender) {
            SMDoctorsAppointmentsController *docAppVc = [[SMDoctorsAppointmentsController alloc] init];
            [self.navigationController pushViewController:docAppVc animated:YES];
        }];
        /**
         *  跳转-->私人订制
         */
        [firstCell.firstCellImageViewC hyb_addTapGestureWithCallback:^(UITapGestureRecognizer *sender) {
            SMPrivateCustomController *priCusVc = [[SMPrivateCustomController alloc] init];
            [self.navigationController pushViewController:priCusVc animated:YES];
        }];
        firstCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return firstCell;
    }else if (indexPath.section == 1){
        SMHomeSecondCell *secondCell = [tableView dequeueReusableCellWithIdentifier:homeSecondCellId];
        secondCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return secondCell;
        
    }else if (indexPath.section == 2){
        SMHomeThirdCell *thirdCell = [tableView dequeueReusableCellWithIdentifier:homeThirdCellId];
        thirdCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return thirdCell;;
    }else if (indexPath.section == 3){
        SMHomeFourthCell *fourthCell = [tableView dequeueReusableCellWithIdentifier:homeFourthCellId];
        fourthCell.selectionStyle = UITableViewCellEditingStyleNone;
        return fourthCell;
    }else{
        SMHomeFifthCell *fifthCell = [tableView dequeueReusableCellWithIdentifier:homeFifthCellId];
        fifthCell.selectionStyle = UITableViewCellEditingStyleNone;
        return fifthCell;
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
