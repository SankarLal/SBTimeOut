



#import "SBLogInViewController.h"
#import "SBHomeViewController.h"

@interface SBLogInViewController ()

@end

@implementation SBLogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"SBLOGIN";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *logInButton = [UIButton buttonWithType:UIButtonTypeCustom];
    logInButton.frame = CGRectMake(10, self.view.frame.size.height / 2 - 30, self.view.frame.size.width - 20, 60);
    [logInButton setTitle:@"SBLOGIN" forState:UIControlStateNormal];
    [logInButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    logInButton.backgroundColor = [UIColor purpleColor];
    [logInButton addTarget:self action:@selector(performLoginButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logInButton];
    
}

-(void)performLoginButton {
    
    [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"SBLoggedIn"];
    
    [self.navigationController pushViewController:[[SBHomeViewController alloc] init] animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
