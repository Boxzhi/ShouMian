//
//  SMSearchCell.h
//  Shoumian
//
//  Created by 何志志 on 2017/2/18.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMSearchCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *dataArr;

@end
