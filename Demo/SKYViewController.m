//
//  SKYViewController.m
//  Demo
//
//  Created by Wangzhao on 24/6/13.
//  Copyright (c) 2013 George. All rights reserved.
//

#import "SKYViewController.h"
#import "SKYAuthor.h"

@interface SKYViewController ()

@end

@implementation SKYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SKYAuthor *author = [[SKYAuthor alloc] init];
    [author getAuthorizationCode];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
