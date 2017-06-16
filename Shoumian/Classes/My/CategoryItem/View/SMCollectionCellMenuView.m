//
//  SMCollectionCellMenuView.m
//  Shoumian
//
//  Created by 何志志 on 2017/3/22.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMCollectionCellMenuView.h"

@implementation SMCollectionCellMenuView

- (void)awakeFromNib {
    [super awakeFromNib];
}


#pragma mark Actions
- (IBAction)moreBtnPressed:(id)sender {
    if (self.shareDeleteBtnClick) {
        self.shareDeleteBtnClick(0);
    }
}

- (IBAction)deleteBtnPressed:(id)sender {
    if (self.shareDeleteBtnClick) {
        self.shareDeleteBtnClick(1);
    }
}


@end
