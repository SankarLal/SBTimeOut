



#import "AppDelegate.h"
#import "SBLogInViewController.h"
#import "SBHomeViewController.h"
#import "SBTimeOut.h"

@interface AppDelegate ()

@property (strong, nonnull) UINavigationController *rootNaviationController;
@property (strong, nonatomic) UIAlertView *alertView;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"SBLoggedIn"]) {
        
        [self loadHomeRootController];
        
    } else {
        
        [self loadLogInRootController];
    
    }
    // Observer the touch event
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidTimeout:)
                                                 name:kSBApplicationDidTimeoutNotification
                                               object:nil];
    
    // Remove the Date Key while App Launch
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SB_Date_Key"];

    return YES;
}

-(void)loadLogInRootController {
    
    self.rootNaviationController = [[UINavigationController alloc] initWithRootViewController:[[SBLogInViewController alloc] init]];
    
    self.window.rootViewController = self.rootNaviationController;
    [self.window makeKeyAndVisible];
    
}

-(void)loadHomeRootController {
    
    self.rootNaviationController = [[UINavigationController alloc] initWithRootViewController:[[SBHomeViewController alloc] init]];
    
    self.window.rootViewController = self.rootNaviationController;
    [self.window makeKeyAndVisible];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    // Get Stored Time Stamp
    [self getIdleTimeInMinutes];
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
 
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"SBLoggedIn"])
        [(SBTimeOut *)[UIApplication sharedApplication] resetIdleTimer];
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
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

@end
