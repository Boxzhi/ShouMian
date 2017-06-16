//
//  SMAssociationController.m
//  Shoumian
//
//  Created by 何志志 on 2017/2/4.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMAssociationController.h"
#import "SMHomeFourthCell.h"
#import "SMHomeFifthCell.h"
#import "SMAtWendaCell.h"
#import "SMCircleController.h"
#import "SMCommunityPostController.h"
#import "SMPostingTipsController.h"
#import "SMInterrogationController.h"

CGFloat const categoryBtnW = 60;
CGFloat const categoryBtnH = 90;
CGFloat const sqMargin = 45;

@interface SMAssociationController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UIView *menuView;  // 蒙版View
@property (nonatomic, weak) UIButton *writeBtn;
@property (nonatomic, weak) UIButton *fatieBtn;
@property (nonatomic, weak) UIButton *rijiBtn;

@end

@implementation SMAssociationController

static NSString * const tieziCellId = @"tieziCellId";
static NSString * const anliCellId = @"anliCellId";
static NSString * const wendaCellId = @"wendaCellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self.view addSubview:self.contentTab];       ///
//    [self.contentTab setSeparatorInset:UIEdgeInsetsZero];
//    [self.contentTab setLayoutMargins:UIEdgeInsetsZero];
    
    [self.view addSubview:self.contentTabGrouped];
    [self.contentTabGrouped registerNib:[UINib nibWithNibName:NSStringFromClass([SMHomeFourthCell class]) bundle:nil] forCellReuseIdentifier:tieziCellId];
    [self.contentTabGrouped registerNib:[UINib nibWithNibName:NSStringFromClass([SMHomeFifthCell class]) bundle:nil] forCellReuseIdentifier:anliCellId];
    [self.contentTabGrouped registerNib:[UINib nibWithNibName:NSStringFromClass([SMAtWendaCell class]) bundle:nil] forCellReuseIdentifier:wendaCellId];
    self.contentTabGrouped.frame = CGRectMake(0, 0, S_Width, S_Height - 64 - 49 - 44);
    self.contentTabGrouped.tableHeaderView = [self setContentView];
    self.contentTabGrouped.sectionHeaderHeight = 180;
    
    // 上面的灰色线
    UIView *lineViewF = [UIView hyb_viewWithSuperView:self.view constraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(0.5);
    }];
    lineViewF.backgroundColor = UIColorFromRGB(0xdddddd);

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.menuView removeFromSuperview];
    [self.writeBtn removeFromSuperview];
    [self.fatieBtn removeFromSuperview];
    [self.rijiBtn removeFromSuperview];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    // 在页面显示完毕的时候创建悬浮的写案例按钮
    [self setWriteCaseButton];
}

#pragma mark - 悬浮按钮
- (void)setWriteCaseButton{
     UIButton *writeBtn = [UIButton hyb_viewWithSuperView:[UIApplication sharedApplication].keyWindow constraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-SMMargin);
        make.height.width.mas_equalTo(60);
        make.bottom.mas_offset(-180);
    }];
    [writeBtn setImage:[UIImage imageNamed:@"community_write"] forState:UIControlStateNormal];
    writeBtn.backgroundColor = [UIColor clearColor];
    self.writeBtn = writeBtn;
    
    UIButton *fatieBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [fatieBtn setImage:[UIImage imageNamed:@"community_icon_write_fatie"] forState:UIControlStateNormal];
    [[UIApplication sharedApplication].keyWindow insertSubview:fatieBtn belowSubview:writeBtn];
    [fatieBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.height.with.equalTo(writeBtn);
    }];
    fatieBtn.backgroundColor = [UIColor clearColor];
    self.fatieBtn = fatieBtn;
    
    UIButton *rijiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rijiBtn setImage:[UIImage imageNamed:@"community_icon_write_riji"] forState:UIControlStateNormal];
    [[UIApplication sharedApplication].keyWindow insertSubview:rijiBtn belowSubview:fatieBtn];
    [rijiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.height.with.equalTo(writeBtn);
    }];
    rijiBtn.backgroundColor = [UIColor clearColor];
    self.rijiBtn = rijiBtn;

    UIView *menuView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, S_Width, S_Height)];
    menuView.backgroundColor = RGBA(0, 0, 0, 0.5);
    [[UIApplication sharedApplication].keyWindow insertSubview:menuView belowSubview:rijiBtn];
    menuView.hidden = YES;
    self.menuView = menuView;
    
    //  按钮点击动画
    SMWeakSelf;
    [menuView hyb_addTapGestureWithCallback:^(UITapGestureRecognizer *sender) {
        weakSelf.menuView.hidden = !self.menuView.hidden;
        if (weakSelf.menuView.hidden) {
            [UIView animateWithDuration:0.5 animations:^{
                fatieBtn.center = writeBtn.center;
                rijiBtn.center = writeBtn.center;
            }];
        }else{
            
            [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveLinear animations:^{
                
                CGFloat angle = M_PI_2 / (2 - 1);
                fatieBtn.center = CGPointMake(writeBtn.sm_centerX - sin(angle * 1) * 50, writeBtn.sm_centerY - cos(angle * 0) * + 70);
                rijiBtn.center = CGPointMake(writeBtn.sm_centerX - sin(angle * 1) * 80, writeBtn.sm_centerY - cos(angle * 1) * + 70);
            } completion:^(BOOL finished) {
                
            }];
        }
    }];
    
    [writeBtn hyb_addTapGestureWithCallback:^(UITapGestureRecognizer *sender) {
    
        weakSelf.menuView.hidden = !self.menuView.hidden;
        
        if (weakSelf.menuView.hidden) {
            
            [UIView animateWithDuration:0.5 animations:^{

                fatieBtn.center = writeBtn.center;
                rijiBtn.center = writeBtn.center;
            }];
        }else{
            
            [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveLinear animations:^{
                
                CGFloat angle = M_PI_2 / (2 - 1);
                fatieBtn.center = CGPointMake(writeBtn.sm_centerX - sin(angle * 1) * 50, writeBtn.sm_centerY - cos(angle * 0) * + 70);
                rijiBtn.center = CGPointMake(writeBtn.sm_centerX - sin(angle * 1) * 80, writeBtn.sm_centerY - cos(angle * 1) * + 70);
            } completion:^(BOOL finished) {
                
            }];
        }
        
    }];
    
    [fatieBtn hyb_addTapGestureWithCallback:^(UITapGestureRecognizer *sender) {
        SMLog(@"点击发帖按钮");
        SMPostingTipsController *ptVc = [[SMPostingTipsController alloc] init];
        [weakSelf.navigationController pushViewController:ptVc animated:YES];
    }];
    [rijiBtn hyb_addTapGestureWithCallback:^(UITapGestureRecognizer *sender) {
        SMLog(@"点击写日记按钮");
    }];
    
}

