//
//  DAlertController.m
//  test
//
//  Created by 何静 on 2017/4/28.
//  Copyright © 2017年 何静. All rights reserved.
//

#import "DAlertController.h"

#define APP (((AppDelegate *)[UIApplication sharedApplication].delegate))

@interface DAlertController ()

@end

@implementation DAlertController

+ (void)item:(NSString *)carNo currentController:(UIViewController *)currentController targetController:(UIViewController *)targetController {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@" " message:@" " preferredStyle:UIAlertControllerStyleAlert];
    UIImageView *loadingView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 290, 177)];
    loadingView.backgroundColor = [UIColor whiteColor];
    loadingView.userInteractionEnabled = YES;
    [alertController.view addSubview:loadingView];
    
    [currentController presentViewController:alertController animated:YES completion:^{
    }];
}

@end
