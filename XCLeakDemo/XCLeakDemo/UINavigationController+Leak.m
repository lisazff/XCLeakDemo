//
//  UINavigationController+Leak.m
//  XCLeakDemo
//
//  Created by Cai,Tengyuan on 2018/5/1.
//  Copyright © 2018年 Cai,Tengyuan. All rights reserved.
//

#import "UINavigationController+Leak.h"
#import "NSObject+Leak.h"
#import <objc/runtime.h>

@implementation UINavigationController (Leak)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleMethod:@selector(popViewControllerAnimated:) swiSel:@selector(sw_popViewControllerAnimated:)];
    });
}

- (nullable UIViewController *)sw_popViewControllerAnimated:(BOOL)animated{
    UIViewController *vc = [self sw_popViewControllerAnimated:animated];
    
    extern const char *kLeakMemory;
    objc_setAssociatedObject(self, &kLeakMemory, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    return vc;
}

@end
