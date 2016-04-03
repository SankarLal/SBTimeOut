



#import "SBTimeOut.h"

@implementation SBTimeOut

- (void)sendEvent:(UIEvent *)event {
    [super sendEvent:event];
    
    // Check to see if there was a touch event
    NSSet *allTouches = [event allTouches];
    
    if ([allTouches count] > 0) {
        
        UITouchPhase phase = ((UITouch *)[allTouches anyObject]).phase;
        if (phase == UITouchPhaseBegan) {
            [self resetIdleTimer];
        }
        
    }
}

- (void)resetIdleTimer
{
    if (self._idleTimer) {
        [self._idleTimer invalidate];
        self._idleTimer = nil;
    }
    
    // Schedule a timer to fire in kSBApplicationTimeoutInMinutes * 60
    int timeout = kSBApplicationTimeoutInMinutes * 60;
    self._idleTimer = [NSTimer scheduledTimerWithTimeInterval:timeout
                                                       target:self
                                                     selector:@selector(idleTimerExceeded)
                                                     userInfo:nil
                                                      repeats:NO];
    
    // Set Current Time
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"SB_Date_Key"];
}

- (void)idleTimerExceeded {
    /* Post a notification so anyone who subscribes to it can be notified when
     * the application times out */
    [[NSNotificationCenter defaultCenter] postNotificationName:kSBApplicationDidTimeoutNotification
                                                        object:nil];
}


@end
