//
//  SMCommunityPostController.m
//  Shoumian
//
//  Created by 何志志 on 2017/2/23.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMCommunityPostController.h"
#import "SMCommunityPostCell.h"
#import "HZZBottomView.h"
#import "SMPostingTipsController.h"


@interface SMCommunityPostController ()

@property(nonatomic, strong) HZZClassifyMenuView *menuView;

@end

@implementation SMCommunityPostController

static NSString * const postCellId = @"postCellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"帖子列表";
    [self setupHeadView];
    
    [self.view addSubview:self.contentTabPlain];
    self.contentTabPlain.frame = CGRectMake(0, 45, S_Width, S_Height - 64 - 45);
    [self.contentTabPlain registerNib:[UINib nibWithNibName:NSStringFromClass([SMCommunityPostCell class]) bundle:nil] forCellReuseIdentifier:postCellId];
    self.contentTabPlain.rowHeight = UITableViewAutomaticDimension;
    self.contentTabPlain.estimatedRowHeight = 212;
    
    [self setupBottomButton];
}

- (void)setupHeadView{
    
    NSArray *titleArr = [NSArray arrayWithObjects:@"全部", @"排序", nil];
    self.menuView = [[HZZClassifyMenuView alloc] initWithRect:CGRectMake(0, 0, S_Width, 45) buttonTitles:titleArr titleColor:UIColor666 image:[UIImage imageNamed:@"home_xiala"] clickBlock:^(int index, HZZButton *btn) {
        
    }];
    self.menuView.hzzButtonClickBlock = ^(int index, HZZButton *btn){
        NSLog(@"%d", index);
        btn.titleStr = @"点赞数最多";
    };
    [self.view addSubview:self.menuView];
}

- (void)setupBottomButton{
    NSArray *titleArr = [NSArray arrayWithObject:@"发帖"];
    NSArray *imageArr = [NSArray arrayWithObject:@"community_fatie"];
    NSArray *colorArr = [NSArray arrayWithObject:@"ff5050"];
    HZZBottomView *bottomView = [[HZZBottomView alloc] initWithRect:CGRectMake(0, S_Height - 64 - SMBottomHeight, S_Width, SMBottomHeight) titles:titleArr images:imageArr colors:colorArr tagBase:10000];
    SMWeakSelf;
    bottomView.hZZBottomClickBlock = ^(NSInteger index){
        SMLog(@"%ld", index);
        // 跳转到发帖提示页面
        SMPostingTipsController *ptVc = [[SMPostingTipsController alloc] init];
        [weakSelf.navigationController pushViewController:ptVc animated:YES];
    };
    [self.view addSubview:bottomView];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return SMBottomHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = ViewBackgroundColor;
    return footerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SMCommunityPostCell *postCell = [tableView dequeueReusableCellWithIdentifier:postCellId forIndexPath:indexPath];
    return postCell;
}

@end
