//
//  AgendaDetailViewController.m
//  baruco-ios
//
//  Created by Piotr Debosz on 8/17/12.
//  Copyright (c) 2012 EL Passion. All rights reserved.
//

#import "AgendaDetailViewController.h"
#import "UIBarButtonItem+customButton.h"
#import "BService.h"
#import "Speaker.h"
#import "UIImageView+AFNetworking.h"
#import "UILabel+AlignTop.h"
#import "LinkedLabel.h"

@interface AgendaDetailViewController ()

@end

@implementation AgendaDetailViewController {
}

- (id)initWithAgenda:(Agenda *)_agenda {
    agenda = _agenda;
    
    self = [super init];
    
    if (self) {
//        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//        [params setValue:agenda.objectId forKey:@"objectId"];
        
//        [[BService sharedInstance] updateObject:agenda delegate:self];

        [self setupNavTitle:@"AGENDA"];
    	UIBarButtonItem *left = [[UIBarButtonItem alloc] buttonWithImage:[UIImage imageNamed:@"back_button.png"] activeImage:[UIImage imageNamed:@"back_button_active.png"] target:self action:@selector(didPressBack)];
        [left setEnabled:TRUE];
        [[self navigationItem] setLeftBarButtonItem:left];
    }
    
    return self;
}

- (void)didPressBack {
    [[self navigationController] popViewControllerAnimated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)BServiceDidLoadObject:(id)JSON {
    NSLog(@"ADVC - didLoadObject");
//    [agenda updateAttributes:JSON];

    NSLog(@"UPDATEDDDDDDDDDDDD %@", agenda);
}

- (void)BServiceDidFailLoadingObject:(NSError *)error {
    NSLog(@"ADVC - error !");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self prepareMainView];
}

- (void)prepareMainView {
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 417)];
//    [scrollView setBackgroundColor:[UIColor whiteColor]];
    float offset = 0;
    
    NSOrderedSet *speakers = [agenda valueForKey:@"speakers"];

    for (Speaker *speaker in speakers) {
        float voffset = 80;

        UIView *currentUserView = [[UIView alloc] initWithFrame:CGRectMake(0, offset, 320, 137)];
        [currentUserView setBackgroundColor:[UIColor colorWithRed:251/255.0 green:191/255.0 blue:37/255.0 alpha:1]];

        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(110, 14, 220, 30)];
        [name setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:23]];
        [name setTextColor:[UIColor colorWithRed:193/255.0 green:40/255.0 blue:15/255.0 alpha:1]];
        [name setText:speaker.name];
        [name setBackgroundColor:[UIColor clearColor]];
        [name alignTop];
        [currentUserView addSubview:name];

        UIImageView *avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 80, 80)];
//        [avatarView setImageWithURL:[NSURL URLWithString:speaker.imageUrl]];
        [avatarView setImage:speaker.avatar];
        [currentUserView addSubview:avatarView];

        UITextView *tagline = [[UITextView alloc] initWithFrame:CGRectMake(103, 35, 220, 10)];
        [tagline setUserInteractionEnabled:FALSE];
        [tagline setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15]];
        [tagline setBackgroundColor:[UIColor clearColor]];
        [tagline setEditable:FALSE];
        [tagline setText:speaker.tagline];
        [currentUserView addSubview:tagline];

        CGRect frame = tagline.frame;
        frame.size.height = tagline.contentSize.height;
        if (frame.size.height > voffset) {
            voffset = frame.size.height;
            [currentUserView setFrame:CGRectMake(0, offset, 320, voffset + 57)];
        }
        [tagline setFrame:frame];

        UIImageView *githubIcon = [[UIImageView alloc] initWithFrame:CGRectMake(20, voffset + 31.5, 15, 13)];
        [githubIcon setImage:[UIImage imageNamed:@"github_icon.png"]];
        LinkedLabel *gitHub = [[LinkedLabel alloc] initWithFrame:CGRectMake(38, voffset + 30, 220, 15)];
