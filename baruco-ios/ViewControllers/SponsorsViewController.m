//
//  SponsorsViewController.m
//  baruco-ios
//
//  Created by Adam Lipka on 05.08.2012.
//  Copyright (c) 2012 EL Passion. All rights reserved.
//

#import "SponsorsViewController.h"
#import "Sponsor.h"

@interface SponsorsViewController ()

@end

@implementation SponsorsViewController

- (id)init
{
    self = [super init];
    if (self) {
        NSLog(@"SPONSORS VC init");
        [self setupNavTitle:@"SPONSORS"];
    }
    return self;
}

-(void)safeClear {
    [mainView setDelegate:nil];
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSDictionary *dictionary;
    [[BService sharedInstance] loadObjects:[Sponsor class] queryParams:dictionary delegate:self];
    mainView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 417)];
    mainView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 417)];
    [mainView setDelegate:self];
    mainView.scalesPageToFit = YES;
    mainView.contentMode = UIViewContentModeScaleAspectFill;
    [mainView loadHTMLString:[Sponsor html] baseURL:nil];
    [mainView setUserInteractionEnabled:TRUE];
    [mainView setBackgroundColor:[UIColor clearColor]];
    [mainView setOpaque:FALSE];
    [self.view addSubview:mainView];
}

-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }

    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"TEREREFEFEFEEREFEF");
}

-(void)BServiceDidUpdateObjects {
    [mainView loadHTMLString:[Sponsor html] baseURL:[NSURL URLWithString:@"http://baruco.org/"]];
}


-(void)BServiceDidntUpdateObjects {
    NSLog(@"NOTHING NEW WITH SPONSORS");
}

- (void)BServiceDidFailLoadingObjects:(NSError *)error {
    NSLog(@"AGENDAVC - DidFailLoadingObjects, error: %@", error);
}

- (void)BServiceDidLoadObjects:(NSArray *)objects {

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
