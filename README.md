SHAlert
=================

Custom alert that uses storyboards for its layout. Has out of the box Pixate support. 
Using class names as action, cancel and destructive with message, title and alert-background.
Perfect if you want to use several differen styles of alert and button position.
Still early 0.1.1 but has loads of features in the pipeline. Check Roadmap for what's planned. 

## Requirement

Requires iOS 5 and above. Works wonders with auto layout. 

## Usage

Add the dependency to your `Podfile`:

```ruby
platform :ios
pod 'SHAlert'
...
```

Run `pod install` to install the dependencies.

Next, import the header file wherever you want to use the picker:

```objc
#import "SHAlert.h"
```

Setup your view controller in the storyboard to use 'SHViewControllerAlert' and connect the setOutletCollection and class names
as user defined runtime variables on the outlets OR the descriptive outlets themselves (no need for the run time variables then) 

pixate class names are such
alert-background (view)
destructive (button)
cancel (button)
action (button)
title (label)
message (label)

And the storyboardId will be the pixate style id

Register the storyboard that contains your alerts. 

```objc
[SHAlert registerStoryBoard:myStoryboard];
```

Finally, present the alert when necessary

```objc
+(SHViewControllerAlert *)alertControllerWithStoryboardId:(NSString *)storyboardId
                                                withTitle:(NSString *)theTitle
                                               andMessage:(NSString *)theMessage;

-(void)show;
-(void)dismiss;
-(void)setButtonTitleForCancel:(NSString *)theTitle withBlock:(SHAlertButtonTappedBlock)theBlock;
-(void)setButtonTitleForDestructive:(NSString *)theTitle withBlock:(SHAlertButtonTappedBlock)theBlock;
-(void)setButtonTitleForAction:(NSString *)theTitle withBlock:(SHAlertButtonTappedBlock)theBlock;


```
The storyboardId  will be the id in your styling

#SHAlertSampleWithPixate .cancel {...}

## License

Usage is provided under the [MIT License](http://http://opensource.org/licenses/mit-license.php).  See LICENSE for the full details.

