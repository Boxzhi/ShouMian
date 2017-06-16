//
//  SMSearchController.m
//  Shoumian
//
//  Created by 何志志 on 2017/2/18.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMSearchController.h"
#import "YZTagList.h"
#import "SMSearchCell.h"
#import "SMSearchCollectionViewCell.h"
#import "SMSearchHisModel.h"
#import "SMSearchResultController.h"

@interface SMSearchController ()<UISearchBarDelegate, UICollectionViewDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) NSMutableArray *searchHistories; // 保存搜索历史记录
@property (nonatomic, assign) BOOL isHistoryRecord;  // 是否有搜索历史记录
/** 搜索历史缓存保存路径, 默认为SMSEARCH_SEARCH_HISTORY_CACHE_PATH(SMSearchConst.h文件中的宏定义) */
@property (nonatomic, copy) NSString *searchHistoriesCachePath;
/** 搜索历史记录缓存数量，默认为9 */
@property (nonatomic, assign) NSUInteger searchHistoriesCount;
@property (nonatomic, strong) SMSearchHisModel *hisModel;  // 历史记录模型
@property (nonatomic, strong) NSMutableArray *hotArr;   // 热搜词数组
@end

@implementation SMSearchController

static NSString * const histCellId = @"histCellId";
static NSString * const hotCellId = @"hotCellId";

- (NSMutableArray *)searchHistories{
    if (!_searchHistories) {  //  取出历史记录
        _searchHistories = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:self.searchHistoriesCachePath]];
    }
    return _searchHistories;
}

- (UISearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] init];
//        _searchBar.barTintColor = [UIColor whiteColor];
        _searchBar.tintColor = [UIColor blueColor];
        _searchBar.placeholder = @"搜索关键字";
        _searchBar.translucent = NO;
        _searchBar.delegate = self;
        _searchBar.showsCancelButton = NO;
        _searchBar.searchBarStyle = UISearchBarStyleMinimal;
    }
    return _searchBar;
}

- (NSMutableArray *)hotArr{
    if (!_hotArr) {
        _hotArr = [NSMutableArray array];
    }
    return _hotArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem createItemWithImage:nil highImage:nil target:self action:@selector(cancelBtnClick) title:@"取消"];
    self.navigationItem.titleView = self.searchBar;
    
    self.searchHistoriesCachePath = SMSEARCH_SEARCH_HISTORY_CACHE_PATH;
    self.searchHistoriesCount = 9;
    [self.view addSubview:self.contentTabGrouped];
    [self.contentTabGrouped registerNib:[UINib nibWithNibName:NSStringFromClass([SMSearchCell class]) bundle:nil] forCellReuseIdentifier:histCellId];
    [self.contentTabGrouped registerNib:[UINib nibWithNibName:NSStringFromClass([SMSearchCell class]) bundle:nil] forCellReuseIdentifier:hotCellId];
    
    SMSearchHisModel *hisModel = [[SMSearchHisModel alloc] init];
    _hisModel = hisModel;
    
    self.hotArr = [NSMutableArray arrayWithObjects:@"水光针", @"瘦脸", @"美白", @"眼部整形", @"瓷娃娃", @"隆鼻", @"玻尿酸",  nil];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (self.searchHistories.count > 0) {  // 有历史记录
        self.isHistoryRecord = YES;
        _hisModel.hisData = self.searchHistories;
        
    }else{
        self.isHistoryRecord = NO;
    }
    _hisModel.hotData = self.hotArr;
    [self.contentTabGrouped reloadData];
    [_searchBar becomeFirstResponder];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_isHistoryRecord) {
        
        return 2;
    }else{
        
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && _isHistoryRecord == YES) { // 历史搜索

        return _hisModel.hisCellH;
    }else{  // 热门搜索
        return _hisModel.hotCellH;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc] init];
    headView.backgroundColor = [UIColor whiteColor];
    
    UILabel *headLab = [UILabel hyb_labelWithFont:16 superView:headView constraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(12.5);
        make.centerY.equalTo(headView.mas_centerY);
    }];
    headLab.textColor = UIColor333;
    
    
    if (section == 0 && _isHistoryRecord == YES) {  // 历史搜索的HeaderView
        headLab.text = @"历史搜索";
        SMWeakSelf;
        UIButton *btn = [UIButton hyb_buttonWithSuperView:headView constraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-12.5);
            make.centerY.equalTo(headView.mas_centerY);
            make.height.mas_equalTo(17);
        } touchUp:^(UIButton *sender) {
            SMLog(@"清空历史搜索");
            // 移除所有历史搜索
            [weakSelf.searchHistories removeAllObjects];
            // 移除数据缓存
            [NSKeyedArchiver archiveRootObject:self.searchHistories toFile:self.searchHistoriesCachePath];
            weakSelf.isHistoryRecord = NO;
            _hisModel.hisData = weakSelf.searchHistories;
            [weakSelf.contentTabGrouped reloadData];
        }];
        [btn setTitle:@"清空" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"home_lajixiang"] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [btn setTitleColor:UIColor999 forState:UIControlStateNormal];
        
    }else{  //  热门搜索的HeaderView
        headLab.text = @"热门搜索";
        UILabel *updateLab = [UILabel hyb_labelWithFont:14 superView:headView constraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-12.5);
            make.centerY.equalTo(headLab.mas_centerY);
        }];
        updateLab.textColor = UIColor999;
        // 下划线
        NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:@"换一批" attributes:attribtDic];
        updateLab.attributedText = attribtStr;
        
        SMWeakSelf;
        [updateLab hyb_addTapGestureWithCallback:^(UITapGestureRecognizer *sender) {
            SMLog(@"点击换一批");
            [_hotArr removeAllObjects];
            [_hisModel.hotData removeAllObjects];
            _hotArr = [NSMutableArray arrayWithObjects:@"热搜一", @"热搜二", @"热搜三", @"热搜四", @"热搜五", @"热搜六", @"热搜七", @"热搜八", @"热搜九", @"热搜十", @"热搜十一", @"热搜十二", @"热搜十三", @"热搜十四", @"热搜十五", nil];
            _hisModel.hotData = _hotArr;
            [weakSelf.contentTabGrouped reloadData];
        }];
    }
    
    return headView;
    
}

