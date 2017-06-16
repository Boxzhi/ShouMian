//
//  SMProjectClassificationController.m
//  Shoumian
//
//  Created by 何志志 on 2017/3/2.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMProjectClassificationController.h"
#import "SMPCLeftTableviewCell.h"
#import "SMPCCollectionViewCell.h"
#import "SMPCEqualFlowLayout.h"
#import "SMPCCollectionViewHeaderView.h"
#import "SMPCCollectionViewSectionHeadView.h"
#import "SMProjectListController.h"

#define leftWidth ([UIScreen mainScreen].bounds.size.width * 100 / 375)
#define rightWidth ([UIScreen mainScreen].bounds.size.width - [UIScreen mainScreen].bounds.size.width * 100 / 375)

@interface SMProjectClassificationController ()<UICollectionViewDelegate, UICollectionViewDataSource, SMPCEqualFlowLayoutDelegate>

@property(strong, nonatomic) UITableView * leftTableView;
@property (nonatomic, strong) UICollectionView *rightCollection;
@property(assign, nonatomic) NSInteger selectIndex; // leftTableView选中的row
@property (nonatomic, strong) NSMutableArray *strArr;
@property (nonatomic, strong) NSMutableArray *leftStrArr;

@end

@implementation SMProjectClassificationController


static NSString * const tableViewCellId = @"PCtableViewCellId";
static NSString * const collectionCellId = @"PCcollectionCellId";
static NSString * const collectionFirstHeaderId = @"collectionFirstHeaderId";
static NSString * const collectionHeaderId = @"collectionHeaderId";

- (NSMutableArray *)strArr{
    if (!_strArr) {
        _strArr = [NSMutableArray arrayWithObjects:@"哈哈", @"哈ash", @"哈哈哈哈哈哈哈", @"哈safaada哈", @"嘻嘻嘻嘻西希西巡", @"海德汉", @"睡觉奥公司继父回家按实", @"啥哈哈假按揭", @"电视柜上", @"当时就活动结束", @"萨哈供货商噶", @"案件哈迪斯噶还是", @"玻尿酸1", @"水光针", @"圣诞节哈舒服哈十几个", @"华福锁国多干安华福锁", @"djshafha", @"fashgashg", @"fasggajgfhgs", @"ashfgahsgfa", @"wefhejfbaj", @"sjafgshg", @"sdjhsjdgfsdg", @"dsjfhd ", @"sdfjhahgf", nil];
    }
    return _strArr;
}

