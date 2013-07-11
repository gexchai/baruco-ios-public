//
//  NewsDetailViewController.m
//  baruco-ios
//
//  Created by Piotr Paweł Dębosz on 26.08.2012.
//  Copyright (c) 2012 EL Passion. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "UIBarButtonItem+customButton.h"
#import "UILabel+AlignTop.h"
#import "BarucoAppDelegate.h"
#import <QuartzCore/QuartzCore.h>

@interface NewsDetailViewController ()

@end

@implementation NewsDetailViewController

- (id)initWithNews:(News *)_news {
    
    news = _news;
    
    self = [super init];
    
    if (self) {
        [self setupNavTitle:@"NEWS"];
    	UIBarButtonItem *left = [[UIBarButtonItem alloc] buttonWithImage:[UIImage imageNamed:@"back_button.png"] activeImage:[UIImage imageNamed:@"back_button_active.png"] target:self action:@selector(didPressBack)];
        [left setEnabled:TRUE];
        [[self navigationItem] setLeftBarButtonItem:left];
    }

    [news addObserver:self
           forKeyPath:@"image"
              options:NSKeyValueObservingOptionNew
              context:nil];
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    NSLog(@"Should reloadddddddd");
    [self prepareView];
}

- (void)didPressBack {
    [news removeObserver:self forKeyPath:@"image"];
    [[self navigationController] popViewControllerAnimated:YES];
}

- (void)prepareView
{
    if (scroll) {
        [scroll removeFromSuperview];
    }

    scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 417)];
    [scroll setAlwaysBounceVertical:TRUE];
    [self.view addSubview:scroll];
    
    background = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)];
    [background setBackgroundColor:[UIColor whiteColor]];
    [scroll addSubview:background];
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
    [header setBackgroundColor:[UIColor colorWithRed:251/255.0 green:191/255.0 blue:37/255.0 alpha:1]];
    
    [scroll addSubview:header];
    
    UILabel *mainTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 280, 42)];
    [mainTitle setBackgroundColor:[UIColor clearColor]];
    [mainTitle setNumberOfLines:2];
    
    [mainTitle setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:17]];
    [mainTitle setTextColor:[UIColor colorWithRed:37/255.0 green:37/255.0 blue:37/255.0 alpha:1]];
    [mainTitle setText:news.title];
    [mainTitle alignTop];
    [header addSubview:mainTitle];
    
    UILabel *dateTime = [[UILabel alloc] initWithFrame:CGRectMake(20, 57, 250, 15)];
    [dateTime setFont:[UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:14]];
    [dateTime setTextColor:[UIColor colorWithRed:193/255.0 green:40/255.0 blue:15/255.0 alpha:1]];
    [dateTime setText:news.sDateTime];
    [dateTime setBackgroundColor:[UIColor clearColor]];
    [dateTime alignTop];
    [scroll addSubview:dateTime];
    
    mainWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 90, 320, 337)];
    [mainWebView setBackgroundColor:[UIColor blueColor]];
    [mainWebView setUserInteractionEnabled:TRUE];
    [mainWebView setBackgroundColor:[UIColor clearColor]];
    [mainWebView setOpaque:FALSE];
    [mainWebView loadHTMLString:[self prepareHtml] baseURL:nil];
    [mainWebView setDelegate:self];
    mainWebView.scrollView.bounces = NO;
    
    NSLog(@"NEWSS PHOTO %@", news.imageUrl);
    
    if (news.photo) {
        mainImageView = [[UIImageView alloc] initWithImage:news.photo];
        CGSize size = news.photo.size;
        
        size.height = size.height/2;
        size.width = size.width/2;
        
        NSLog(@"PHOOOOTOTOTOOT SIZEEE %@", NSStringFromCGSize(size));
        
        CGRect frame = CGRectMake(2, 2, size.width, size.height);
        [mainImageView setFrame:frame];
        
        border = [[UIView alloc] initWithFrame:CGRectMake((320-size.width-4)/2, 80+337+3, frame.size.width + 4, frame.size.height + 4)];
        [border setBackgroundColor:[UIColor whiteColor]];
        border.layer.borderColor = [[UIColor colorWithRed:187/255.0 green:187/255.0 blue:187/255.0 alpha:1] CGColor];
        border.layer.borderWidth = 1.0;
        
        [border addSubview:mainImageView];
        
        [scroll addSubview:border];
        //    [scroll setBackgroundColor:[UIColor whiteColor]];
        [scroll setContentSize:CGSizeMake(320, border.frame.origin.y + border.frame.size.height + 10)];
    }
    else if (news.imageUrl) {
        [[BService sharedInstance] loadImage:news.imageUrl delegate:news];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self prepareView];


	// Do any additional setup after loading the view.
}

-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }

    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *output = [mainWebView stringByEvaluatingJavaScriptFromString:@"document.getElementById(\"news\").offsetHeight;"];
    float newHeight = [output floatValue] + 32;
    [mainWebView setFrame:CGRectMake(mainWebView.frame.origin.x, mainWebView.frame.origin.y, mainWebView.frame.size.width, newHeight)];
    [scroll addSubview:mainWebView];
    float cgsizeHeight;

    if (border) {
        CGRect imageFrame = [border frame];
        imageFrame.origin.y = mainWebView.frame.origin.y + newHeight;
        [border setFrame:imageFrame];
        cgsizeHeight = border.frame.origin.y + border.frame.size.height + 10;
    }
    else {
        cgsizeHeight = mainWebView.frame.origin.y + mainWebView.frame.size.height + 10;
    }

    [scroll setContentSize:CGSizeMake(320, cgsizeHeight)];
    [background setFrame:CGRectMake(0, 0, 320, scroll.contentSize.height)];
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

-(NSString *)prepareHtml {
    NSString *rawHtml = @"<!DOCTYPE html>\n"
            "<html lang=\"en\">\n"
            "  <head>\n"
            "    <meta charset=\"utf-8\" />\n"
            "    <meta name=\"viewport\" content=\"width=320, user-scalable=0\" />\n"
            "    <style type=\"text/css\" media=\"screen\">\n"
            "      body {\n"
            "        background: #fff;\n"
            "        color: #252525;\n"
            "        font-size: 14px;\n"
            "        line-height: 18px;\n"
            "        font-family: \"Helvetica Neue\";\n"
            "      }\n"
            "      \n"
            "      #news {\n"
            "        margin: 8px 12px;\n"
            "      }\n"
            "      \n"
            "      a {\n"
            "        color: #B43E1F;\n"
            "        font-weight: bold;\n"
            "        text-decoration: none;\n"
            "      }\n"
            "    </style>\n"
            "    <title></title>\n"
            "  </head>\n"
            "  <body>\n"
            "    <div id=\"news\">\n"
            "      <p>\n"
            "        <new_body_html>\n"
            "      </p>\n"
            "    </div> <!-- /news -->\n"
            "  </body>\n"
            "</html>";
    return [rawHtml stringByReplacingOccurrencesOfString:@"<new_body_html>" withString:news.body];
}

@end
