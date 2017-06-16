//
//  SMBaseViewController.m
//  Shoumian
//
//  Created by 何志志 on 2017/1/20.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMBaseViewController.h"
#import "SMMyOrderController.h"
#import "SMOrderDetailsController.h"

@interface SMBaseViewController ()<UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate>

@end

@implementation SMBaseViewController

- (UITableView *)contentTabGrouped{
    if (!_contentTabGrouped) {
        _contentTabGrouped = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64) style:UITableViewStyleGrouped];
        _contentTabGrouped.delegate = self;
        _contentTabGrouped.dataSource = self;
        _contentTabGrouped.backgroundColor = ViewBackgroundColor;
//        _contentTabGrouped.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);
        _contentTabGrouped.translatesAutoresizingMaskIntoConstraints = NO;
        _contentTabGrouped.separatorStyle = UITableViewCellSeparatorStyleNone;

    }
    return _contentTabGrouped;
}

- (UITableView *)contentTabPlain{
    if (!_contentTabPlain) {
        _contentTabPlain = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64) style:UITableViewStylePlain];
        _contentTabPlain.delegate = self;
        _contentTabPlain.dataSource = self;
//        _contentTabPlain.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);
        _contentTabPlain.backgroundColor = ViewBackgroundColor;
        _contentTabPlain.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _contentTabPlain;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

//    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = ViewBackgroundColor;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.delegate = self;
}

#pragma mark - UITableViewDelegate
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSectisection;
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    //设置cell的显示动画为3D缩放
//    //xy方向缩放的初始值为0.1
//    cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
//    
//    //设置动画时间为0.25秒,xy方向缩放的最终值为1
//    [UIView animateWithDuration:0.25 animations:^{
//        
//        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
//        
//    }completion:^(BOOL finish){
//        
//    }];
    
    
    
    
//    CATransform3D rotation;
//    rotation = CATransform3DMakeRotation((90.0 * M_PI) / 180, 0.0, 0.7, 0.4);
//    rotation.m34 = 1.0 / -600;
//    
//    cell.layer.shadowColor = [[UIColor blackColor] CGColor];
//    cell.layer.shadowOffset = CGSizeMake(10, 10);
//    cell.alpha = 0;
//    cell.layer.transform = rotation;
//    cell.layer.anchorPoint = CGPointMake(0, 0.5);
//    
//    
//    [UIView beginAnimations: @"rotation"context:NULL];
//    [UIView setAnimationDuration:0.8];
//    cell.layer.transform = CATransform3DIdentity;
//    cell.alpha = 1;
//    cell.layer.shadowOffset = CGSizeMake(0, 0);
//    [UIView commitAnimations];
    
//}



////去掉UItableview headerview黏性  ，table滑动到最上端时，header view消失掉。
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if (scrollView == _contentTab)
//    {
//        CGFloat sectionHeaderHeight = 57;
//        if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0) {
//            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//        } else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
//            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//        }
//    }
//}


//#pragma mark - UINavigationControllerDelegate  隐藏当前页面的导航栏
//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    BOOL isShowNavbar = [viewController isKindOfClass:[self class]];
//    [self.navigationController setNavigationBarHidden:isShowNavbar animated:YES];
//}


#pragma mark -- 设置需要隐藏的控制器
#pragma mark Whether need Navigation Bar Hidden
//- (BOOL) needHiddenBarInViewController:(UIViewController *)viewController {
//    
//    BOOL needHideNaivgaionBar = NO;
//    
//    if ([viewController isKindOfClass: [SMMyOrderController class]] ||
//        [viewController isKindOfClass: [SMOrderDetailsController class]]) {
//        needHideNaivgaionBar = YES;
//    }
//    
//    return needHideNaivgaionBar;
//}

#pragma mark - UINaivgationController Delegate
#pragma mark -
#pragma mark Will Show ViewController
//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    
//    [self.navigationController setNavigationBarHidden: [self needHiddenBarInViewController: viewController]
//                                             animated: animated];
//}



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
//        self.navigationController.interactivePopGestureRecognizer.delegate = self;
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
