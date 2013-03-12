//
//  SHAlert.m
//  SHAlertExample
//
//  Created by Seivan Heidari on 3/11/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#import "SHAlert.h"

//Not used
static dispatch_queue_t alertVcIsReadyQueue(void)
{
	static dispatch_once_t onceToken;
	static dispatch_queue_t backgroundQueue = nil;
	dispatch_once(&onceToken, ^{
		backgroundQueue = dispatch_queue_create("com.seivanheidari.alertVcIsReadyQueue", DISPATCH_QUEUE_CONCURRENT);
	});
	return backgroundQueue;
}




@interface SHViewControllerAlert ()
typedef void(^SHAlertReadyBlock)();
@property(nonatomic,strong) IBOutletCollection(UIView) NSSet * setOfOutlets;

@property(nonatomic,strong) IBOutlet UIButton * btnDestructive;
@property(nonatomic,strong) IBOutlet UIButton * btnCancel;
@property(nonatomic,strong) IBOutlet NSSet    * setOfActionButtons;

@property(nonatomic,strong) IBOutlet UILabel  * lblTitle;
@property(nonatomic,strong) IBOutlet UILabel  * lblMessage;

@property(nonatomic,strong) IBOutlet UIView   * viewAlertBackground;
@property(nonatomic,strong) NSDictionary      * buttonsWithBlocks;

@property(nonatomic,setter=setTitleText:)   NSString * titleText;
@property(nonatomic,setter=setMessageText:) NSString * messageText;
-(void)prepareForAlert:(SHAlertReadyBlock)theReadyBlock;
-(void)setButtonTitleForButton:(UIButton *)theButton withTitle:(NSString *)theTitle
                     withBlock:(SHAlertButtonTappedBlock)theBlock;

-(void)setup;
-(void)setupDefaultAlert;
-(BOOL)isStyle:(NSString *)theStyle onView:(UIView *)theView;

@end

@implementation SHViewControllerAlert
//Not done
-(void)setupDefaultAlert; {
  self.view.backgroundColor = [UIColor lightGrayColor];
  self.view.alpha = 0.5;

  self.viewAlertBackground = UIView.new;
  
  self.lblTitle            = UILabel.new;
  self.lblTitle.textAlignment = NSTextAlignmentCenter;
  self.lblTitle.numberOfLines = 1;
  self.lblMessage          = UILabel.new;
  self.lblMessage.textAlignment = NSTextAlignmentCenter;
  self.lblMessage.numberOfLines = 0;
  
  self.viewAlertBackground.backgroundColor = UIColor.redColor;
  
  //  [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
  [self.viewAlertBackground setTranslatesAutoresizingMaskIntoConstraints:NO];
  [self.lblTitle setTranslatesAutoresizingMaskIntoConstraints:NO];
  [self.lblMessage setTranslatesAutoresizingMaskIntoConstraints:NO];
  
  
  [self.view addSubview:self.viewAlertBackground];
  [self.viewAlertBackground addSubview:self.lblTitle];
  [self.viewAlertBackground addSubview:self.lblMessage];
  NSLog(@"%@", self.view.constraints);
  
}
//Not used
-(void)prepareForAlert:(SHAlertReadyBlock)theReadyBlock; {
  dispatch_async(alertVcIsReadyQueue(), ^{
//		dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
		dispatch_async(dispatch_get_main_queue(), ^{
      theReadyBlock();
//      dispatch_semaphore_signal(self.semaphore);
    });
	});
  
}
-(BOOL)isStyle:(NSString *)theStyle onView:(UIView *)theView; {
  NSAssert(theStyle, @"Must pass a style");
  NSAssert(theView, @"Must pass a view");
  BOOL doesSetupOutletStyleClass = NO;
  NSString * styleClass = [theView performSelector:@selector(styleClass)];
  if([styleClass isEqualToString:theStyle])
    doesSetupOutletStyleClass = YES;
  
  
  
  return doesSetupOutletStyleClass;
  
}
-(void)setup; {
  NSMutableSet * actionButtons = [NSMutableSet set];
  if([self.view respondsToSelector:@selector(setStyleClass:)])
    [self.setOfOutlets.allObjects enumerateObjectsUsingBlock:^(UIView * obj, NSUInteger _idx, BOOL *_stop) {
      if([self isStyle:@"alert-background" onView:obj])
        self.viewAlertBackground = obj;
      else if([self isStyle:@"title" onView:obj])
        self.lblTitle = (UILabel*)obj;
      else if([self isStyle:@"message" onView:obj])
        self.lblMessage = (UILabel*)obj;
      else if([self isStyle:@"cancel" onView:obj])
        self.btnCancel = (UIButton *)obj;
      else if([self isStyle:@"destructive" onView:obj])
        self.btnDestructive = (UIButton *)obj;
      else if([self isStyle:@"action" onView:obj])
        [actionButtons addObject:obj];
      
    }];
  self.setOfActionButtons = actionButtons.copy;
  
}

