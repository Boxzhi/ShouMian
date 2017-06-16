//
//  SMPersonalDataController.m
//  Shoumian
//
//  Created by 何志志 on 2017/3/13.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMPersonalDataController.h"
#import "SMPersonalDataCell.h"
#import "SMPersonalDataCollectionViewCell.h"

@interface SMPersonalDataController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *collectionTitleArr;

@end

@implementation SMPersonalDataController

static NSString * const pdCellId = @"pdCellId";
static NSString * const pdCollectionCellId = @"pdCollectionCellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.collectionTitleArr = [NSArray arrayWithObjects:@"柔润保湿", @"水光针", @"双眼皮", nil];
    
    self.title = @"个人资料";
    [self.view addSubview:self.contentTabGrouped];
    self.contentTabGrouped.backgroundColor = [UIColor whiteColor];
    [self.contentTabGrouped registerNib:[UINib nibWithNibName:NSStringFromClass([SMPersonalDataCell class]) bundle:nil] forCellReuseIdentifier:pdCellId];
    self.contentTabGrouped.rowHeight = 300;
    [self setHeaderFooterView];
}

- (void)setHeaderFooterView{
    //  HeaderView
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, S_Width, 85)];
    headView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *headImage = [UIImageView hyb_imageViewWithSuperView:headView constraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headView.mas_centerY);
        make.width.height.mas_equalTo(66);
        make.left.mas_offset(SMMargin);
    }];
    headImage.image = [UIImage imageNamed:@"my_img_user_b_66"];
    
    UILabel *changeLab = [UILabel hyb_labelWithText:@"更换头像" font:15 superView:headView constraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headImage.mas_right).offset(15);
        make.centerY.equalTo(headView.mas_centerY);
    }];
    changeLab.textColor = UIColor333;
    [changeLab hyb_addTapGestureWithCallback:^(UITapGestureRecognizer *sender) {
        
    }];
    UIView *lineView = [UIView hyb_addBottomLineToView:headView height:0.5f color:LineViewBackgroundColor];
    
    self.contentTabGrouped.tableHeaderView = headView;
    
    // FooterView
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, S_Width, 165)];
    footView.backgroundColor = [UIColor whiteColor];
    
    UILabel *interestedLab = [UILabel hyb_labelWithText:@"感兴趣的项目" font:15 superView:footView constraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(SMMargin);
        make.top.mas_offset(20);
    }];
    interestedLab.textColor = UIColor333;
    
    UIButton *saveBtn = [UIButton hyb_buttonWithTitle:@"保存" superView:footView constraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_offset(-SMMargin);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(40);
    } touchUp:^(UIButton *sender) {
        
    }];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [saveBtn setBackgroundColor:UIColorRed];
    saveBtn.layer.masksToBounds = YES;
    saveBtn.layer.cornerRadius = 6;
    
    UICollectionView *collView = [UICollectionView hyb_collectionViewWithDelegate:self horizontal:NO size:CGSizeMake(90, 30) itemSpacing:15 lineSpacing:15 superView:footView constraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(SMMargin);
        make.right.mas_offset(-SMMargin);
        make.top.equalTo(interestedLab.mas_bottom).offset(25);
        make.bottom.equalTo(saveBtn.mas_top).offset(-15);
    }];
    collView.backgroundColor = [UIColor whiteColor];
    [collView registerNib:[UINib nibWithNibName:@"SMPersonalDataCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:pdCollectionCellId];
    
    self.contentTabGrouped.tableFooterView = footView;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SMPersonalDataCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:pdCollectionCellId forIndexPath:indexPath];
    cell.titleLab.text = self.collectionTitleArr[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SMPersonalDataCell *cell = [tableView dequeueReusableCellWithIdentifier:pdCellId forIndexPath:indexPath];
    return cell;
};

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
