//
//  ViewController.m
//  test
//
//  Created by stephen on 15/3/6.
//  Copyright (c) 2015年 dsw. All rights reserved.
//

#import "ViewController.h"

#import "DSWKit.h"
#import "test-Swift.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    testswift *test=[testswift new ];
    [test load];
    
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
