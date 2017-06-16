//
//  SMPayOrderViewController.m
//  Shoumian
//
//  Created by 何志志 on 2017/3/11.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMPayOrderViewController.h"

@interface SMPayOrderViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, assign) BOOL isCanSideBack;

@end

@implementation SMPayOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"支付订单";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.hidesBackButton = YES;
    
    [self setContentView];
}
/**
 *  禁止当前页边缘返回
 */
- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    self.isCanSideBack = NO;
    //关闭ios右滑返回
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        
        self.navigationController.interactivePopGestureRecognizer.delegate=self;
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer*)gestureRecognizer {
    
    return self.isCanSideBack;
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    [self resetSideBack];
}
/**
 *  恢复边缘返回
 */
- (void)resetSideBack {
    self.isCanSideBack=YES;
    //开启ios右滑返回
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}

- (void)setContentView{
    UIImageView *imageView = [UIImageView hyb_imageViewWithImage:@"mall_icon_success" superView:self.view constraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(45);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.height.mas_equalTo(70);
    }];
    
    UILabel *successLab = [UILabel hyb_labelWithText:@"支付成功" font:20 superView:self.view constraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom).offset(13);
        make.centerX.equalTo(imageView.mas_centerX);
    }];
    successLab.textColor = UIColorRed;
    
    UILabel *checkOrderLab = [UILabel hyb_labelWithFont:15 superView:self.view constraints:^(MASConstraintMaker *make) {
        make.top.equalTo(successLab.mas_bottom).offset(30);
        make.centerX.equalTo(imageView.mas_centerX);
    }];
    checkOrderLab.textColor = UIColor666;
    checkOrderLab.attributedText = [NSString addNSUnderlineStyleAttributeName:@"查看我的订单"];
    
    UILabel *startBookingLab = [UILabel hyb_labelWithFont:15 superView:self.view constraints:^(MASConstraintMaker *make) {
        make.top.equalTo(checkOrderLab.mas_bottom).offset(20);
        make.centerX.equalTo(imageView.mas_centerX);
    }];
    startBookingLab.textColor = UIColor666;
    startBookingLab.attributedText = [NSString addNSUnderlineStyleAttributeName:@"开始预约"];
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
