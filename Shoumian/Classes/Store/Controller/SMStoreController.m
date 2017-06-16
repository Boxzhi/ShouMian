//
//  SMStoreController.m
//  Shoumian
//
//  Created by 何志志 on 2017/1/19.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMStoreController.h"
#import <HYBLoopScrollView/HYBLoopScrollView.h>
#import "SMThirdDoctorCell.h"
#import "SMFourthCustomCell.h"
#import "SMStoreFirstCell.h"
#import "SMStoreSecondCell.h"
#import "SMStoreFirstLayoutCell.h"
#import "SMProjectClassificationController.h"
#import "SMStoreDoctorController.h"
#import "SMStoreDoctorHomepageController.h"
#import "SMProjectListController.h"

@interface SMStoreController ()<UICollectionViewDelegate>

@end

@implementation SMStoreController

static NSString * const firstCellId = @"firstCellId";
static NSString * const secondCellId = @"secondCellId";
static NSString * const doctorCellId = @"doctorCellId";
static NSString * const customCellId = @"customCellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.contentTabGrouped];
    [self setTableViewHeaderView];
    
    self.contentTabGrouped.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    [self.contentTabGrouped registerClass:[SMStoreFirstCell class] forCellReuseIdentifier:firstCellId];
    [self.contentTabGrouped registerNib:[UINib nibWithNibName:NSStringFromClass([SMStoreSecondCell class]) bundle:nil] forCellReuseIdentifier:secondCellId];
    [self.contentTabGrouped registerNib:[UINib nibWithNibName:NSStringFromClass([SMThirdDoctorCell class]) bundle:nil] forCellReuseIdentifier:doctorCellId];
    [self.contentTabGrouped registerNib:[UINib nibWithNibName:NSStringFromClass([SMFourthCustomCell class]) bundle:nil] forCellReuseIdentifier:customCellId];
    
}

- (void)setTableViewHeaderView{
    NSArray *imageUrlArr = @[[UIImage imageNamed:@"mall_banner_a"], [UIImage imageNamed:@"mall_banner_b"], [UIImage imageNamed:@"mall_img_d"]];
    CGFloat loopH = S_Width * 42 / 75;
    HYBLoopScrollView *loopScrollView = [HYBLoopScrollView loopScrollViewWithFrame:CGRectMake(0, 0, S_Width, loopH) imageUrls:imageUrlArr timeInterval:3 didSelect:^(NSInteger atIndex) {
        
    } didScroll:^(NSInteger toIndex) {
        
    }];
    loopScrollView.shouldAutoClipImageToViewSize = YES;
    loopScrollView.alignment = kPageControlAlignCenter;
    
    self.contentTabGrouped.tableHeaderView = loopScrollView;
//    self.contentTabGrouped.sectionHeaderHeight = loopH;
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 2) {
        return 2;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 3) {
        return 90;
    }else{
        return 0.01;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return Reality_Height(110);
    }else if (indexPath.section == 1){
        return Reality_Height(348);
    }else if (indexPath.section == 2){
        return 122;
    }else{
        return Reality_Height(140);
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return [self setTitle:@"项目分类" topOffset:25 imageTitleSpace:5 WithSection:section];
    }else if (section == 1){
        return [self setTitle:@"最新热卖" topOffset:25 imageTitleSpace:5 WithSection:section];
    }else if (section == 2){
        return [self setTitle:@"预约名医" topOffset:25 imageTitleSpace:5 WithSection:section];
    }else{
        return [self setTitle:@"私人订制" topOffset:25 imageTitleSpace:5 WithSection:section];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 3) {
        UIView *footerView = [[UIView alloc] init];
        footerView.backgroundColor = [UIColor whiteColor];
        
        UIButton *footerBtn = [UIButton hyb_buttonWithTitle:@"开启自主订制" superView:footerView constraints:^(MASConstraintMaker *make) {
            make.center.equalTo(footerView);
            make.width.mas_equalTo(162);
            make.height.mas_equalTo(22);
        } touchUp:^(UIButton *sender) {
            SMLog(@"进入自主订制界面");
        }];
        [footerBtn setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
        [footerBtn.titleLabel setFont:[UIFont fontWithName:@"System-Medium-Bold" size:17]];
        [footerBtn setImage:[UIImage imageNamed:@"mall_jiantou"] forState:UIControlStateNormal];
        [footerBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleBottom imageTitleSpace:-30];
        
        return footerView;
    }else{
        return nil;
    }
}

- (UIView *)setTitle:(NSString *)title topOffset:(CGFloat)topOffset imageTitleSpace:(CGFloat)imageTitleSpace WithSection:(NSInteger)section{
    
    UIView *sectionView = [[UIView alloc] init];
    sectionView.backgroundColor = [UIColor whiteColor];
    
    SMWeakSelf;
    UIButton *btn = [UIButton hyb_buttonWithTitle:title superView:sectionView constraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(topOffset);
        make.centerX.equalTo(sectionView.mas_centerX);
//        make.width.mas_equalTo(width);
    } touchUp:^(UIButton *sender) {
        if (section == 0) {
            SMLog(@"进入项目分类页面");
            SMProjectClassificationController *pcVc = [[SMProjectClassificationController alloc] init];
            [weakSelf.navigationController pushViewController:pcVc animated:YES];
            
        }else if (section == 1){
            SMLog(@"进入最新热卖页面");
        }else if (section == 2){
            SMLog(@"进入预约名医页面");
            SMStoreDoctorController *sdVc = [[SMStoreDoctorController alloc] init];
            [self.navigationController pushViewController:sdVc animated:YES];
        }else if (section == 3){
            SMLog(@"进入私人订制页面");
        }
    }];
    [btn setTitleAndColor];
    [btn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:imageTitleSpace];
    
    return sectionView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {

        NSMutableArray *strArr = [NSMutableArray arrayWithObjects:@"面部轮毂", @"吸脂", @"双眼皮", @"隆胸", @"补水美白", @"激光美白", @"隆鼻", @"眼部微整", nil];
        SMStoreFirstCell *firstCell = [tableView dequeueReusableCellWithIdentifier:firstCellId forIndexPath:indexPath];
        firstCell.collView.delegate = self;
        firstCell.arr = strArr;
        return firstCell;
        
    }else if (indexPath.section == 1){
        
        SMStoreSecondCell *secondCell = [tableView dequeueReusableCellWithIdentifier:secondCellId forIndexPath:indexPath];
        return secondCell;
        
    }else if (indexPath.section == 2){
        
        SMThirdDoctorCell *doctorCell = [tableView dequeueReusableCellWithIdentifier:doctorCellId];
        return doctorCell;
    }else{
        SMFourthCustomCell *customCell = [tableView dequeueReusableCellWithIdentifier:customCellId];
        return customCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SMLog(@"点击cell");
    if (indexPath.section == 2) {
        SMStoreDoctorHomepageController *sdhpVc = [[SMStoreDoctorHomepageController alloc] init];
        [self.navigationController pushViewController:sdhpVc animated:YES];
    }
}


#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SMStoreFirstLayoutCell *cell = (SMStoreFirstLayoutCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    NSString *tagStr = cell.titleLab.text;
    SMProjectListController *plVc = [[SMProjectListController alloc] init];
    [self.navigationController pushViewController:plVc animated:YES];
    SMLog(@"%@", tagStr);
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
