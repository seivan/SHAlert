//
//  main.m
//  SHAlertExample
//
//  Created by Seivan Heidari on 3/11/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SHAppDelegate.h"
#import <PXEngine/PXEngine.h>


int main(int argc, char *argv[])
{
  @autoreleasepool {
//    [PXEngine licenseKey:LICENSE_SERIAL forUser:LICENSE_EMAIL];
    [PXEngine applyStylesheets];
//    PXEngine.currentApplicationStylesheet.monitorChanges = YES;
      return UIApplicationMain(argc, argv, nil, NSStringFromClass([SHAppDelegate class]));
  }
}
