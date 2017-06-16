//
//  SMMyCommunityController.m
//  Shoumian
//
//  Created by 何志志 on 2017/2/4.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMMyCommunityController.h"
#import "SMMcCircleDynamicsCell.h"
#import "SMMcFriendsDynamicCell.h"
#import <SDAutoLayout/UITableView+SDAutoTableViewCellHeight.h>
#import "SMMcFriendsDynamicModel.h"
#import "SMFindFriendsController.h"

@interface SMMyCommunityController ()

@property (nonatomic, strong) NSMutableArray *modelsArray;

@end

@implementation SMMyCommunityController

static NSString * const circleCellId = @"circleCellId";
static NSString * const friendCellId = @"friendCellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.contentTabGrouped];
    [self.contentTabGrouped registerNib:[UINib nibWithNibName:NSStringFromClass([SMMcCircleDynamicsCell class]) bundle:nil] forCellReuseIdentifier:circleCellId];
    [self.contentTabGrouped registerNib:[UINib nibWithNibName:NSStringFromClass([SMMcFriendsDynamicCell class]) bundle:nil] forCellReuseIdentifier:friendCellId];
    self.contentTabGrouped.frame = CGRectMake(0, 0, S_Width, S_Height - 64 - 49 - 44);
    
    [self creatModelsWithCount:9];
    
    // 上面的灰色线
    UIView *lineViewF = [UIView hyb_viewWithSuperView:self.view constraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(0.5);
    }];
    lineViewF.backgroundColor = UIColorFromRGB(0xdddddd);
}

- (void)creatModelsWithCount:(NSInteger)count
{
    if (!_modelsArray) {
        _modelsArray = [NSMutableArray new];
    }
    
    NSArray *iconImageNamesArray = @[@"community_yonghu_j",
                                     @"community_yonghu_cc",
                                     @"community_yonghu_dd"
                                     ];
    NSArray *iconImageNamesArray1 = @[@"community_img_a",
                                     @"community_img_b",
                                     @"community_img_c"
                                     ];
    
    
    NSArray *textArray = @[@"双眼皮手术第九天~感觉被自己亮到了。效果还是挺好哒",
                           @"求问大家这样的皮肤适合怎么美容？试了很多的面膜.....",
                           @"硅胶隆鼻第116天了。现在是越来越好看了，结果比较满意，当然，前一个月是比较痛苦的。"
                           ];
    
    NSArray *nameArr = @[@"苏苏特", @"嘿别说话", @"风吹过纸飞机"];
    
    
    for (int i = 0; i < count; i++) {
        
        int nameRandomIndex = arc4random_uniform(3);
        
        SMMcFriendsDynamicModel *model = [SMMcFriendsDynamicModel new];
        model.contentText = textArray[nameRandomIndex];
        model.iconImagePath = iconImageNamesArray[arc4random_uniform(3)];
        model.name = nameArr[nameRandomIndex];
        model.time = @"9个小时前";
        model.browseNum = @"292";
        model.likeNum = @"3821";
        model.discussNum = @"8273";
        
        // 模拟“有或者无图片”
        int random = arc4random_uniform(1);
        if (random <= 2) {
            NSMutableArray *temp = [NSMutableArray new];
            
            int randomImagesCount = arc4random_uniform(3);
            for (int i = 0; i < randomImagesCount; i++) {
                int randomIndex = arc4random_uniform(3);
                NSString *text = iconImageNamesArray1[randomIndex];
                [temp addObject:text];
            }
            
            model.imagePathsArray = [temp copy];
        }
        
        [self.modelsArray addObject:model];
    }
}



#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 54;
    }else{
        return 46;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 50;
    }else{
        return 150;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        self.contentTabGrouped.rowHeight = UITableViewAutomaticDimension;
        self.contentTabGrouped.estimatedRowHeight = 213;
        return self.contentTabGrouped.rowHeight;
    }else{
        
        SMMcFriendsDynamicModel *friendModel = self.modelsArray[indexPath.row];
        return [self.contentTabGrouped cellHeightForIndexPath:indexPath model:friendModel keyPath:@"friendModel" cellClass:[SMMcFriendsDynamicCell class] contentViewWidth:S_Width];
        
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc] init];
    headView.backgroundColor = [UIColor whiteColor];
    
    if (section == 0) {
        UILabel *lab = [UILabel hyb_labelWithText:@"圈子动态" font:18 superView:headView constraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(25);
            make.centerX.equalTo(headView.mas_centerX);
        }];
        lab.textColor = UIColor333;
    }else{
        UILabel *lab = [UILabel hyb_labelWithText:@"好友动态" font:18 superView:headView constraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(15);
            make.centerX.equalTo(headView.mas_centerX);
        }];
        lab.textColor = UIColor333;
    }
    
    return headView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footView = [[UIView alloc] init];
    footView.backgroundColor = [UIColor whiteColor];
    
    //  加载更多
    UIButton *moreBtn = [UIButton hyb_buttonWithTitle:@"加载更多" superView:footView constraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(15);
        make.centerX.equalTo(footView.mas_centerX);
    } touchUp:^(UIButton *sender) {
        if (section == 0) {
            SMLog(@"加载更多圈子动态");
        }else if (section == 1){
            SMLog(@"加载更多好友动态");
        }
    }];
    [moreBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [moreBtn setTitleColor:UIColor666 forState:UIControlStateNormal];
    
    
    //  发现更多志同道合的好友
    if (section == 1) {
        SMWeakSelf;
        UIButton *footerBtn = [UIButton hyb_buttonWithTitle:@"发现更多志同道合的好友" superView:footView constraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(footView.mas_centerY).offset(20);
            make.centerX.equalTo(footView.mas_centerX);
            make.width.mas_equalTo(220);
            make.height.mas_equalTo(24);
        } touchUp:^(UIButton *sender) {
            SMLog(@"进入更多志同道合的好友界面");
            SMFindFriendsController *ffVc = [[SMFindFriendsController alloc] init];
            [weakSelf.navigationController pushViewController:ffVc animated:YES];
        }];
        [footerBtn setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
        [footerBtn.titleLabel setFont:[UIFont fontWithName:@"System-Medium-Bold" size:15]];
//        [footerBtn setImage:[UIImage imageNamed:@"community_jiantou_footer"] forState:UIControlStateNormal];
//        [footerBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleBottom imageTitleSpace:-30];
        
        UIImageView *imageView = [UIImageView hyb_imageViewWithSuperView:footView constraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(226);
            make.height.mas_equalTo(24);
            make.bottom.equalTo(footerBtn.mas_bottom).offset(10);
            make.centerX.equalTo(footView.mas_centerX).offset(10);
        }];
        imageView.image = [UIImage imageNamed:@"community_jiantou_footer"];
    }
    
    return footView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        SMMcCircleDynamicsCell *circleCell = [tableView dequeueReusableCellWithIdentifier:circleCellId forIndexPath:indexPath];
        return circleCell;
    }else{
        SMMcFriendsDynamicCell *friendCell = [tableView dequeueReusableCellWithIdentifier:friendCellId forIndexPath:indexPath];
        friendCell.friendModel = self.modelsArray[indexPath.row];
        return friendCell;
    }
}

@end
