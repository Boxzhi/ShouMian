//
//  SMPCCollectionViewHeaderView.m
//  Shoumian
//
//  Created by 何志志 on 2017/3/8.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMPCCollectionViewHeaderView.h"

@implementation SMPCCollectionViewHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.checkAllBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];
    [self.projectBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];
}

@end
