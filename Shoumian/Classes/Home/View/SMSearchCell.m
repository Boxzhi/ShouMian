//
//  SMSearchCell.m
//  Shoumian
//
//  Created by 何志志 on 2017/2/18.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMSearchCell.h"
#import "SMSearchCollectionViewCell.h"
CGFloat const itemH = 30;
static NSString * const searchTagCellId = @"searchTagCellId";
@interface SMSearchCell()<UICollectionViewDataSource>

@end

@implementation SMSearchCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UICollectionViewFlowLayout *layout = self.collectionView.collectionViewLayout;
    CGFloat margin = 15;
    CGFloat cols = 4;
    CGFloat itemW = (S_Width - (cols + 1) * margin) / cols;
    layout.itemSize = CGSizeMake(95, itemH);
    layout.minimumInteritemSpacing = margin;
    layout.minimumLineSpacing = margin;
    
    // 设置collectionView
    self.collectionView.dataSource = self;
    self.collectionView.scrollEnabled = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerNib:[UINib nibWithNibName:@"SMSearchCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:searchTagCellId];
    
    
}

- (void)setDataArr:(NSMutableArray *)DataArr{
    _dataArr = DataArr;
    
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SMSearchCollectionViewCell *tagCell = [collectionView dequeueReusableCellWithReuseIdentifier:searchTagCellId forIndexPath:indexPath];
    
    tagCell.tagLabel.text = _dataArr[indexPath.row];
//    tagCell.tagLabel.adjustsFontSizeToFitWidth = YES;
    
    return tagCell;
}

@end
