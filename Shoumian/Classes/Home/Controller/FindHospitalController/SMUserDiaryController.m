//
//  SMUserDiaryController.m
//  Shoumian
//
//  Created by 何志志 on 2017/3/29.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMUserDiaryController.h"
#import "SMHomeFifthCell.h"

@interface SMUserDiaryController ()

@end

@implementation SMUserDiaryController

static NSString * const cellId = @"cellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"用户日记";
    [self.view addSubview:self.contentTabPlain];
    [self.contentTabPlain registerNib:[UINib nibWithNibName:NSStringFromClass([SMHomeFifthCell class]) bundle:nil] forCellReuseIdentifier:cellId];
    self.contentTabPlain.rowHeight = (S_Width - 45) * 12 / 22 + 180;
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SMHomeFifthCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
