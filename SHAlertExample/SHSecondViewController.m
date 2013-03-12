//
//  SHSecondViewController.m
//  SHAlertExample
//
//  Created by Seivan Heidari on 3/11/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#import "SHSecondViewController.h"
#import "SHAlert.h"

@interface SHSecondViewController ()
-(IBAction)showAlert:(id)sender;
@end

@implementation SHSecondViewController
-(IBAction)showAlert:(id)sender; {
  SHViewControllerAlert * vc = [SHAlert alertName:@"WithoutIB" withTitle:@"Without IB and trying to expand the label and etc and see how far it goes." andMessage:@"So this is just a normal alert based on the standard structure of vertical buttons - the buttons are in order of creation"];
  
  [vc show];

}
- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated; {
  [self showAlert:nil];
}

@end
