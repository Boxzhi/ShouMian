//
//  SMMyPrivateCustomController.m
//  Shoumian
//
//  Created by 何志志 on 2017/3/20.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMMyPrivateCustomController.h"
#import "SMPrivateCustomCell.h"

@interface SMMyPrivateCustomController ()

@end

@implementation SMMyPrivateCustomController

static NSString * const pcCellId = @"pcCellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title = @"私人定制";
    [self.view addSubview:self.contentTabPlain];
    [self.contentTabPlain registerNib:[UINib nibWithNibName:NSStringFromClass([SMPrivateCustomCell class]) bundle:nil] forCellReuseIdentifier:pcCellId];
    self.contentTabPlain.rowHeight = UITableViewAutomaticDimension;
    self.contentTabPlain.estimatedRowHeight = 190;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SMPrivateCustomCell *pcCell = [tableView dequeueReusableCellWithIdentifier:pcCellId forIndexPath:indexPath];
    return pcCell;
};

@end
