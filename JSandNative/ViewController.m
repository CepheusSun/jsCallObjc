//
//  ViewController.m
//  JSandNative
//
//  Created by 孙扬 on 16/8/24.
//  Copyright © 2016年 MichealSun. All rights reserved.
//

#import "ViewController.h"
#import "PSWebViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor redColor];
        button.frame = CGRectMake(100, 100, 100, 100);
        [button addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
        button;
    })];

}

- (void)action{
    [self.navigationController pushViewController:[PSWebViewController new] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