#pragma mark - Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && _isHistoryRecord == YES) {
        
        SMSearchCell *hisCell = [tableView dequeueReusableCellWithIdentifier:histCellId forIndexPath:indexPath];
        hisCell.collectionView.delegate = self;
        hisCell.dataArr = self.searchHistories;
        return hisCell;
    }else{
        SMSearchCell *hotCell = [tableView dequeueReusableCellWithIdentifier:hotCellId forIndexPath:indexPath];
        hotCell.collectionView.delegate = self;
        hotCell.dataArr = self.hotArr;
        return hotCell;
        
    }
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SMSearchCollectionViewCell *cell = (SMSearchCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    NSString *tagStr = cell.tagLabel.text;
    
    [self setSaveSearchHisWithText:tagStr];
    
    SMLog(@"%@", tagStr);
}

#pragma mark - UISearchBarDelegate
//  将要开始编辑时的回调，返回为NO，则不能编辑
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    return YES;
}

// 已经开始编辑时的回调
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
}


// 将要结束编辑时的回调
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    return YES;
}


// 已经结束编辑的回调
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    
}


//// 编辑文字改变的回调
//-(void)searchBar: (UISearchBar )searchBar textDidChange:(NSString )searchText{
//    
//}
//
//
//// 编辑文字改变前的回调，返回NO则不能加入新的编辑文字
//-(BOOL)searchBar: (UISearchBar )searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString )text{
//    return YES;
//}


// 搜索按钮点击的回调
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [self setSaveSearchHisWithText:searchBar.text];
    
    [self.navigationController pushViewController:[[SMSearchResultController alloc] init] animated:YES];
    
}

#pragma mark - 保存历史搜索记录
- (void)setSaveSearchHisWithText:(NSString *)hisText{
    // 先移除再刷新
    [self.searchHistories removeObject:hisText];
    [self.searchHistories insertObject:hisText atIndex:0];
    
    // 移除多余的缓存
    if (self.searchHistories.count > self.searchHistoriesCount) {
        // 移除最后一条缓存
        [self.searchHistories removeLastObject];
    }
    // 保存搜索信息
    [NSKeyedArchiver archiveRootObject:self.searchHistories toFile:self.searchHistoriesCachePath];
}


// 书本按钮点击的回调
//- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar{
//    
//}


// 取消按钮点击的回调
//- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
//    
//}


// 搜索结果按钮点击的回调
//- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar{
//    
//}


// 搜索栏的附加试图中切换按钮触发的回调
//-(void)searchBar:(UISearchBar*)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope{
//    
//}



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
