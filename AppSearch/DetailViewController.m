//
//  DetailViewController.m
//  AppSearch
//
//  Created by JRamos on 4/28/13.
//  Copyright (c) 2013 JRamos. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)dismissBTN:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
