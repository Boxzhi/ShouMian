//
//  SMCollectionCellMenuView.h
//  Shoumian
//
//  Created by 何志志 on 2017/3/22.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickButtonBlock)(NSInteger index);

@interface SMCollectionCellMenuView : UIView

@property (nonatomic, copy) ClickButtonBlock shareDeleteBtnClick;

@end

