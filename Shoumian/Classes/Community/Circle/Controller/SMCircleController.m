//
//  SMCircleController.m
//  Shoumian
//
//  Created by 何志志 on 2017/2/23.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMCircleController.h"
#import "SMCircleCell.h"

@interface SMCircleController ()

@end

@implementation SMCircleController

static NSString * const cirCellId = @"cirCellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"圈子";
    
    [self.view addSubview:self.contentTabPlain];
    [self.contentTabPlain registerNib:[UINib nibWithNibName:NSStringFromClass([SMCircleCell class]) bundle:nil] forCellReuseIdentifier:cirCellId];

}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 125;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    NSArray *imageArr = [NSArray arrayWithObjects:@"community_quanzi_a", @"community_quanzi_b", @"community_quanzi_c", @"community_quanzi_d", nil];
    CGFloat btnW = 162;
    CGFloat btnH = 90;
    CGFloat margin = 12;
    
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UIView *lineView = [UIView hyb_addBottomLineToView:headerView height:0.5 color:LineViewBackgroundColor];
    
    UIScrollView *scrollView = [UIScrollView hyb_viewWithSuperView:headerView constraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(headerView);
        make.bottom.equalTo(lineView.mas_top);
    }];
    scrollView.contentSize = CGSizeMake(SMMargin * 2 + imageArr.count * btnW + (imageArr.count - 1) * margin, 0);
    scrollView.pagingEnabled = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    
    for (int i = 0; i < imageArr.count; i++) {
        UIButton *btn = [UIButton hyb_buttonWithSuperView:scrollView constraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(scrollView.mas_centerY);
            make.width.mas_equalTo(btnW);
            make.height.mas_equalTo(btnH);
            make.left.mas_offset(SMMargin + i * (margin + btnW));
        } touchUp:^(UIButton *sender) {
            SMLog(@"更换圈子内容");
        }];
        [btn setImage:[UIImage imageNamed:imageArr[i]] forState:UIControlStateNormal];
    }
    
    
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SMCircleCell *cirCell = [tableView dequeueReusableCellWithIdentifier:cirCellId forIndexPath:indexPath];
    return cirCell;
}

@end
