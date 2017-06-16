//
//  SMCategoryCell.h
//  Shoumian
//
//  Created by 何志志 on 2017/1/22.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickButtonBlock)(NSInteger index);

@interface SMCategoryCell : UITableViewCell

@property (nonatomic, copy) ClickButtonBlock clickBtnBlock;

@end
