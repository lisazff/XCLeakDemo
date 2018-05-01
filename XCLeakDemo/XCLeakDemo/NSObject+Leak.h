//
//  NSObject+Leak.h
//  XCLeakDemo
//
//  Created by Cai,Tengyuan on 2018/5/1.
//  Copyright © 2018年 Cai,Tengyuan. All rights reserved.
//
/**
 思想:
    (1) 检测viewController在pop后 是否已经释放
    (2) 在viewWillAppear中将标志位设置NO
    (3) 在Navgation pop后将标志位设置为YES
    (4) 在viewDidDisappear 中判断标志位
 
 */

#import <Foundation/Foundation.h>

@interface NSObject (Leak)
+ (void)swizzleMethod:(SEL)originSel swiSel:(SEL)swiSel;
- (BOOL)willDealloc;
@end
