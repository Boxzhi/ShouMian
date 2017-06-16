//
//  SMPersonalHomepageController.m
//  Shoumian
//
//  Created by 何志志 on 2017/3/15.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMPersonalHomepageController.h"
#import "SMPersonalHomepageHeaderView.h"
#import "SMPersonalHomepagePostCell.h"
#import "SMPersonalHomepageModel.h"
#import <SDAutoLayout/UITableView+SDAutoTableViewCellHeight.h>
#import "HZZBottomView.h"
#import "SMPersonalHomepageDiaryCell.h"
#import "SMCircleCell.h"
#import "SMMyFansController.h"


@interface SMPersonalHomepageController ()

//  记录选中的是哪个分类
@property (nonatomic, assign) NSInteger subViewIndex;

@property (nonatomic, strong) NSMutableArray *modelsArray;

//  记录headView每个分类的tableView偏移量
@property (nonatomic, assign) CGFloat yFirst;
@property (nonatomic, assign) CGFloat ySecond;
@property (nonatomic, assign) CGFloat yThird;

@end

@implementation SMPersonalHomepageController

static NSString * const phPostCellId = @"phPostCellId";
static NSString * const phDiaryCellId = @"phDiaryCellId";
static NSString * const phCircleCellId = @"phCircleCellId";

#define HeaderViewHeight 200

- (NSMutableArray *)modelsArray{
    if (!_modelsArray) {
        _modelsArray = [NSMutableArray array];
    }
    return _modelsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的主页";
    self.subViewIndex = 0;
    self.yFirst = self.ySecond = self.yThird = 0;
    [self.view addSubview:self.contentTabPlain];
    self.contentTabPlain.backgroundColor = [UIColor whiteColor];
    [self.contentTabPlain registerNib:[UINib nibWithNibName:NSStringFromClass([SMPersonalHomepagePostCell class]) bundle:nil] forCellReuseIdentifier:phPostCellId];
    [self.contentTabPlain registerNib:[UINib nibWithNibName:NSStringFromClass([SMPersonalHomepageDiaryCell class]) bundle:nil] forCellReuseIdentifier:phDiaryCellId];
    [self.contentTabPlain registerNib:[UINib nibWithNibName:NSStringFromClass([SMCircleCell class]) bundle:nil] forCellReuseIdentifier:phCircleCellId];
    
    [self setTableViewHeaderView];
    [self setBottomView];
    
    [self setModel];
}

- (void)setModel{

    NSArray *timeArr = @[@"9月27日",
                         @"10月1日",
                         @"10月10日",
                         @"12月23日"
                         ];
    NSArray *titleArr = @[@"脂肪填充变寿星？哈哈你得避开这些坑！~~~~~",
                          @"脂肪填充变寿星？哈哈你得避开这些坑！",
                          @"传说隆胸不能剧烈运动？可女星真人秀照样跑。",
                          @"都说不看外在看内在，真的不看么？"
                          ];
    for (int i = 0; i < 4; i++) {
        SMPersonalHomepageModel *model = [SMPersonalHomepageModel new];
        
        model.headImageStr = @"my_img_user_b_30";
        model.nameStr = @"小美";
        model.timeStr = timeArr[i];

        if (i == 1) {
            model.contentImageStr = @"my_img_tiezi";
        }else if (i == 2) {
            model.contentImageStr = @"my_img";
        }
        model.titleStr = titleArr[i];
        model.contextStr = @"宝宝们有没有觉得有时候全天下都和咱们过不去。没事反手摸肚脐、锁骨放硬币、A4腰，最近胸小的宝宝们又狠狠的躺枪。";
        model.browseNum = @"2431";
        model.likeNum = @"142";
        model.commentNum = @"7384";
        
        [self.modelsArray addObject:model];
        
        
    }
}

- (void)setTableViewHeaderView{
    SMPersonalHomepageHeaderView *phHeaderView = [SMPersonalHomepageHeaderView viewFromXib];
    phHeaderView.frame = CGRectMake(0, 0, S_Width, HeaderViewHeight);
    self.contentTabPlain.tableHeaderView = phHeaderView;
    SMWeakSelf;
    phHeaderView.fansLabClick = ^{
        SMMyFansController *mfVc = [[SMMyFansController alloc] init];
        [weakSelf.navigationController pushViewController:mfVc animated:YES];
    };
    phHeaderView.followLabClick = ^{
        
    };
}

