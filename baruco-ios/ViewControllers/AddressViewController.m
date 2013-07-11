//
//  AddressViewController.m
//  GoldenLine
//
//  Created by Adam Lipka on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MapView.h"
#import "Address.h"
#import "AddressViewController.h"
#import "UIBarButtonItem+customButton.h"

@interface AddressViewController ()

@end

@implementation AddressViewController {
    MapView *mapView;
}

- (id)initWithAddress:(Address *)newAddress
{
    self = [super init];
    if (self) {
        address = newAddress;

        [self setupNavTitle:address.name];
        UIBarButtonItem *left = [[UIBarButtonItem alloc] buttonWithImage:[UIImage imageNamed:@"back_button.png"] activeImage:[UIImage imageNamed:@"back_button_active.png"] target:self action:@selector(didPressBack)];
        [left setEnabled:TRUE];
        [[self navigationItem] setLeftBarButtonItem:left];
    }
    return self;
}

- (void)didPressBack {
    [[self navigationController] popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    mapView = [[MapView alloc] initWithFrame:CGRectMake(0, 0, 320, 417)];
    [mapView showAddress:address];
    [self.view addSubview:mapView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
