




#import "SBHomeViewController.h"

@interface SBHomeViewController () <UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *webView;
@property(strong, nonatomic) UIBarButtonItem *barBtn_Rewind, *barBtn_Stop, *barBtn_FastForward;

@end

@implementation SBHomeViewController

@synthesize webView;
@synthesize barBtn_Rewind, barBtn_Stop, barBtn_FastForward;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"SBHOME";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.hidesBackButton = YES;
    [self setUpUserInterface];
}

#pragma mark - SetUp User Interface
-(void)setUpUserInterface {
    
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 44)];
    webView.delegate = self;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://github.com/SankarLal?tab=repositories"]]];
    [self.view addSubview:webView];
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 44, self.view.frame.size.width, 44)];
    [self.view addSubview:toolBar];
    
    UIBarButtonItem *flexiableItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
   barBtn_Rewind = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Back"] style:UIBarButtonItemStylePlain target:self action:@selector(peformRewindBarButton)];
    
    barBtn_Stop = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(peformStopBarButton)];
    
    UIBarButtonItem *barBtn_Refresh = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(peformRefreshBarButton)];
    
    barBtn_FastForward = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Forward"] style:UIBarButtonItemStylePlain target:self action:@selector(peformFastForwardBarButton)];
    
    
    NSArray *items = [NSArray arrayWithObjects:barBtn_Rewind, flexiableItem, barBtn_Stop, flexiableItem, barBtn_Refresh, flexiableItem, barBtn_FastForward, nil];
    
    [toolBar setItems:items];

    [self updateToolBarItems];

}

#pragma mark - ToolBar Button Actoins
-(void)peformRewindBarButton {
    [webView goBack];
}

-(void)peformStopBarButton {
    [webView stopLoading];
}

-(void)peformRefreshBarButton {
    [webView reload];
}

-(void)peformFastForwardBarButton {
    [webView goForward];
}

#pragma mark - Update ToolBar Items
-(void)updateToolBarItems {
    
    barBtn_Rewind.enabled = webView.canGoBack;
    barBtn_Stop.enabled = webView.loading;
    barBtn_FastForward.enabled = webView.canGoForward;
}

#pragma mark WebView Delegate Functions

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    // starting the load, show the activity indicator in the status bar
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self updateToolBarItems];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // finished loading, hide the activity indicator in the status bar
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self updateToolBarItems];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    // load error, hide the activity indicator in the status bar
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self updateToolBarItems];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
