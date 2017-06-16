//
//  SMSearchHisModel.m
//  Shoumian
//
//  Created by 何志志 on 2017/2/20.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMSearchHisModel.h"

@implementation SMSearchHisModel

- (void)setHisData:(NSMutableArray *)hisData{
    _hisData = hisData;
}

-(void)setHotData:(NSMutableArray *)hotData{
    _hotData = hotData;
}

- (CGFloat)hisCellH
{
    CGFloat originY = 20;
    CGFloat margin = 15;
    
    NSInteger cols = 3;
    NSInteger rows = (self.hisData.count - 1) / cols + 1;
    return rows * (30 + margin) + originY;
}

- (CGFloat)hotCellH
{
    CGFloat originY = 20;
    CGFloat margin = 15;
    
    NSInteger cols = 3;
    NSInteger rows = (self.hotData.count - 1) / cols + 1;
    return rows * (30 + margin) + originY;
}

@end
