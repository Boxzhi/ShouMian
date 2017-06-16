//
//  SMSearchHisModel.h
//  Shoumian
//
//  Created by 何志志 on 2017/2/20.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMSearchHisModel : NSObject

@property (nonatomic, strong) NSMutableArray *hisData;

@property (nonatomic, strong) NSMutableArray *hotData;

- (CGFloat)hisCellH;

- (CGFloat)hotCellH;

@end