-(void)setButtonTitleForCancel:(NSString *)theTitle withBlock:(SHAlertButtonTappedBlock)theBlock; {
  [self setButtonTitleForButton:self.btnCancel withTitle:theTitle withBlock:theBlock];
  
}

-(void)setButtonTitleForDestructive:(NSString *)theTitle withBlock:(SHAlertButtonTappedBlock)theBlock; {
  [self setButtonTitleForButton:self.btnDestructive withTitle:theTitle withBlock:theBlock];
  
}

-(void)setButtonTitleForAction:(NSString *)theTitle withBlock:(SHAlertButtonTappedBlock)theBlock; {
  NSMutableSet * set = self.setOfActionButtons.mutableCopy;
  UIButton * button = self.setOfActionButtons.anyObject;
  [self setButtonTitleForButton:button withTitle:theTitle withBlock:theBlock];
  [set removeObject:button];
  self.setOfActionButtons = set.copy;
}


-(void)setButtonTitleForButton:(UIButton *)theButton withTitle:(NSString *)theTitle
                     withBlock:(SHAlertButtonTappedBlock)theBlock; {
  
  //  [self prepareForAlert:^{
  
  if(theTitle == nil)
    theTitle = [theButton titleForState:UIControlStateNormal];
  
  NSAssert(theTitle, @"Must pass a title");
  NSAssert1(theButton, @"Must pass a button for title %@", theTitle);
  NSMutableDictionary * buttonsWithBlocks =  self.buttonsWithBlocks.mutableCopy;
  if(theBlock) buttonsWithBlocks[theTitle] = theBlock ;
  self.buttonsWithBlocks = buttonsWithBlocks.copy;
  [theButton setTitle:theTitle forState:UIControlStateNormal];
  [theButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
  
  //  }];
  
  
}



-(void)loadView; {
  [super loadView];
  
  //dispatch_semaphore_signal(self.semaphore);
  
}
-(void)viewWillAppear:(BOOL)animated; {
  [super viewWillAppear:animated];
  if([self.viewAlertBackground respondsToSelector:@selector(updateStyles)])
    [self.viewAlertBackground performSelector:@selector(updateStyles)];
}

-(void)viewDidLoad; {
  [super viewDidLoad];
  self.buttonsWithBlocks = @{};
  //self.semaphore = dispatch_semaphore_create(0);
  if(self.view.subviews.count < 1)
    [self setupDefaultAlert];
  else
    [self setup];
  
  
  
}



-(void)buttonTapped:(id)sender; {
  UIButton * theTappedButton = (UIButton *)sender;
  NSString * buttonTitle =  [theTappedButton titleForState:UIControlStateNormal];
  SHAlertButtonTappedBlock block = self.buttonsWithBlocks[buttonTitle];
  if(block) block(theTappedButton);
  [self dismiss];
  
  //  if(block == nil)
  //    [self dismiss];
  //  else if (block(theTappedButton)) [self dismiss];
  //  else {
  //    [self show];
  //  }
  
}


-(void)show; {
  [self.delegate willShowAlert:self];
  UIWindow * window = [[UIApplication sharedApplication] keyWindow];
  self.view.alpha = 0.f;
  [window addSubview:self.view];
  [UIView animateWithDuration:0.2 animations:^{
    self.view.alpha = 1.f;
  } completion:^(BOOL finished) {
    [self.delegate didShowAlert:self];
  }];
  
}

-(void)dismiss; {
  [self.delegate willDismissAlert:self];
  [UIView animateWithDuration:0.2 animations:^{
    self.view.alpha = 0.f;
  } completion:^(BOOL finished) {
    [self.view removeFromSuperview];
    [self.delegate didDismissAlert:self];
  }];
  
}


-(void)setTitleText:(NSString *)textTitle; {
  //  [self prepareForAlert:^{
  self.lblTitle.text = textTitle;
  
  
  //  }];
}

-(void)setMessageText:(NSString *)textMessage; {
  //  [self prepareForAlert:^{
  self.lblMessage.text = textMessage;
  
  
  
  //  }];
  
}
@end


@interface SHAlert()
<SHViewControllerAlertDelegate>
@property(nonatomic,strong) NSOrderedSet * setOfOrderedAlerts;
@property(nonatomic,weak)   SHViewControllerAlert * currentAlertVc;
@property(nonatomic,strong) UIStoryboard * currentStoryboard;

+(SHAlert *)sharedManager;
-(void)addAlert:(SHViewControllerAlert *)theAlertVc;

@end

@implementation SHAlert

-(void)addAlert:(SHViewControllerAlert *)theAlertVc; {
  NSAssert(theAlertVc, @"Must have an alert");
  NSMutableOrderedSet * set = self.setOfOrderedAlerts.mutableCopy;
  [set addObject:theAlertVc];
  self.setOfOrderedAlerts = set.copy;
}

-(void)popAlert:(SHViewControllerAlert *)theAlertVc; {
  NSAssert(theAlertVc, @"Must have an alert");
  NSMutableOrderedSet * set =  self.setOfOrderedAlerts.mutableCopy;
  [set removeObject:theAlertVc];
  self.setOfOrderedAlerts = set.copy;
  
}

#pragma mark -
#pragma mark Initialize
-(id)init {
  self = [super init];
  if (self) {
    self.setOfOrderedAlerts = [NSOrderedSet orderedSet];
  }
  
  return self;
}

+(SHAlert *)sharedManager; {
  static dispatch_once_t once;
  static SHAlert * sharedManager;
  dispatch_once(&once, ^ { sharedManager = [[self alloc] init]; });
  return sharedManager;
}

+(void)registerStoryBoard:(UIStoryboard *)theStoryBoard; {
  SHAlert.sharedManager.currentStoryboard = theStoryBoard;
}
+(SHViewControllerAlert *)alertControllerWithStoryboardId:(NSString *)storyboardId withTitle:(NSString *)theTitle andMessage:(NSString *)theMessage; {
  
  UIStoryboard * storyboard =  SHAlert.sharedManager.currentStoryboard;
  
  NSAssert(storyboardId, @"Must specify storyboard id");
  NSAssert(storyboard, @"Must specify storyboard");
  
  UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:storyboardId];
  SHViewControllerAlert * vcAlert = (SHViewControllerAlert *)vc;
  if([vcAlert.view respondsToSelector:@selector(setStyleId:)])
    [vcAlert.view performSelector:@selector(setStyleId:) withObject:storyboardId];
  
  vcAlert.lblTitle.text   = theTitle;
  vcAlert.lblMessage.text = theMessage;
  vcAlert.delegate = SHAlert.sharedManager;
  [SHAlert.sharedManager addAlert:vcAlert];
  
  
  return vcAlert;
}

