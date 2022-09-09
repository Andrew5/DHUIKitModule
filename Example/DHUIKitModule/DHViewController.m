//
//  DHViewController.m
//  DHUIKitModule
//
//  Created by jabraknight on 07/27/2022.
//  Copyright (c) 2022 jabraknight. All rights reserved.
//

#import "DHViewController.h"
#import <DHUIKitModule/DHUIKitModule-umbrella.h>

@interface DHViewController ()

@end

@implementation DHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;

	// Do any additional setup after loading the view, typically from a nib.
    [DHProgressHUD showHUDAddedTo:self.view];
    [self performSelector:@selector(hiddentView) withObject:self afterDelay:5];
}

- (void)hiddentView {
    
    [DHProgressHUD hide];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
