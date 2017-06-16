//
//  SMMyLastCell.h
//  Shoumian
//
//  Created by 何志志 on 2017/1/22.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickItemViewBlock)(NSInteger index);

@interface SMMyLastCell : UITableViewCell

@property (nonatomic, copy) ClickItemViewBlock clickItemViewBlock;

@end
