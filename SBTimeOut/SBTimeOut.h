



#import <UIKit/UIKit.h>

// # of minutes before application times out
#define kSBApplicationTimeoutInMinutes 1

// Notification that gets sent when the timeout occurs
#define kSBApplicationDidTimeoutNotification @"SBApplicationDidTimeout"

/**
 * This is a subclass of UIApplication with the sendEvent: method
 * overridden in order to catch all touch events.
 */

@interface SBTimeOut : UIApplication

@property (strong,nonatomic) NSTimer *_idleTimer;
/**
 * Resets the idle timer to its initial state. This method gets called
 * every time there is a touch on the screen.  It should also be called
 * when the user correctly enters their pin to access the application.
 */
- (void)resetIdleTimer;

@end
