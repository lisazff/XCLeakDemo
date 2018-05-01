//
//  NSObject+Leak.m
//  XCLeakDemo
//
//  Created by Cai,Tengyuan on 2018/5/1.
//  Copyright © 2018年 Cai,Tengyuan. All rights reserved.
//

#import "NSObject+Leak.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>

@implementation NSObject (Leak)

+ (void)swizzleMethod:(SEL)originSel swiSel:(SEL)swiSel{
    Method originMethod = class_getInstanceMethod([self class], originSel);
    Method swizzleMethod = class_getInstanceMethod([self class], swiSel);
    BOOL didAdd = class_addMethod([self class], originSel, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
    if (didAdd) {
        class_addMethod([self class], swiSel, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    }else{
        method_exchangeImplementations(originMethod, swizzleMethod);
    }
}

- (BOOL)willDealloc{
    // 这里注意, 使用weakSelf 防止引起循环引用
    __weak typeof(self) weakSelf =  self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf showMsg:NSStringFromClass([strongSelf class])];
    });
    return YES;
}

- (void)showMsg:(NSString *)msg{
    UIAlertView *alertViewTemp = [[UIAlertView alloc] initWithTitle:@"Leak"
                                                            message:msg
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles: nil];
    [alertViewTemp show];
}

@end
