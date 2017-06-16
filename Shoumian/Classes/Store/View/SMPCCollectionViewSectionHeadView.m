//
//  SMPCCollectionViewSectionHeadView.m
//  Shoumian
//
//  Created by 何志志 on 2017/3/8.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMPCCollectionViewSectionHeadView.h"

@implementation SMPCCollectionViewSectionHeadView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.projectBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];
}

@end
