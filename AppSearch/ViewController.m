//
//  ViewController.m
//  AppSearch
//
//  Created by JRamos on 4/26/13.
//  Copyright (c) 2013 JRamos. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{
    
    self.scrollView.contentSize = CGSizeMake(320,800);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
