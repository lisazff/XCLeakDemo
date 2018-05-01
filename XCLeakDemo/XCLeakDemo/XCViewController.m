//
//  XCViewController.m
//  XCLeakDemo
//
//  Created by Cai,Tengyuan on 2018/5/1.
//  Copyright © 2018年 Cai,Tengyuan. All rights reserved.
//

typedef void (^testLeak)(void);
#import "XCViewController.h"

@interface XCViewController ()

@property (nonatomic, copy) testLeak leak;
@property (nonatomic, strong) NSString *name;

@end

@implementation XCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    // 内存泄漏代码
    self.leak = ^{
        _name = @"xiaocai";
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc{
    NSLog(@"dealloc---two");
}

@end
