//
//  ViewController2.m
//  test
//
//  Created by 何静 on 2017/4/10.
//  Copyright © 2017年 何静. All rights reserved.
//

#import "ViewController2.h"

@interface ViewController2 () {
    int a;
}

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    a=1;
    if (self.MyBlock) {
        a=2;
        self.MyBlock(@"hejing");
    }
    
    [self fun:^(NSString *string) {
        NSLog(@"block:%@",string);
    }];
    // Do any additional setup after loading the view.
}

- (void)fun:(Block)block {
    if (a) {
        block(@"hehehhe");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
