//
//  ViewController.m
//  test
//
//  Created by 何静 on 17/3/22.
//  Copyright © 2017年 何静. All rights reserved.
//

#import "ViewController.h"
#import "ViewController2.h"

@interface ViewController ()<UITextFieldDelegate> {
    BOOL threadDone;
}

@end

@implementation ViewController

- (void)log {
    for (int i=0; i<10; i++) {
        NSLog(@"-----");
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *array = @[@"张三",@"李四",@"王小二",@"小王刚",@"000",@"胡小芳",@"王子"];
    NSMutableArray *arr = [NSMutableArray array];
    for (NSString *obj in array) {
        NSString *zm = [self transformCharacter:obj];
        [arr addObject:zm];
    }
    
    NSArray *arr2 = [arr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    NSLog(@"%@",arr2);
    
    
    
    
    
    
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//
//    ViewController2 *vc = [[ViewController2 alloc] init];
//
//    vc.MyBlock = ^void(NSString *string) {
//        NSLog(@"MyBlock:%@",string);
//    };
//    [self.navigationController pushViewController:vc animated:YES];
    
    
         // Do any additional setup after loading the view, typically from a nib.
}

//汉字转拼音之后，截取首字母，并大写
- (NSString *)transformCharacter:(NSString*)sourceStr {
    //先将原字符串转换为可变字符串
    NSMutableString *ms = [NSMutableString stringWithString:sourceStr];
    if (ms.length) {
        //将汉字转换为带音调拼音
        CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformToLatin, NO);
        //将拼音的声调去掉
//        CFStringTransform((__bridge CFMutableStringRef)ms, 0,kCFStringTransformStripDiacritics,NO);
        //将字符串所有字母大写
        
        //截取首字母
        NSString *firstStr = [ms substringToIndex:1];
        NSString *upStr = [firstStr uppercaseString];
        return upStr;
    }
    return @"#";
}

- (void)textFieldDidChange:(UITextField *)textField {
    UITextRange *selectedRange = [textField markedTextRange];
    //获取高亮部分
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
    if (!position) {
        if (textField.text.length > 6) {
            textField.text = [textField.text substringToIndex:6];
        }
    }
    // 有高亮选择的字符串，则暂不对文字进行统计和限制
    else{
        
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - 只允许数字和字母
- (BOOL)identityNumberOrletter:(NSString *)string {
    NSString *numberRegex = @"^[A-Za-z0-9]$";
    NSPredicate *numberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",numberRegex];
    return [numberTest evaluateWithObject:string];
}

#pragma mark - UITextFieldDelegate
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    if ([string isEqualToString:@""]) {
//        return YES;
//    }
//    
//
//    return YES;
//}


//相差的时间天数
- (void)intervalSinceNow: (NSString *)theDate
{
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];//设置时间格式//很重要
    NSDate *lastDate=[formatter dateFromString:theDate];
    
    NSString *nowTime = [formatter stringFromDate:[NSDate date]];
    NSDate * nowDate = [formatter dateFromString:nowTime];
    
    NSTimeInterval last=[lastDate timeIntervalSince1970];
    NSTimeInterval now=[nowDate timeIntervalSince1970];

    NSTimeInterval cha=last-now;
    int day = cha/86400+1;
    if (day>0) {
        NSString *timeString = [NSString stringWithFormat:@"%f", cha/86400];
            NSLog(@"--＝＝＝%d====%@",day,timeString);
    } else {
       
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
