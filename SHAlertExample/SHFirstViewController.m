//
//  SHFirstViewController.m
//  SHAlertExample
//
//  Created by Seivan Heidari on 3/11/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#import "SHFirstViewController.h"
#import "SHAlert.h"


@interface SHFirstViewController ()
-(IBAction)showAlert:(id)sender;
@end

@implementation SHFirstViewController
-(IBAction)showAlert:(id)sender; {
  SHViewControllerAlert * vc =  [SHAlert alertControllerWithStoryboardId:@"SHAlertSampleWithoutPixate" withTitle:@"This is without Pixate" andMessage:@"0 Setup your outlets via their actual counterparts without resorting to keyvalues."];
  [vc setButtonTitleForDestructive:@"Delete" withBlock:nil];
  [vc setButtonTitleForCancel:@"Cancel" withBlock:nil];
  
  SHViewControllerAlert *vc1 =  [SHAlert alertControllerWithStoryboardId:@"SHAlertSampleWithPixate" withTitle:@"This is with Pixate" andMessage:@"This is a really long message that shows how well and nicely SHAlert plays with AutoLayout. Setup your alert in a nib and then just hook it up in your controllers. Use Pixate to get it pretty or just use the callbacks to customize the buttons. "];
  
  [vc1 setButtonTitleForDestructive:@"Destroy" withBlock:^void(UIButton *theButton) {
    //      [vc show];

  }];
  [vc1 setButtonTitleForCancel:@"Cancel" withBlock:^void(UIButton *theButton) {
        [vc show];

  }];

  [vc1 setButtonTitleForAction:@"OK" withBlock:^void(UIButton *theButton) {
    NSLog(@"GOD DAMN BRO");

  }];
  
  
  [vc1 show];
  
  

}
- (void)viewDidLoad;{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated; {
  [super viewDidAppear:animated];


  
  
  


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
