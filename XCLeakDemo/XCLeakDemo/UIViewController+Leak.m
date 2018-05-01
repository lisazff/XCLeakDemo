//
//  UIViewController+Leak.m
//  XCLeakDemo
//
//  Created by Cai,Tengyuan on 2018/5/1.
//  Copyright © 2018年 Cai,Tengyuan. All rights reserved.
//

#import "UIViewController+Leak.h"
#import "NSObject+Leak.h"
#import <objc/runtime.h>

const char *kLeakMemory;

@implementation UIViewController (Leak)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleMethod:@selector(viewWillAppear:) swiSel:@selector(sw_viewWillAppear:)];
        [self swizzleMethod:@selector(viewDidDisappear:) swiSel:@selector(sw_viewDidDisappear:)];
    });
}

- (void)sw_viewWillAppear:(BOOL)animated{
    [self sw_viewWillAppear:animated];
    
    objc_setAssociatedObject(self, &kLeakMemory, @(NO), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)sw_viewDidDisappear:(BOOL)animated{
    [self sw_viewDidDisappear:animated];
    
    if (objc_getAssociatedObject(self, &kLeakMemory)) {
        [self willDealloc];
    }
}

- (BOOL)willDealloc {
    if (![super willDealloc]) {
        return NO;
    }
    return YES;
}



@end
