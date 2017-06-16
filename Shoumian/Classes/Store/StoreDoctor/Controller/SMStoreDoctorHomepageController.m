//
//  SMStoreDoctorHomepageController.m
//  Shoumian
//
//  Created by 何志志 on 2017/3/3.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMStoreDoctorHomepageController.h"
#import "SMDoctorHomepageHeaderView.h"
#import "SMStoreDoctorHPFirstCell.h"
#import "SMHomeFifthCell.h"
#import "SMDoctorUserEvaluationCell.h"
#import "HZZBottomView.h"

@interface SMStoreDoctorHomepageController ()

@property (nonatomic, assign) NSInteger subViewIndex;

@end

@implementation SMStoreDoctorHomepageController

static NSString * const firstCellId = @"firstCellId";
static NSString * const secondCellId = @"secondCellId";
static NSString * const thirdCellId = @"thirdCellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"医生主页";
    self.subViewIndex = 0;
    
    
    [self.view addSubview:self.contentTabPlain];
    self.contentTabPlain.tableHeaderView = [SMDoctorHomepageHeaderView viewFromXib];
    [self.contentTabPlain registerNib:[UINib nibWithNibName:NSStringFromClass([SMStoreDoctorHPFirstCell class]) bundle:nil] forCellReuseIdentifier:firstCellId];
    [self.contentTabPlain registerNib:[UINib nibWithNibName:NSStringFromClass([SMHomeFifthCell class]) bundle:nil] forCellReuseIdentifier:secondCellId];
    [self.contentTabPlain registerNib:[UINib nibWithNibName:NSStringFromClass([SMDoctorUserEvaluationCell class]) bundle:nil] forCellReuseIdentifier:thirdCellId];
    
    [self setBottomView];
}

- (void)setBottomView{
    
    HZZBottomView *bottomView = [[HZZBottomView alloc] initWithRect:CGRectMake(0, S_Height - SMBottomHeight - SMNavHeight, S_Width, SMBottomHeight) titles:[NSArray arrayWithObject:@"联系客服"] images:[NSArray arrayWithObject:@"mall_kefu_white"] colors:[NSArray arrayWithObject:@"ff5050"] tagBase:10010];
    [self.view addSubview:bottomView];
}


#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return SMBottomHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_subViewIndex == 0) {
        
        return 123;
    }else if (_subViewIndex == 1){
        if (iPhone5) {
            return 320;
        }else if (iPhone6){
            return 360;
        }else{
            return 380;
        }
    }else{
        self.contentTabPlain.rowHeight = UITableViewAutomaticDimension;
        self.contentTabPlain.estimatedRowHeight = 170;
        return self.contentTabPlain.rowHeight;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc] init];
    headView.backgroundColor = [UIColor whiteColor];
    
    [self setSectionHeaderView:headView];
    
    return headView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footView = [[UIView alloc] init];
    footView.backgroundColor = [UIColor clearColor];
    return footView;
}

- (void)setSectionHeaderView:(UIView *)headView{
    SMWeakSelf;
    for (int i = 0; i < 3; i++) {
        UIView *subView = [UIView hyb_viewWithSuperView:headView constraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headView.mas_left).offset(S_Width / 3 * i);
            make.top.bottom.equalTo(headView);
            make.width.mas_equalTo(S_Width / 3);
        } onTaped:^(UITapGestureRecognizer *sender) {
            _subViewIndex = i;
            [weakSelf.contentTabPlain reloadData];
            
//            [weakSelf.contentTabPlain setContentOffset:CGPointMake(self.contentTabPlain.contentOffset.x, self.contentTabPlain.tableHeaderView.sm_height) animated:YES];
        }];
        subView.backgroundColor = [UIColor whiteColor];
        
        UILabel *lab = [UILabel hyb_labelWithFont:15 superView:subView constraints:^(MASConstraintMaker *make) {
            make.center.equalTo(subView);
        }];
        switch (i) {
            case 0:
                lab.text = @"预约项目";
                break;
            case 1:
                lab.text = @"相关日记";
                break;
            case 2:
                lab.text = @"用户评价";
                break;
            default:
                break;
        }
        UIView *lineView = [UIView hyb_viewWithSuperView:subView constraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(3);
            make.centerX.equalTo(subView.mas_centerX);
            make.bottom.equalTo(subView.mas_bottom);
        }];
        lineView.backgroundColor = UIColorRed;
        
        if (i == _subViewIndex) {
            lab.textColor = UIColorRed;
            lineView.hidden = NO;
        }else{
            lab.textColor = UIColor333;
            lineView.hidden = YES;
        }
    }
    
    UIView *garyLineView = [UIView hyb_addBottomLineToView:headView height:0.5 color:LineViewBackgroundColor];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_subViewIndex == 0) {
        
        SMStoreDoctorHPFirstCell *firstCell = [tableView dequeueReusableCellWithIdentifier:firstCellId forIndexPath:indexPath];
        return firstCell;
    }else if (_subViewIndex == 1){
        SMHomeFifthCell *secondCell = [tableView dequeueReusableCellWithIdentifier:secondCellId forIndexPath:indexPath];
        return secondCell;
    }else{
        SMDoctorUserEvaluationCell *thirdCell = [tableView dequeueReusableCellWithIdentifier:thirdCellId forIndexPath:indexPath];
        return thirdCell;
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