#pragma mark - UITableView的HeaderView
- (UIView *)setContentView{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, S_Width, 180)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    SMWeakSelf;
    //  人气圈子
    UIButton *renqiBtn = [UIButton hyb_buttonWithTitle:@"人气圈子" superView:headerView constraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headerView.mas_centerX);
        make.top.mas_offset(25);
    } touchUp:^(UIButton *sender) {
        SMLog(@"进入到人气圈子页面");
        // 跳转到圈子列表页
        SMCircleController *cirVc = [[SMCircleController alloc] init];
        [weakSelf.navigationController pushViewController:cirVc animated:YES];
    }];
    [renqiBtn setTitleAndColor];
    [renqiBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:10];
    
    UIView *scrollViewSuperView = [UIView hyb_viewWithSuperView:headerView constraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(headerView);
        make.height.mas_equalTo(130);
    }];
    scrollViewSuperView.backgroundColor = [UIColor whiteColor];
    // 各个圈子的图片
    NSArray *imageArr = [NSArray arrayWithObjects:@"community_yiyuan_a_60", @"community_yiyuan_b_60", @"community_yiyuan_c_60", @"community_yiyuan_d_60", @"community_yiyuan_a_60", @"community_yiyuan_b_60", nil];
    NSArray *titleArr = [NSArray arrayWithObjects:@"苏州医美", @"无锡医美", @"昆明医美", @"运城医美", @"南京医美", @"上海医美", nil];
    
    UIScrollView *scrollViewContent = [UIScrollView hyb_viewWithSuperView:scrollViewSuperView constraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(scrollViewSuperView);
    }];
    scrollViewContent.showsHorizontalScrollIndicator = NO;
    scrollViewContent.contentSize = CGSizeMake(SMMargin * 2 + 45 * (imageArr.count - 1) + imageArr.count * categoryBtnW, 40 + categoryBtnH);
//    scrollViewContent.contentOffset = CGPointMake(S_Width, 0);
    scrollViewContent.pagingEnabled = NO;
    
    // 创建顶部各个圈子的按钮
    for (int i = 0; i < imageArr.count; i++) {
        [self setCategoryButtonWithImage:[UIImage imageNamed:imageArr[i]] title:titleArr[i] supView:scrollViewContent num:i];
    }
    
    // 下面的灰色线
    UIView *lineViewS = [UIView hyb_viewWithSuperView:scrollViewSuperView constraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(scrollViewSuperView);
        make.height.mas_equalTo(0.5);
    }];
    lineViewS.backgroundColor = UIColorFromRGB(0xdddddd);
    
    return headerView;
}

