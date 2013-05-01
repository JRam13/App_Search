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

#define IDIOM    UI_USER_INTERFACE_IDIOM()
#define IPAD     UIUserInterfaceIdiomPad

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    self.scrollView.contentSize = CGSizeMake(320,570);
    
    if(IDIOM == IPAD){
        self.scrollView.contentSize = CGSizeMake(768,1175);
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
