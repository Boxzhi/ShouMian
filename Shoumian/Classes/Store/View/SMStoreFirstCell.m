//
//  SMStoreFirstCell.m
//  Shoumian
//
//  Created by 何志志 on 2017/3/1.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMStoreFirstCell.h"
#import "SMStoreFirstLayoutCell.h"

@interface SMStoreFirstCell()<UICollectionViewDataSource>

@end

@implementation SMStoreFirstCell

static NSString * const layoutCellId = @"layoutCellId";

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        UICollectionView *collView = [[UICollectionView alloc] initWithFrame:CGRectMake(SMMargin, 0, self.sm_width - 2 * SMMargin, self.sm_height) collectionViewLayout:layout];
        CGFloat itemNum = 4;
        CGFloat margin = 10;
        CGFloat itemW = (S_Width - (itemNum - 1) * 10 - SMMargin * 2) / itemNum;
        CGFloat itemH = itemW / 2;
        
        layout.itemSize = CGSizeMake(itemW, itemH);
        layout.minimumInteritemSpacing = margin;
        layout.minimumLineSpacing = 15;
        
        collView.dataSource = self;
        collView.backgroundColor = [UIColor whiteColor];
        collView.showsVerticalScrollIndicator = NO;
        collView.showsHorizontalScrollIndicator = NO;
        collView.scrollEnabled = NO;
        [collView registerNib:[UINib nibWithNibName:NSStringFromClass([SMStoreFirstLayoutCell class]) bundle:nil] forCellWithReuseIdentifier:layoutCellId];
        self.collView = collView;
        [self.contentView addSubview:collView];
        
        UIView *lineView = [UIView hyb_viewWithSuperView:self.contentView constraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.contentView);
            make.height.mas_equalTo(0.5);
        }];
        lineView.backgroundColor = LineViewBackgroundColor;
    }
    return self;
}

- (void)setArr:(NSMutableArray *)arr{
    _arr = arr;
    [self.collView reloadData];
}

#pragma mark - UICollectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _arr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SMStoreFirstLayoutCell *layoutCell = [collectionView dequeueReusableCellWithReuseIdentifier:layoutCellId forIndexPath:indexPath];
    layoutCell.titleLab.text = _arr[indexPath.row];
    return layoutCell;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.collView.frame = CGRectMake(SMMargin, 0, self.sm_width - 2 * SMMargin, self.sm_height);
}

@end
