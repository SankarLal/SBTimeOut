# SBTimeOut
SBTimeOut detects when an app goes idle/inactive (no touches) and sends a time out notification when app is in Foreground State, Suspended State and Background State which is developed in Objective C.

For Swift click [here][sbswiftytimeout-url]

<img src="https://raw.githubusercontent.com/sankarlal/sbTimeOut/master/Screen%20Shots/LogoutScreen.png" alt="SBTimeOut Screenshot" />
## Configuration

Add `SBTimeOut` Class into `main.m` Class

```objective-c

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "SBTimeOut.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, NSStringFromClass([SBTimeOut class]), NSStringFromClass([AppDelegate class]));
    }
}
```

Change TimeOut time in "SBTimeOut" Class

```objective-c

#define kSBApplicationTimeoutInMinutes 1

```

For Background And Suspended State - AppDelegate 

```objective-c

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    // Get Stored Time Stamp
    [self getIdleTimeInMinutes];
    
}

#pragma mark- Application Timeout Method
-(void)getIdleTimeInMinutes {
    
    NSDate *getStoredDate = (NSDate *)[[NSUserDefaults standardUserDefaults] objectForKey:@"SB_Date_Key"];
    
    if (getStoredDate) {
        
        NSTimeInterval timeOutMinutes = kSBApplicationTimeoutInMinutes * 60;
        NSTimeInterval diff = [[NSDate date] timeIntervalSinceDate:getStoredDate];
        
        if (diff >= timeOutMinutes){
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kSBApplicationDidTimeoutNotification
                                                                object:nil];
            
        }
        
    }

}

```
Add Time Out Notification Observer in `didFinishLaunchingWithOptions` - AppDelegate 

```objective-c

    // Observer the touch event
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidTimeout:)
                                                 name:kSBApplicationDidTimeoutNotification
                                               object:nil];

```

LogOut Functionality - AppDelegate 

```objective-c

- (void)applicationDidTimeout:(NSNotification *)notification
{

    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"SBLoggedIn"]) {
        
        self.alertView=[[UIAlertView alloc] initWithTitle:@"LoggedOut!" message:@"Sorry!!!, You have been logged out due to inactivity. Please LogIn to continue" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [self.alertView show];
        
        [self performSelector:@selector(performRootViewController) withObject:nil afterDelay:5.0f];
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SBLoggedIn"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SB_Date_Key"];

    }

}

-(void)performRootViewController {
    
    [self.alertView dismissWithClickedButtonIndex:0 animated:YES];
    [self loadLogInRootController];
}

```

[sbswiftytimeout-url]: https://github.com/SankarLal/SBSwiftyTimeOut/

## Contact
sankarlal20@gmail.com

## License

SBTimeOut is available under the MIT license.

Copyright © 2016 SBTimeOut

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
