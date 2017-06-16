//
//  SMPublishedEvaluationSecondCell.h
//  Shoumian
//
//  Created by 何志志 on 2017/3/21.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TagButtonClickBlock)(NSString *text);

@interface SMPublishedEvaluationSecondCell : UITableViewCell

@property (nonatomic, copy) TagButtonClickBlock tagBtnClickBlock;

@end
