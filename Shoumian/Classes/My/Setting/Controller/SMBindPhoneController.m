//
//  SMBindPhoneController.m
//  Shoumian
//
//  Created by 何志志 on 2017/3/13.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMBindPhoneController.h"
#import "SMBindPhoneFirstView.h"
#import "SMBindPhoneSecondView.h"

@interface SMBindPhoneController ()

@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadConstraint;

//@property (nonatomic, assign) BOOL isCanSideBack;

@end

@implementation SMBindPhoneController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"修改绑定手机";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setContentView];
}

- (void)setContentView{
    
    self.contentView.backgroundColor = [UIColor clearColor];
    SMBindPhoneFirstView *firstView = [SMBindPhoneFirstView viewFromXib];
    [self.contentView addSubview:firstView];
    SMBindPhoneSecondView *secondView = [SMBindPhoneSecondView viewFromXib];
    [self.contentView addSubview:secondView];
    
    firstView.getVerificationButtonClick = ^{
        
    };
    //  下一步
    firstView.nextStepButtonClick = ^(NSString *text){
        [UIView animateWithDuration:1.0f animations:^{
            _leadConstraint.constant = -S_Width;
            SMBindPhoneFirstView *firstView = self.contentView.subviews[0];
            firstView.hidden = YES;
        }];
    };
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    SMBindPhoneFirstView *firstView = self.contentView.subviews[0];
    firstView.frame = CGRectMake(0, 0, self.contentView.sm_width * 0.5, self.contentView.sm_height);
    
    SMBindPhoneSecondView *secondView = self.contentView.subviews[1];
    secondView.frame = CGRectMake(self.contentView.sm_width * 0.5, 0, self.contentView.sm_width * 0.5, self.contentView.sm_height);
}


///**
// *  禁止当前页边缘返回
// */
//- (void)viewDidAppear:(BOOL)animated {
//    
//    [super viewDidAppear:animated];
//    self.isCanSideBack = NO;
//    //关闭ios右滑返回
//    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        
//        self.navigationController.interactivePopGestureRecognizer.delegate=self;
//    }
//}
//
//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer*)gestureRecognizer {
//    
//    return self.isCanSideBack;
//}
//
//- (void)viewDidDisappear:(BOOL)animated {
//    
//    [super viewDidDisappear:animated];
//    [self resetSideBack];
//}
///**
// *  恢复边缘返回
// */
//- (void)resetSideBack {
//    self.isCanSideBack=YES;
//    //开启ios右滑返回
//    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
//    }
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
