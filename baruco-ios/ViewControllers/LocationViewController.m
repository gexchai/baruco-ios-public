//
//  LocationViewController.m
//  baruco-ios
//
//  Created by Adam Lipka on 05.08.2012.
//  Copyright (c) 2012 EL Passion. All rights reserved.
//

#import "LocationViewController.h"
#import "MapView.h"
#import "Address.h"
#import <QuartzCore/QuartzCore.h>
#import "CoreLocation/CLLocation.h"
#import "AddressViewController.h"


@interface LocationViewController ()

@end

@implementation LocationViewController

- (id)init
{
    self = [super init];
    if (self) {
        NSLog(@"LOCATION VC init");
        [self setupNavTitle:@"LOCATION"];
        float offset = 0;

        UIScrollView *mainScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 417)];
        [mainScroll setAlwaysBounceVertical:TRUE];
//        [mainScroll setBackgroundColor:[UIColor whiteColor]];
        
        background = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)];
        [background setBackgroundColor:[UIColor whiteColor]];
        [mainScroll addSubview:background];
        

        UIView *conferenceBanner = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 35)];
        [conferenceBanner setBackgroundColor:[UIColor colorWithRed:251/255.0 green:191/255.0 blue:37/255.0 alpha:1]];

        UILabel *conferenceTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 290, 35)];
        [conferenceTitle setBackgroundColor:[UIColor clearColor]];
        [conferenceTitle setFont:[UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:15]];
        [conferenceTitle setTextColor:[UIColor whiteColor]];
        [conferenceTitle setShadowColor:[UIColor grayColor]];
        [conferenceTitle setShadowOffset:CGSizeMake(0, 1)];
        [conferenceTitle setText:@"CONFERENCE"];
        [conferenceBanner addSubview:conferenceTitle];
        [mainScroll addSubview:conferenceBanner];

        offset += 35;

        UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0, offset, 320, 160)];
        [container setBackgroundColor:[UIColor clearColor]];
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loadAddressView)];
        [container addGestureRecognizer:tapGestureRecognizer];
        MapView *mapView = [[MapView alloc] initWithFrame:CGRectMake(0, 0, 320, 160)];
        mapView.layer.cornerRadius = 2;
        mapView.layer.borderWidth = 1;
        mapView.layer.borderColor = [[UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1]CGColor];

        congressAddress = [[Address alloc] init];
        [congressAddress setPosition:[[CLLocation alloc] initWithLatitude:41.413258 longitude:2.131032]];
        [congressAddress setName:@"CosmoCaixa"];
        [congressAddress setStreet:@"Isaac Newton"];
        [congressAddress setNumber:@"26"];

        [mapView showAddress:congressAddress];
        [mapView centreAtAddress:congressAddress];
        [mapView setUserInteractionEnabled:FALSE];
        [container addSubview:mapView];

        offset += 160;

        UIImageView *conferenceHints = [[UIImageView alloc] initWithFrame:CGRectMake(0, offset, 320, 135)];
        [conferenceHints setImage:[UIImage imageNamed:@"cosmo_caixa.png"]];
        [mainScroll addSubview:conferenceHints];

        offset += conferenceHints.frame.size.height + 5;