- (void)setCategoryButtonWithImage:(UIImage *)image title:(NSString *)title supView:(UIView *)supView num:(NSInteger)num{
    
    UIButton *btn = [UIButton hyb_buttonWithImage:image superView:supView constraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(SMMargin + num * (sqMargin + categoryBtnW));
        make.width.mas_equalTo(categoryBtnW);
        make.height.mas_equalTo(categoryBtnH);
        make.centerY.equalTo(supView.mas_centerY);
    } touchUp:^(UIButton *sender) {
        if (num == 0) {
            SMLog(@"生活美容圈");
        }else if (num == 1){
            SMLog(@"眼部美容圈");
        }else if (num == 2){
            SMLog(@"地域圈子");
        }else{
            SMLog(@"项目圈子");
        }
    }];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:UIColor333 forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [btn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:15];
    
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0 || section == 1) {
        return 3;
    }
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 53;
    }else if (section == 1){
        return 56;
    }
    return 62;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 2) {
        return 100;
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        self.contentTabGrouped.rowHeight = UITableViewAutomaticDimension;
        self.contentTabGrouped.estimatedRowHeight = 188;
        return self.contentTabGrouped.rowHeight;
    }else if (indexPath.section == 1){
        if (iPhone5) {
            return 320;
        }else if (iPhone6){
            return 360;
        }else{
            return 380;
        }
    }else{
        self.contentTabGrouped.rowHeight = UITableViewAutomaticDimension;
        self.contentTabGrouped.estimatedRowHeight = 144;
        return self.contentTabGrouped.rowHeight;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        SMHomeFourthCell *tieziCell = [tableView dequeueReusableCellWithIdentifier:tieziCellId];
        return tieziCell;
    }else if (indexPath.section == 1){
        SMHomeFifthCell *anliCell = [tableView dequeueReusableCellWithIdentifier:anliCellId];
        return anliCell;
    }
    SMAtWendaCell *wendaCell = [tableView dequeueReusableCellWithIdentifier:wendaCellId];
    return wendaCell;
}

//// cell分割线左对齐
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    [cell setSeparatorInset:UIEdgeInsetsZero];
//    [cell setLayoutMargins:UIEdgeInsetsZero];
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {  // 帖子
        UIView *firstView = [[UIView alloc] init];
        firstView.backgroundColor = [UIColor whiteColor];
        
        UIButton *firstBtn = [UIButton hyb_buttonWithTitle:@"帖子" superView:firstView constraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(firstView.mas_centerX);
            make.top.mas_offset(25);
        } touchUp:^(UIButton *sender) {
            SMLog(@"进入到帖子页面");
            SMCommunityPostController *postVc = [[SMCommunityPostController alloc] init];
            [self.navigationController pushViewController:postVc animated:YES];
        }];
        [firstBtn setTitleAndColor];
        [firstBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:10];
        
        return firstView;
    }else if (section == 1){
        
        UIView *secondView = [[UIView alloc] init];
        secondView.backgroundColor = [UIColor whiteColor];
        
        UIButton *secondBtn = [UIButton hyb_buttonWithTitle:@"日记" superView:secondView constraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(secondView.mas_centerX);
            make.top.mas_offset(30);
        } touchUp:^(UIButton *sender) {
            SMLog(@"进入到案例页面");
        }];
        [secondBtn setTitleAndColor];
        [secondBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:10];
        
        return secondView;
    }
    
    UIView *thirdView = [[UIView alloc] init];
    thirdView.backgroundColor = [UIColor whiteColor];
    UIButton *thirdBtn = [UIButton hyb_buttonWithTitle:@"问答专场" superView:thirdView constraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(thirdView.mas_centerX);
        make.top.mas_offset(30);
    } touchUp:^(UIButton *sender) {
        SMLog(@"进入问答专场页面");
        SMInterrogationController *inVc = [[SMInterrogationController alloc] init];
        [self.navigationController pushViewController:inVc animated:YES];
    }];
    [thirdBtn setTitleAndColor];
    [thirdBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];
    
    return thirdView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 2) {
        UIView *footerView = [[UIView alloc] init];
        footerView.backgroundColor = [UIColor whiteColor];
        
        UIButton *quizBtn = [UIButton hyb_buttonWithTitle:@"提问并邀请更多医生问答" superView:footerView constraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(27);
            make.centerX.equalTo(footerView.mas_centerX);
            make.height.mas_equalTo(22);
        } touchUp:^(UIButton *sender) {
            SMLog(@"进入提问邀请医生回答页面");
        }];
        // 下划线
        NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName : [NSNumber numberWithInteger:NSUnderlineStyleSingle], NSFontAttributeName : [UIFont systemFontOfSize:15], NSForegroundColorAttributeName : UIColor666};
        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:@"提问并邀请更多医生回答" attributes:attribtDic];
        [quizBtn setAttributedTitle:attribtStr forState:UIControlStateNormal];
        
        [quizBtn setImage:[UIImage imageNamed:@"community_wenda"] forState:UIControlStateNormal];
        [quizBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:8];
        
        return footerView;
    }else{
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
