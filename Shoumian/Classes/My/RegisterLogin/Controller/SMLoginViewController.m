//
//  SMLoginViewController.m
//  Shoumian
//
//  Created by 何志志 on 2017/3/17.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMLoginViewController.h"
#import "SMNavigationController.h"
#import "SMRegisterViewController.h"
#import "SMLoginPhoneNumView.h"
#import "SMLoginAccountNumView.h"

@interface SMLoginViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *btnSupView;
@property (weak, nonatomic) IBOutlet UIButton *phoneNumberBtn;
@property (weak, nonatomic) IBOutlet UIButton *accountNumberBtn;
@property (weak, nonatomic) IBOutlet UIView *progressView;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIScrollView *contentScrollView;
@property (nonatomic, strong) NSMutableArray *titleSizeArr;

@end

@implementation SMLoginViewController

- (NSMutableArray *)titleSizeArr{
    if (!_titleSizeArr) {
        _titleSizeArr = [NSMutableArray array];
    }
    return _titleSizeArr;
}

- (UIView *)line{
    if (!_line) {
        _line = [UIView hyb_viewWithSuperView:self.progressView constraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.phoneNumberBtn.mas_centerX);
            make.width.mas_equalTo(self.titleSizeArr[0]);
            make.top.bottom.equalTo(self.progressView);
        }];
        _line.backgroundColor = UIColorRed;
    }
    return _line;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"登录";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWithImage:[UIImage imageNamed:@"home_back"] highImage:nil target:self action:@selector(dismissVc) title:nil];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem createItemWithImage:nil highImage:nil target:self action:@selector(gotoRegisterVc) title:@"注册"];
    
    self.phoneNumberBtn.selected = YES;
    
    //  算出两个按钮的titleLabel宽度
    NSArray *titleData = @[self.phoneNumberBtn.titleLabel.text, self.accountNumberBtn.titleLabel.text];
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:16]};
    for (int i = 0; i < 2; i++) {
        CGSize titleSize = [titleData[i] sizeWithAttributes:attrs];
        [self.titleSizeArr addObject:[NSNumber numberWithFloat:titleSize.width]];
    }
    
    [self setUI];
}

#pragma mark -- contentView的UI布局
- (void)setUI{
    [self.progressView addSubview:self.line];
    CGFloat contentScrH = 300;
    UIScrollView *contentScrollView = [UIScrollView hyb_scrollViewWithDelegate:self superView:self.view constraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(60);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(contentScrH);
    }];
    contentScrollView.delegate = self;
    contentScrollView.backgroundColor = [UIColor whiteColor];
    contentScrollView.showsVerticalScrollIndicator = NO;
    contentScrollView.showsHorizontalScrollIndicator = NO;
    contentScrollView.userInteractionEnabled = YES;
    contentScrollView.bounces = NO;   // 是否有弹簧效果
    contentScrollView.scrollEnabled = YES;
    contentScrollView.contentSize = CGSizeMake(S_Width * 2, contentScrH);
    self.contentScrollView = contentScrollView;
    
    //  手机号登录
    SMLoginPhoneNumView *phoneNumView = [SMLoginPhoneNumView viewFromXib];
    phoneNumView.frame = CGRectMake(0, 0, contentScrollView.sm_width, contentScrH);
    [contentScrollView addSubview:phoneNumView];

    
    //  账号密码登录
    SMLoginAccountNumView *accountNumView = [SMLoginAccountNumView viewFromXib];
    accountNumView.frame = CGRectMake(S_Width, 0, contentScrollView.sm_width, contentScrH);
    [contentScrollView addSubview:accountNumView];
}

#pragma mark - 手机号快捷登录
- (IBAction)phoneNumberBtn:(id)sender {
    self.phoneNumberBtn.selected = YES;
    self.accountNumberBtn.selected = !self.phoneNumberBtn.selected;
    [self setProgressViewSizeWithIndex:0];
    [self.contentScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

#pragma mark - 账号密码登录
- (IBAction)accountNumberBtn:(id)sender {
    self.accountNumberBtn.selected = YES;
    self.phoneNumberBtn.selected = !self.accountNumberBtn.selected;
    [self setProgressViewSizeWithIndex:1];
    [self.contentScrollView setContentOffset:CGPointMake(S_Width, 0) animated:YES];
}

#pragma mark -- 调整progressView的frame
- (void)setProgressViewSizeWithIndex:(NSInteger)index{
    
    CGRect lineTemp = self.line.frame;
    lineTemp.size.width = [self.titleSizeArr[index] floatValue];
    CGFloat centerX;
    if (index == 0) {
        centerX = self.phoneNumberBtn.center.x;
    }else if (index == 1){
        centerX = self.accountNumberBtn.center.x;
    }
    [UIView animateWithDuration:0.2 animations:^{
        self.line.frame = lineTemp;
        self.line.center = CGPointMake(centerX, self.line.center.y);
    }];
}

#pragma mark -- UIScrollViewDelegate
//  滚动时调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    SMLog(@"%f", scrollView.contentOffset.x);
}
// 停止滚动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x > 0) {
        self.accountNumberBtn.selected = YES;
        self.phoneNumberBtn.selected = !self.accountNumberBtn.selected;
        [self setProgressViewSizeWithIndex:1];
    }else{
        self.phoneNumberBtn.selected = YES;
        self.accountNumberBtn.selected = !self.phoneNumberBtn.selected;
        [self setProgressViewSizeWithIndex:0];
    }
}

#pragma mark - 退出当前界面
- (void)dismissVc{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 跳转到注册界面
- (void)gotoRegisterVc{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [SMKeyWindow.rootViewController presentViewController:[[SMNavigationController alloc] initWithRootViewController:[[SMRegisterViewController alloc] init]] animated:YES completion:nil];
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