+(SHViewControllerAlert *)alertName:(NSString *)alertName withTitle:(NSString *)theTitle
                         andMessage:(NSString *)theMessage; {
  NSAssert(alertName, @"Must specify alert name");
  //  UIStoryboard * sb = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
  //  UIViewController * vc = [sb instantiateViewControllerWithIdentifier:storyBoardVcName];
  SHViewControllerAlert * vcAlert = [[SHViewControllerAlert alloc] init];
  
  if([vcAlert.view respondsToSelector:@selector(setStyleId:)])
    [vcAlert.view performSelector:@selector(setStyleId:) withObject:alertName];
  
  vcAlert.lblTitle.text   = theTitle;
  vcAlert.lblMessage.text = theMessage;
  vcAlert.delegate = SHAlert.sharedManager;
  [SHAlert.sharedManager addAlert:vcAlert];
  
  
  return vcAlert;
}


-(void)willShowAlert:(SHViewControllerAlert *)theAlert; {
  NSAssert(theAlert, @"Must have an alert");
  self.currentAlertVc.view.alpha = 0.f;
}

-(void)didShowAlert:(SHViewControllerAlert *)theAlert; {
  NSAssert(theAlert, @"Must have an alert");
  self.currentAlertVc = theAlert;
}

-(void)willDismissAlert:(SHViewControllerAlert *)theAlert; {
  NSAssert(theAlert, @"Must have an alert");
  self.currentAlertVc.view.alpha = 1.f;
}

-(void)didDismissAlert:(SHViewControllerAlert *)theAlert; {
  NSAssert(theAlert, @"Must have an alert");
  [self popAlert:theAlert];
  self.currentAlertVc = self.setOfOrderedAlerts.lastObject;
  
}





@end

