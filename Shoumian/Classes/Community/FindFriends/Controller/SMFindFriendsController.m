//
//  SMFindFriendsController.m
//  Shoumian
//
//  Created by 何志志 on 2017/2/22.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMFindFriendsController.h"
#import "SMRecommendFriendsController.h"
#import "SMMeFollowController.h"

@interface SMFindFriendsController ()

@property (nonatomic, strong)NSArray *titleData;

@end

@implementation SMFindFriendsController

- (NSArray *)titleData{
    if (!_titleData) {
        _titleData = @[@"推荐好友", @"我关注的"];
    }
    return _titleData;
}

- (instancetype)init{
    if (self = [super init]) {
        self.menuHeight = 44;
        self.menuItemWidth = S_Width / 5;
        self.menuBGColor = [UIColor whiteColor];
        self.menuViewStyle = WMMenuViewStyleLine;
        self.progressColor = RGB(237, 114, 102);
        self.titleSizeNormal = 16;
        self.titleSizeSelected = 16;
        self.titleColorNormal = UIColorFromRGB(0x666666);
        self.titleColorSelected = UIColorFromRGB(0x666666);
        self.preloadPolicy = WMPageControllerPreloadPolicyNear;
        //        self.menuViewBottomSpace = 1;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"发现好友";
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:16]};
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < 2; i++) {
        CGSize titleSize = [_titleData[i] sizeWithAttributes:attrs];
        [arr addObject:[NSNumber numberWithFloat:titleSize.width]];
    }
    self.progressViewWidths = arr;
}


#pragma mark - DataSource & Delegate
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController{
    return self.titleData.count;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index{
    switch (index) {
        case 0:{
            return [[SMRecommendFriendsController alloc] init];
        }
            break;
        case 1:{
            return [[SMMeFollowController alloc] init];
        }
            break;
            
        default:
            return nil;
            break;
    }
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index{
    return self.titleData[index];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
