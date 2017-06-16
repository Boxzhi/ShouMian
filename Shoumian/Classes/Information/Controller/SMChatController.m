//
//  SMChatController.m
//  Shoumian
//
//  Created by 何志志 on 2017/2/24.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMChatController.h"
#import "SMChatConsultController.h"
#import "SMChatPrivateController.h"

@interface SMChatController ()

@property (nonatomic, strong)NSArray *titleData;

@end

@implementation SMChatController

- (NSArray *)titleData{
    if (!_titleData) {
        _titleData = @[@"咨询", @"私信"];
    }
    return _titleData;
}

- (instancetype)init{
    if (self = [super init]) {
        self.menuHeight = 50;
        self.menuItemWidth = S_Width / 2;
        self.menuBGColor = [UIColor whiteColor];
        self.menuViewStyle = WMMenuViewStyleLine;
        self.progressColor = UIColorRed;
        self.titleSizeNormal = 16;
        self.titleSizeSelected = 16;
        self.titleColorNormal = UIColorFromRGB(0x666666);
        self.titleColorSelected = UIColorRed;
        self.preloadPolicy = WMPageControllerPreloadPolicyNear;
        //        self.menuViewBottomSpace = 1;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"聊天";
    
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
            return [[SMChatConsultController alloc] init];
        }
            break;
        case 1:{
            return [[SMChatPrivateController alloc] init];
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

@end
