//
//  SHAlert.h
//  SHAlertExample
//
//  Created by Seivan Heidari on 3/11/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

@protocol SHViewControllerAlertDelegate;

@interface SHViewControllerAlert : UIViewController
typedef void(^SHAlertButtonTappedBlock)(UIButton * theButton);
@property(nonatomic,weak) id<SHViewControllerAlertDelegate> delegate;
-(void)show;
-(void)dismiss;
-(void)setButtonTitleForCancel:(NSString *)theTitle withBlock:(SHAlertButtonTappedBlock)theBlock;
-(void)setButtonTitleForDestructive:(NSString *)theTitle withBlock:(SHAlertButtonTappedBlock)theBlock;
-(void)setButtonTitleForAction:(NSString *)theTitle withBlock:(SHAlertButtonTappedBlock)theBlock;

@end

@protocol SHViewControllerAlertDelegate <NSObject>
-(void)willShowAlert:(SHViewControllerAlert *)theAlert;
-(void)didShowAlert:(SHViewControllerAlert *)theAlert;
-(void)willDismissAlert:(SHViewControllerAlert *)theAlert;
-(void)didDismissAlert:(SHViewControllerAlert *)theAlert;
@end


@interface SHAlert : NSObject

+(void)registerStoryBoard:(UIStoryboard *)theStoryBoard;

+(SHViewControllerAlert *)alertControllerWithStoryboardId:(NSString *)storyboardId
                                                withTitle:(NSString *)theTitle
                                               andMessage:(NSString *)theMessage;
+(SHViewControllerAlert *)alertName:(NSString *)alertName withTitle:(NSString *)theTitle andMessage:(NSString *)theMessage; 
@end
