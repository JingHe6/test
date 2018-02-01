//
//  DAlertController.h
//  test
//
//  Created by 何静 on 2017/4/28.
//  Copyright © 2017年 何静. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^AlertBlock)(NSInteger index);

@interface DAlertController : UIAlertController

@property(nonatomic, strong) AlertBlock alertBlock;

+ (void)item:(NSString *)carNo currentController:(UIViewController *)currentController targetController:(UIViewController *)targetController;

@end
