//
//  ViewController.m
//  XCLeakDemo
//
//  Created by Cai,Tengyuan on 2018/5/1.
//  Copyright © 2018年 Cai,Tengyuan. All rights reserved.
//

#import "ViewController.h"
#import "XCViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)leakClick {
    XCViewController *vc = [[XCViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)dealloc{
    NSLog(@"dealloc---one");
}

@end
