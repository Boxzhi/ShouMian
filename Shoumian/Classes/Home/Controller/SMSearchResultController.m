//
//  SMSearchResultController.m
//  Shoumian
//
//  Created by 何志志 on 2017/2/18.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMSearchResultController.h"

@interface SMSearchResultController ()<UISearchBarDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;

@end

@implementation SMSearchResultController

- (UISearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] init];
        _searchBar.barTintColor = [UIColor whiteColor];
        _searchBar.placeholder = @"搜索关键字";
        _searchBar.translucent = NO;
        _searchBar.delegate = self;
        _searchBar.showsCancelButton = NO;
        _searchBar.searchBarStyle = UISearchBarStyleMinimal;
    }
    return _searchBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self.view addSubview:self.contentTabGrouped];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem createItemWithImage:nil highImage:nil target:self action:@selector(cancelBtnClick) title:@"取消"];
    self.navigationItem.titleView = self.searchBar;
}

- (void)cancelBtnClick{
    [self dismissViewControllerAnimated:YES completion:nil];
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
