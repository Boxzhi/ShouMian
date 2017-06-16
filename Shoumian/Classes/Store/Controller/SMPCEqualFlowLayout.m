//
//  SMPCEqualFlowLayout.m
//  Shoumian
//
//  Created by 何志志 on 2017/3/3.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMPCEqualFlowLayout.h"

@interface SMPCEqualFlowLayout()<UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *itemAttributes;
@property (nonatomic, assign) CGSize contentSize;

@end

@implementation SMPCEqualFlowLayout

- (id)init
{
    if (self = [super init]) {
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.minimumInteritemSpacing = 10;
        self.minimumLineSpacing = 10;
        self.sectionInset = UIEdgeInsetsMake(0, 30, 0, SMMargin);
    }
    
    return self;
}

#pragma mark - Methods to Override
- (void)prepareLayout
{
    [super prepareLayout];
    
    // 分组数量
    NSInteger sectionCount = [[self collectionView] numberOfSections];
    self.itemAttributes = [NSMutableArray arrayWithCapacity:sectionCount];
    
    CGFloat xOffset = self.sectionInset.left;  //  初始X值
    CGFloat yOffset = self.sectionInset.top;  //  初始Y值
    CGFloat xNextOffset = self.sectionInset.left;
    for (NSInteger idx = 0; idx < sectionCount; idx++) {

        // 每个分组的cell数量
        NSInteger itemcount = [[self collectionView] numberOfItemsInSection:idx];
        
        NSIndexPath *indexPathX = [NSIndexPath indexPathForRow:itemcount inSection:idx];
        //  headerview的size
        CGSize headerViewSize = [self.smDelegate collectionView:self.collectionView layout:self referenceSizeForHeaderInSection:idx];
        UICollectionViewLayoutAttributes *headerAttributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:indexPathX];
        headerAttributes.frame = CGRectMake(0, yOffset, headerViewSize.width, headerViewSize.height);
        [_itemAttributes addObject:headerAttributes];
        
        xOffset = self.sectionInset.left;
        xNextOffset = self.sectionInset.left;
        yOffset = yOffset + headerViewSize.height;  //  下个分组cell的第一个item的Y值
        for (NSInteger idy = 0; idy < itemcount; idy++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:idy inSection:idx];
            CGSize itemSize = [self.smDelegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
            
            xNextOffset += (self.minimumInteritemSpacing + itemSize.width);
            if (xNextOffset > [self collectionView].bounds.size.width - self.sectionInset.right) {
                xOffset = self.sectionInset.left;
                xNextOffset = (self.sectionInset.left + self.minimumInteritemSpacing + itemSize.width);
                yOffset += (itemSize.height + self.minimumLineSpacing);
            }
            else
            {
                xOffset = xNextOffset - (self.minimumInteritemSpacing + itemSize.width);
            }
            
            UICollectionViewLayoutAttributes *layoutAttributes =
            [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            
            layoutAttributes.frame = CGRectMake(xOffset, yOffset, itemSize.width, itemSize.height);
            [_itemAttributes addObject:layoutAttributes];
            
            if (idy == (itemcount - 1)) {
                yOffset += itemSize.height;   //  下一个分组headerView的Y值
            }
            
            if (idx == (sectionCount - 1) && idy == (itemcount - 1)) {
                self.contentSize = CGSizeMake(self.collectionView.sm_width, yOffset + 10);
            }
        }
    }
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    return (self.itemAttributes)[indexPath.section];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return (self.itemAttributes)[indexPath.item];
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return [self.itemAttributes filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(UICollectionViewLayoutAttributes *evaluatedObject, NSDictionary *bindings) {
        return CGRectIntersectsRect(rect, [evaluatedObject frame]);
    }]];
}

- (CGSize)collectionViewContentSize{
    return self.contentSize;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return NO;
}
@end