//        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openURL:)];
//        [gitHub addGestureRecognizer:tapGestureRecognizer];
        [gitHub setUrl:[NSURL URLWithString:[NSString stringWithFormat:@"https://github.com/%@", speaker.github]]];
        [gitHub setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:14]];
        [gitHub setTextColor:[UIColor colorWithRed:193/255.0 green:40/255.0 blue:15/255.0 alpha:1]];
        NSString *fullGitHub = [NSString stringWithFormat:@"%@",speaker.github];
        [gitHub setText:fullGitHub];
        [gitHub setBackgroundColor:[UIColor clearColor]];
        [gitHub alignTop];
        [currentUserView addSubview:githubIcon];
        [currentUserView addSubview:gitHub];

        CGSize gitSize = [fullGitHub sizeWithFont:gitHub.font];
        UIImageView *tweetIcon = [[UIImageView alloc] initWithFrame:CGRectMake(gitHub.frame.origin.x + gitSize.width + 15, voffset + 31.5, 16, 13)];
        [tweetIcon setImage:[UIImage imageNamed:@"twiter_icon.png"]];
        NSString *tweeterName = [NSString stringWithFormat:@"%@", speaker.twitter];
        LinkedLabel *twitter = [[LinkedLabel alloc] initWithFrame:CGRectMake(tweetIcon.frame.origin.x + tweetIcon.frame.size.width + 4, voffset + 30, 220, 15)];
        [twitter setUrl:[NSURL URLWithString:[NSString stringWithFormat:@"https://mobile.twitter.com/%@", speaker.twitter]]];
//        UITapGestureRecognizer *tweeterGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loadTweeter:)]
        [twitter setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:14]];
        [twitter setTextColor:[UIColor colorWithRed:193/255.0 green:40/255.0 blue:15/255.0 alpha:1]];
        [twitter setText:tweeterName];
        [twitter setBackgroundColor:[UIColor clearColor]];
        [twitter alignTop];
        [currentUserView addSubview:tweetIcon];
        [currentUserView addSubview:twitter];

        CGSize twitterSize = [tweeterName sizeWithFont:twitter.font];

        LinkedLabel *website = [[LinkedLabel alloc] initWithFrame:CGRectMake(twitter.frame.origin.x + twitterSize.width + 15, voffset + 30, 100, 15)];
        [website setUrl:[NSURL URLWithString:speaker.website]];
        if (website.frame.origin.x > 270) {
            [tweetIcon setFrame:CGRectMake(gitHub.frame.origin.x + gitSize.width + 8, 112, 16, 13)];
            [twitter setFrame:CGRectMake(tweetIcon.frame.origin.x + tweetIcon.frame.size.width + 4, 110, 220, 15)];
            [website setFrame:CGRectMake(twitter.frame.origin.x + twitterSize.width + 8, 110, 100, 15)];
        }
        [website setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:14]];
        [website setTextColor:[UIColor colorWithRed:193/255.0 green:40/255.0 blue:15/255.0 alpha:1]];
        [website setText:@"website"];
        [website setBackgroundColor:[UIColor clearColor]];
        [website alignTop];
        [currentUserView addSubview:website];

        offset += currentUserView.frame.size.height;

        [scrollView addSubview:currentUserView];
    }

    UIView *bodyView = [[UIView alloc] initWithFrame:CGRectMake(0, offset, 320, 0)];
    [bodyView setBackgroundColor:[UIColor whiteColor]];
    [scrollView addSubview:bodyView];

    UILabel *dateTime = [[UILabel alloc] initWithFrame:CGRectMake(20, offset + 10, 250, 15)];
    [dateTime setFont:[UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:14]];
    [dateTime setTextColor:[UIColor colorWithRed:193/255.0 green:40/255.0 blue:15/255.0 alpha:1]];
    [dateTime setText:agenda.sDateTime];
    [dateTime setBackgroundColor:[UIColor clearColor]];
    [dateTime alignTop];
    [scrollView addSubview:dateTime];

    offset += 25;

    UITextView *mainTitle = [[UITextView alloc] initWithFrame:CGRectMake(12, offset, 250, 10)];
    [mainTitle setUserInteractionEnabled:FALSE];
    [mainTitle setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:20]];
    [mainTitle setEditable:FALSE];

    [mainTitle setText:agenda.subtitle];
    [scrollView addSubview:mainTitle];

    CGRect frame = mainTitle.frame;
    frame.size.height = mainTitle.contentSize.height;
    [mainTitle setFrame:frame];

    [mainTitle setTextColor:[UIColor blackColor]];
    [mainTitle setBackgroundColor:[UIColor clearColor]];

    offset += frame.size.height;

    UITextView *desc = [[UITextView alloc] initWithFrame:CGRectMake(12, offset, 290, 100)];
    [desc setUserInteractionEnabled:FALSE];
    [desc setEditable:FALSE];
    [desc setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [desc setText:agenda.desc];
    [scrollView addSubview:desc];

    frame = desc.frame;
    frame.size.height = desc.contentSize.height;
    [desc setFrame:frame];

    offset += frame.size.height + 10;

    [scrollView setContentSize:CGSizeMake(320, offset)];
    [scrollView setAlwaysBounceVertical:TRUE];

    CGRect bodyFrame = bodyView.frame;
    bodyFrame.size.height = offset - bodyFrame.origin.y;
    [bodyView setFrame:bodyFrame];

    [self.view addSubview:scrollView];
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
