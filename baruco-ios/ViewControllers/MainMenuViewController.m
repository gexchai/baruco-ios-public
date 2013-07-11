//
//  MainMenuViewController.m
//  baruco-ios
//
//  Created by Adam Lipka on 04.08.2012.
//  Copyright (c) 2012 EL Passion. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>
#import "MainMenuViewController.h"
#import "MenuButton.h"
#import "MenuButton.h"
#import "NewsViewController.h"
#import "AgendaViewController.h"
#import "SponsorsViewController.h"
#import "LocationViewController.h"
#import "BarucoAppDelegate.h"
#import "DDMenuController.h"

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController

- (id)init;
{
    self = [super init];
    if (self) {
        NSLog(@"MENU INITITTITI");
        // Custom initialization
        appDelegate = (BarucoAppDelegate *) [[UIApplication sharedApplication] delegate];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showNews:) name:@"showNews" object:nil];
    }
    return self;
}

- (void)showNews:(NSNotification *)notification {
    NSLog(@"showNews !");
    [newsButton sendActionsForControlEvents:UIControlEventTouchUpInside];
}

- (void)selectedMenu:(id)selectedMenu {
    NSLog(@"didPressSelectedMenu !");
    [currentlySelected setSelected:FALSE];
    [selectedMenu setSelected:TRUE];
    currentlySelected = selectedMenu;
//    [currentlySelected setSelected:TRUE];
    NSLog(@"%@", [(MenuButton *)selectedMenu titleLabel].text);
    BarucoViewController *controller;
    controller = [[currentlySelected.controllerClass alloc] init];
    [appDelegate.rootController setRootController:controller animated:TRUE];
    [appDelegate setCurrentlyRoot:controller];
//    [appDelegate.rootController setLeftController:self];
}

-(void)loadView {
    [super loadView];
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu_background.png"]];
    [self.view addSubview:background];

    UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"baruco_logo.png"]];
    CGRect frame = logo.frame;
    [logo setFrame:CGRectMake(95, 360, frame.size.width, frame.size.height)];
    [self.view addSubview:logo];

    newsButton = [[MenuButton alloc] initWithPoint:CGPointMake(-1, 42)];
    UIImageView *newsIcon = [[UIImageView alloc] initWithFrame:CGRectMake(52, 48, 37, 37)];
    [newsIcon setImage:[UIImage imageNamed:@"news.png"]];
    [newsButton addSubview:newsIcon];
    [newsButton setMainColor:[UIColor colorWithRed:251/255.0 green:199/255.0 blue:37/255.0 alpha:1]];
    [newsButton addTarget:self action:@selector(selectedMenu:) forControlEvents:UIControlEventTouchUpInside];
    [newsButton setTitle:@"NEWS" forState:UIControlStateNormal];
    [self.view addSubview:newsButton];
    [newsButton setSelected:TRUE];
    [newsButton setControllerClass:[NewsViewController class]];
    currentlySelected = newsButton;

    agendaButton = [[MenuButton alloc] initWithPoint:CGPointMake(140, 42)];
    UIImageView *agendaIcon = [[UIImageView alloc] initWithFrame:CGRectMake(50, 50, 36, 36)];
    [agendaIcon setImage:[UIImage imageNamed:@"agenda.png"]];
    [agendaButton addSubview:agendaIcon];
    [agendaButton setMainColor:[UIColor colorWithRed:184/255.0 green:56/255.0 blue:39/255.0 alpha:1]];
    [agendaButton addTarget:self action:@selector(selectedMenu:) forControlEvents:UIControlEventTouchUpInside];
    [agendaButton setTitle:@"AGENDA" forState:UIControlStateNormal];
    [agendaButton setControllerClass:[AgendaViewController class]];
    [self.view addSubview:agendaButton];

    sponsorsButton = [[MenuButton alloc] initWithPoint:CGPointMake(-1, 183)];
    UIImageView *sponsorsIcon = [[UIImageView alloc] initWithFrame:CGRectMake(53, 50, 36, 36)];
    [sponsorsIcon setImage:[UIImage imageNamed:@"sponsors.png"]];
    [sponsorsButton addSubview:sponsorsIcon];
    [sponsorsButton setMainColor:[UIColor colorWithRed:41/255.0 green:162/255.0 blue:157/255.0 alpha:1]];
    [sponsorsButton addTarget:self action:@selector(selectedMenu:) forControlEvents:UIControlEventTouchUpInside];
    [sponsorsButton setTitle:@"SPONSORS" forState:UIControlStateNormal];
    [sponsorsButton setControllerClass:[SponsorsViewController class]];
    [self.view addSubview:sponsorsButton];

    locationButton = [[MenuButton alloc] initWithPoint:CGPointMake(140, 183)];
    UIImageView *locationIcon = [[UIImageView alloc] initWithFrame:CGRectMake(50, 50, 36, 36)];
    [locationIcon setImage:[UIImage imageNamed:@"location.png"]];
    [locationButton addSubview:locationIcon];
    [locationButton setMainColor:[UIColor colorWithRed:153/255.0 green:155/255.0 blue:158/255.0 alpha:1]];
    [locationButton addTarget:self action:@selector(selectedMenu:) forControlEvents:UIControlEventTouchUpInside];
    [locationButton setTitle:@"LOCATION" forState:UIControlStateNormal];
    [locationButton setControllerClass:[LocationViewController class]];
    [self.view addSubview:locationButton];

    UIView *topBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    [topBar setBackgroundColor:[UIColor colorWithRed:41/255.0 green:162/255.0 blue:157/255.0 alpha:1]];
    topBar.layer.shadowColor = [[UIColor blackColor] CGColor];
    topBar.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    topBar.layer.shadowRadius = 3.0f;
    topBar.layer.shadowOpacity = .5f;
    UILabel *barcelona = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 120, 44)];
    [barcelona setBackgroundColor:[UIColor clearColor]];
    [barcelona setFont:[UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:18]];
    [barcelona setText:@"BARCELONA"];
    [barcelona setTextColor:[UIColor whiteColor]];
    [topBar addSubview:barcelona];
    UILabel *conference = [[UILabel alloc] initWithFrame:CGRectMake(112, 2.5, 120, 44)];
    [conference setBackgroundColor:[UIColor clearColor]];
    [conference setFont:[UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:11]];
    [conference setText:@"Ruby Conference"];
    [conference setTextColor:[UIColor whiteColor]];
    [topBar addSubview:conference];
    [self.view addSubview:topBar];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
