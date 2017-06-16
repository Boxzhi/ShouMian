//
//  SMPCEqualFlowLayout.h
//  Shoumian
//
//  Created by 何志志 on 2017/3/3.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SMPCEqualFlowLayoutDelegate <UICollectionViewDelegateFlowLayout>

@end

@interface SMPCEqualFlowLayout : UICollectionViewFlowLayout
@property (nonatomic, weak) id<SMPCEqualFlowLayoutDelegate> smDelegate;
@end