//        UILabel *cosmoTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, offset, 280, 20)];
//        [cosmoTitle setBackgroundColor:[UIColor clearColor]];
//        [cosmoTitle setFont:[UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:15]];
//        [cosmoTitle setText:@"CosmoCaixa building"];
//        [mainScroll addSubview:cosmoTitle];
//
//        offset += 25;

        UIImageView *cosmoImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, offset, 280, 166)];
        [cosmoImage setImage:[UIImage imageNamed:@"conference.jpeg"]];
        [mainScroll addSubview:cosmoImage];

        offset += 166 + 20;

        UIView *partyBanner = [[UIView alloc] initWithFrame:CGRectMake(0, offset, 320, 35)];
        [partyBanner setBackgroundColor:[UIColor colorWithRed:251/255.0 green:191/255.0 blue:37/255.0 alpha:1]];

        UILabel *partyTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 290, 35)];
        [partyTitle setBackgroundColor:[UIColor clearColor]];
        [partyTitle setFont:[UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:15]];
        [partyTitle setTextColor:[UIColor whiteColor]];
        [partyTitle setShadowColor:[UIColor grayColor]];
        [partyTitle setShadowOffset:CGSizeMake(0, 1)];
        [partyTitle setText:@"BEACH PARTY"];
        [partyBanner addSubview:partyTitle];
        [mainScroll addSubview:partyBanner];

        offset += 35;

        UIView *partyContainer = [[UIView alloc] initWithFrame:CGRectMake(0, offset, 320, 160)];
        [partyContainer setBackgroundColor:[UIColor clearColor]];
        UITapGestureRecognizer *partyTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loadPartyAddressView)];
        [partyContainer addGestureRecognizer:partyTapGestureRecognizer];
        MapView *partyMapView = [[MapView alloc] initWithFrame:CGRectMake(0, 0, 320, 160)];
        partyMapView.layer.cornerRadius = 2;
        partyMapView.layer.borderWidth = 1;
        partyMapView.layer.borderColor = [[UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1]CGColor];
        partyAddress = [[Address alloc] init];
        [partyAddress setPosition:[[CLLocation alloc] initWithLatitude:41.405051 longitude:2.21851]];
        [partyAddress setName:@"Bambú, Beach Bar"];
        [partyAddress setStreet:@"Playa llevant, Poble Nou"];
        [partyAddress setNumber:@""];

        [partyMapView showAddress:partyAddress];
        [partyMapView centreAtAddress:partyAddress];
        [partyMapView setUserInteractionEnabled:FALSE];
        [partyContainer addSubview:partyMapView];
        [mainScroll addSubview:partyContainer];

        //        UIImageView *accessoryView = [[UIImageView alloc] initWithFrame:CGRectMake(205, 45, 9.5, 15)];
        //        [accessoryView setImage:[UIImage imageNamed:@"accessoryImage.png"]];
        //        [container addSubview:accessoryView];

        offset += 160;

        UIImageView *partyHints = [[UIImageView alloc] initWithFrame:CGRectMake(0, offset, 320, 190)];
        [partyHints setImage:[UIImage imageNamed:@"beach_party.png"]];
        [mainScroll addSubview:partyHints];

        offset += partyHints.frame.size.height + 10;

//        UILabel *partyLabelTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, offset, 280, 20)];
//        [partyLabelTitle setBackgroundColor:[UIColor clearColor]];
//        [partyLabelTitle setFont:[UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:15]];
//        [partyLabelTitle setText:@"Beach party"];
//        [mainScroll addSubview:partyLabelTitle];
//
//        offset += 25;

        UIImageView *partyImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, offset, 280, 213.5)];
        [partyImage setImage:[UIImage imageNamed:@"party.png"]];
        [mainScroll addSubview:partyImage];

        offset += 213.5 + 20;

        [mainScroll addSubview:container];
        [mainScroll setContentSize:CGSizeMake(320, offset)];

        CGRect frame = background.frame;
        frame.size.height = offset;
        [background setFrame:frame];

        [self.view addSubview:mainScroll];
    }
    return self;
}

- (void)loadPartyAddressView {
    AddressViewController *addressVC = [[AddressViewController alloc] initWithAddress:partyAddress];
    [[self navigationController] pushViewController:addressVC animated:TRUE];
}

- (void)loadAddressView {
    AddressViewController *addressVC = [[AddressViewController alloc] initWithAddress:congressAddress];
    [[self navigationController] pushViewController:addressVC animated:TRUE];
}

-(void)loadView {
    [super loadView];
    NSLog(@"SHOULD INIT LOCATION VIEW");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    NSLog(@"LOCATION VIEW WILL BE CLEANEDDDDD");
}

//- (void)viewDidUnload
//{
//    [super viewDidUnload];
//    // Release any retained subviews of the main view.
//}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