- (void)setBottomView{
    
    HZZBottomView *bottomView = [[HZZBottomView alloc] initWithRect:CGRectMake(0, S_Height - SMBottomHeight - SMNavHeight, S_Width, SMBottomHeight) titles:[NSArray arrayWithObject:@"发帖"] images:[NSArray arrayWithObject:@"my_fatie"] colors:[NSArray arrayWithObject:@"ff5050"] tagBase:10030];
    bottomView.hZZBottomClickBlock = ^(NSInteger index){
        
    };
    [self.view addSubview:bottomView];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;{
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = [UIColor whiteColor];
    return footerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelsArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_subViewIndex == 0) {
        
        SMPersonalHomepageModel *model = self.modelsArray[indexPath.row];
        return [self.contentTabPlain cellHeightForIndexPath:indexPath model:model keyPath:@"postModel" cellClass:[SMPersonalHomepagePostCell class] contentViewWidth:S_Width];
    }else if (_subViewIndex == 1){
        //  cell中的图片宽高比是11：12   (S_Width - 45) / 2 / (11 / 12)   45是两张图片左中右的间距15的总和  180是cell总高度-图片高度得出
        return (S_Width - 45) * 12 / 22 + 180;
    }else{
        return 200;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor whiteColor];
    NSInteger subViewCount = 3;
    SMWeakSelf;
    for (int i = 0; i < subViewCount; i++) {
        
        UIView *subView = [UIView hyb_viewWithSuperView:headerView constraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(headerView);
            make.left.mas_offset(S_Width / subViewCount * i);
            make.width.mas_equalTo(S_Width / subViewCount);
        } onTaped:^(UITapGestureRecognizer *sender) {
            
            //  点击帖子、日记、圈子
            _subViewIndex = i;
            if (weakSelf.contentTabPlain.contentOffset.y >= HeaderViewHeight) {
                switch (_subViewIndex) {
                    case 0:
                    {
                        if (_yFirst < HeaderViewHeight) {
                            self.contentTabPlain.contentOffset = CGPointMake(0, HeaderViewHeight);
                        }else{
                            self.contentTabPlain.contentOffset = CGPointMake(0, self.yFirst);
                        }
                        break;
                    }
                    case 1:
                    {
                        if (_ySecond < HeaderViewHeight) {
                            self.contentTabPlain.contentOffset = CGPointMake(0, HeaderViewHeight);
                        }else{
                            self.contentTabPlain.contentOffset = CGPointMake(0, self.ySecond);
                        }
                        break;
                    }
                    case 2:
                    {
                        if (_yThird < HeaderViewHeight) {
                            self.contentTabPlain.contentOffset = CGPointMake(0, HeaderViewHeight);
                        }else{
                            self.contentTabPlain.contentOffset = CGPointMake(0, self.yThird);
                        }
                        break;
                    }
                        
                    default:
                        break;
                }
            }
            [weakSelf.contentTabPlain reloadData];
        }];
        subView.backgroundColor = [UIColor whiteColor];
        
        //  帖子  日记   圈子
        UILabel *lab = [UILabel hyb_viewWithSuperView:subView constraints:^(MASConstraintMaker *make) {
            make.center.equalTo(subView);
        }];
        // 文字下面的红色下划线
        UIView *redLineView = [UIView hyb_viewWithSuperView:subView constraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(63);
            make.height.mas_equalTo(3);
            make.centerX.equalTo(subView.mas_centerX);
            make.bottom.equalTo(subView.mas_bottom);
        }];
        redLineView.backgroundColor = UIColorRed;
        NSString *leftStr;
        NSString *rightStr;
        switch (i) {
            case 0:
                leftStr = @"帖子";
                rightStr = @"16";
                break;
            case 1:
                leftStr = @"日记";
                rightStr = @"20";
                break;
            case 2:
                leftStr = @"圈子";
                rightStr = @"52";
                break;
                
            default:
                break;
        }
        UIColor *textColor;
        if (i == _subViewIndex) {
            textColor = UIColorRed;
            redLineView.hidden = NO;
        }else{
            textColor = UIColor333;
            redLineView.hidden = YES;
        }
        
        lab.attributedText = [NSString personalHomepageAttributStringWithClassifyStr:leftStr leftColor:textColor numberStr:rightStr rightColor:textColor];
    }
    
    UIView *lineView = [UIView hyb_addBottomLineToView:headerView height:SMLineViewHeight color:LineViewBackgroundColor];
    
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_subViewIndex == 0) {
        
        SMPersonalHomepagePostCell *postCell = [tableView dequeueReusableCellWithIdentifier:phPostCellId forIndexPath:indexPath];
        postCell.postModel = self.modelsArray[indexPath.row];
        return postCell;
    }else if (_subViewIndex == 1){
        
        SMPersonalHomepageDiaryCell *diaryCell = [tableView dequeueReusableCellWithIdentifier:phDiaryCellId forIndexPath:indexPath];
        return diaryCell;
    }else{
        SMCircleCell *circleCell = [tableView dequeueReusableCellWithIdentifier:phCircleCellId forIndexPath:indexPath];
        return circleCell;
    }
};

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    SMLog(@"%f", scrollView.contentOffset.y);
    switch (_subViewIndex) {
        case 0:
            self.yFirst = scrollView.contentOffset.y;
            break;
        case 1:
            self.ySecond = scrollView.contentOffset.y;
            break;
        case 2:
            self.yThird = scrollView.contentOffset.y;
            break;
            
        default:
            break;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