- (NSMutableArray *)leftStrArr{
    if (!_leftStrArr) {
        _leftStrArr = [NSMutableArray arrayWithObjects:@"全部项目", @"眼部", @"唇部", @"胸部", @"面部轮廓", @"皮肤", @"眼部", @"鼻部", @"牙齿", @"玻尿酸", @"美体", @"其他", nil];
    }
    return _leftStrArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.selectIndex = 0;  //一进入默认选中leftTableView的第0行
    self.title = @"项目分类";
    [self.view addSubview:self.contentTabPlain];
    self.contentTabPlain.frame = CGRectMake(0, 0, leftWidth, S_Height - 64);
    self.contentTabPlain.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.contentTabPlain.showsVerticalScrollIndicator = NO;
    [self.contentTabPlain registerNib:[UINib nibWithNibName:NSStringFromClass([SMPCLeftTableviewCell class]) bundle:nil] forCellReuseIdentifier:tableViewCellId];
    self.leftTableView = self.contentTabPlain;
    
    SMPCEqualFlowLayout *flowLayout = [[SMPCEqualFlowLayout alloc] init];
    flowLayout.smDelegate = self;
    self.rightCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(leftWidth, 0, S_Width - leftWidth, S_Height - 64) collectionViewLayout:flowLayout];
    self.rightCollection.contentInset = UIEdgeInsetsMake(0, 0, 15, 0);
    self.rightCollection.delegate = self;
    self.rightCollection.dataSource = self;
    self.rightCollection.backgroundColor = [UIColor whiteColor];
    [self.rightCollection registerNib:[UINib nibWithNibName:NSStringFromClass([SMPCCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:collectionCellId];
    [self.rightCollection registerNib:[UINib nibWithNibName:NSStringFromClass([SMPCCollectionViewHeaderView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionFirstHeaderId];
    [self.rightCollection registerNib:[UINib nibWithNibName:NSStringFromClass([SMPCCollectionViewSectionHeadView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionHeaderId];
    [self.view addSubview:self.rightCollection];
    
}

//  查看全部
- (void)setRightTableViewHeaderView{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rightWidth, 50)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    //  查看全部
    UIButton *allBtn = [UIButton hyb_buttonWithTitle:@"查看全部" superView:headerView constraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(30);
        make.centerY.equalTo(headerView.mas_centerY);
        make.height.mas_equalTo(15);
    } touchUp:^(UIButton *sender) {
        
    }];
    [allBtn setTitleColor:UIColor333 forState:UIControlStateNormal];
    [allBtn.titleLabel setFont:FONTSIZE(15)];
    [allBtn setImage:[UIImage imageNamed:@"community_into"] forState:UIControlStateNormal];
    [allBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];

    //  Line
    UIView *lineView = [UIView hyb_viewWithSuperView:headerView constraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(30);
        make.right.mas_offset(-SMMargin);
        make.bottom.equalTo(headerView);
        make.height.mas_equalTo(0.5);
    }];
    lineView.backgroundColor = LineViewBackgroundColor;
    
    self.contentTabGrouped.tableHeaderView = headerView;
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.leftStrArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SMPCLeftTableviewCell *leftCell = [tableView dequeueReusableCellWithIdentifier:tableViewCellId ];
    leftCell.titleLab.text = self.leftStrArr[indexPath.row];
    
    leftCell.backgroundColor = ViewBackgroundColor;
    leftCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == self.selectIndex) {   // 选中
        [self setLeftTablewCellSelected:YES withCell:leftCell];
    }else{   // 不选中
        [self setLeftTablewCellSelected:NO withCell:leftCell];
    }
    
    return leftCell;
    
};

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    SMPCLeftTableviewCell *cell = (SMPCLeftTableviewCell *)[tableView cellForRowAtIndexPath:indexPath];
    _selectIndex = indexPath.row;
    [self setLeftTablewCellSelected:YES withCell:cell];
    [self.contentTabPlain reloadData];
    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];

}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SMPCLeftTableviewCell *cell = (SMPCLeftTableviewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [self setLeftTablewCellSelected:NO withCell:cell];
}

-(void)setLeftTablewCellSelected:(BOOL)selected withCell:(SMPCLeftTableviewCell*)cell{
    if (selected) {
        cell.titleLab.textColor = UIColorRed;
        cell.rightView.hidden = NO;
    }else{
        cell.titleLab.textColor = UIColor333;
        cell.rightView.hidden = YES;
    }
}

#pragma mark - UICollectionDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 4;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 20;
    }else if (section == 1){
        return 10;
    }else if (section == 2){
        return 6;
    }else{
        return 8;
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size;
    CGFloat W = S_Width - leftWidth;
    CGFloat headerViewH = 92;
    CGFloat sectionHeadViewH = 54;
    if (section == 0) {
        size = CGSizeMake(W, headerViewH);
    }else{
        size = CGSizeMake(W, sectionHeadViewH);
    }
    return size;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        SMPCCollectionViewHeaderView *fistHeadView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:collectionFirstHeaderId forIndexPath:indexPath];
        return fistHeadView;
    }else{
        SMPCCollectionViewSectionHeadView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:collectionHeaderId forIndexPath:indexPath];
        return headView;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SMPCCollectionViewCell *collectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellId forIndexPath:indexPath];
    collectionCell.titleLab.text = self.strArr[indexPath.row];
    return collectionCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SMPCCollectionViewCell *pcCell = (SMPCCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    SMLog(@"%@", pcCell.titleLab.text);
    SMProjectListController *plVc = [[SMProjectListController alloc] init];
    [self.navigationController pushViewController:plVc animated:YES];
}

#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGRect labelRect = [self contentRectWithString:self.strArr[indexPath.row] labelHeight:25 AndStringFont:14];
    CGSize itemSize = CGSizeMake(labelRect.size.width + 20, 25);
    return itemSize;
}

//  自动计算label的宽度
-(CGRect)contentRectWithString:(NSString *)string labelHeight:(CGFloat)labelHeight AndStringFont:(int)fontSize
{
    CGRect tempRect = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, labelHeight)
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:fontSize],NSFontAttributeName, nil] context:nil];
    
    return tempRect;
}

//  自动计算label的高度
-(CGRect)contentRectWithString:(NSString *)string labelWidth:(CGFloat)labelWidth AndStringFont:(int)fontSize
{
    CGRect tempRect = [string boundingRectWithSize:CGSizeMake(labelWidth, MAXFLOAT)
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:fontSize],NSFontAttributeName, nil] context:nil];
    
    return tempRect;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
