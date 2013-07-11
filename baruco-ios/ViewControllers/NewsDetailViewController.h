//
//  NewsDetailViewController.h
//  baruco-ios
//
//  Created by Piotr Paweł Dębosz on 26.08.2012.
//  Copyright (c) 2012 EL Passion. All rights reserved.
//

#import "BarucoViewController.h"
#import "News.h"

@interface NewsDetailViewController : BarucoViewController <UIWebViewDelegate, NSNetServiceDelegate> {
    News *news;
    UIScrollView *scroll;
    UIWebView *mainWebView;
    UIImageView *mainImageView;
    UIView *border;
    UIView *background;
}

-(id)initWithNews:(News *)_news;

@end
