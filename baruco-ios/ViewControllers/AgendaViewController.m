//
//  AgendaViewController.m
//  baruco-ios
//
//  Created by Adam Lipka on 05.08.2012.
//  Copyright (c) 2012 EL Passion. All rights reserved.
//

#import "AgendaViewController.h"
#import "AgendaCell.h"
#import "AgendaDetailViewController.h"
#import "UIBarButtonItem+customButton.h"
#import "BarucoAppDelegate.h"
#import "ConferenceDay.h"

@interface AgendaViewController ()

@end

@implementation AgendaViewController {
}

- (id)init
{
    self = [super init];
    if (self) {
        NSLog(@"ADENDAVC init");
        [self setupNavTitle:@"AGENDA"];
        selectedDay = AgendaSaturday;
        satAgendas = [[NSMutableArray alloc] init];
        sunAgendas = [[NSMutableArray alloc] init];
        saturdayConference = [ConferenceDay dayWithName:@"saturday"];
        sundayConference = [ConferenceDay dayWithName:@"sunday"];
    }
    return self;
}

-(void)loadView {
    [super loadView];
    agendaTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 360)];
    [agendaTable setDataSource:self];
    [agendaTable setDelegate:self];
    [agendaTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [agendaTable setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:agendaTable];

    bottomBar = [[UIView alloc] initWithFrame:CGRectMake(0, 360, 320, 57)];
    [bottomBar setBackgroundColor:[UIColor blackColor]];
    
    sunday = [[UIButton alloc] initWithFrame:CGRectMake(160, 0, 160, 57)];
    [sunday setTitle:@"SUNDAY" forState:UIControlStateNormal];
    [sunday setTitleColor:[UIColor colorWithRed:251/255.0 green:191/255.0 blue:37/255.0 alpha:1] forState:UIControlStateSelected];
    [sunday.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:16]];
    [sunday setBackgroundImage:[UIImage imageNamed:@"unactive.png"] forState:UIControlStateNormal];
    [sunday setBackgroundImage:[UIImage imageNamed:@"active.png"] forState:UIControlStateSelected];
    [sunday setBackgroundImage:[UIImage imageNamed:@"active.png"] forState:UIControlStateHighlighted];
    [sunday addTarget:self action:@selector(didPressSunday:) forControlEvents:UIControlEventTouchUpInside];
    
    saturday = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 160, 57)];
    [saturday setTitle:@"SATURDAY" forState:UIControlStateNormal];
    [saturday setTitleColor:[UIColor colorWithRed:251/255.0 green:191/255.0 blue:37/255.0 alpha:1] forState:UIControlStateSelected];
    [saturday.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:16]];
    [saturday setBackgroundImage:[UIImage imageNamed:@"unactive.png"] forState:UIControlStateNormal];
    [saturday setBackgroundImage:[UIImage imageNamed:@"active.png"] forState:UIControlStateSelected];
    [saturday setBackgroundImage:[UIImage imageNamed:@"active.png"] forState:UIControlStateHighlighted];
    [saturday addTarget:self action:@selector(didPressSaturday:) forControlEvents:UIControlEventTouchUpInside];

    [bottomBar addSubview:sunday];
    [bottomBar addSubview:saturday];
    
    [self.view addSubview:bottomBar];
//    UIView *tapBar
}

- (void)didPressSunday:(id)sender {
    selectedDay = AgendaSunday;
    [agendaTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    [saturday setSelected:FALSE];
    [sunday setSelected:TRUE];
    [self getAgenda];
}

- (void)didPressSaturday:(id)sender {
    selectedDay = AgendaSaturday;
    [agendaTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    [sunday setSelected:FALSE];
    [saturday setSelected:TRUE];
    [self getAgenda];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[BService sharedInstance] loadObjects:[Agenda class] queryParams:[[NSDictionary alloc] init] delegate:self];
    // Do any additional setup after loading the view.

//    NSError **error;

}

- (void)BServiceDidFailLoadingObjects:(NSError *)error {
    NSLog(@"AGENDAVC - DidFailLoadingObjects, error: %@", error);
}

- (void)BServiceDidLoadObjects:(NSArray *)objects {

}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self getAgenda];
    if (!saturday.selected && !sunday.selected) {
        if (selectedDay == AgendaSaturday) {
            [saturday setSelected:TRUE];
        }
        else {
            [sunday setSelected:TRUE];
        }
    }
}

- (void)getAgenda {
    if (selectedDay == AgendaSaturday) {
        [satAgendas removeAllObjects];
        NSOrderedSet *satSet = [saturdayConference valueForKey:@"agendas"];
        for (Agenda *agenda in satSet) {
            [satAgendas addObject:agenda];
        }
    }
    else {
        [sunAgendas removeAllObjects];
        NSOrderedSet *sunSet = [sundayConference valueForKey:@"agendas"];
        for (Agenda *agenda in sunSet) {
            [sunAgendas addObject:agenda];
        }
    }
    [agendaTable reloadData];
}

-(void)BServiceDidUpdateObjects {
    [self getAgenda];
}


-(void)BServiceDidntUpdateObjects {
    NSLog(@"NOTHING NEW");
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return selectedDay == AgendaSaturday ? [satAgendas count] : [sunAgendas count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AgendaCell *cell;
    static NSString *MyIdentifier = @"AgendaCell";
    cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[AgendaCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    
    if (selectedDay == AgendaSaturday) {
        [cell setAgenda:[satAgendas objectAtIndex:indexPath.row]];
    } else {
        [cell setAgenda:[sunAgendas objectAtIndex:indexPath.row]];
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 66;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Agenda *a;
    
    if (selectedDay == AgendaSaturday) {
        a = [satAgendas objectAtIndex:indexPath.row];
    } else {
        a = [sunAgendas objectAtIndex:indexPath.row];
    }
    
    if (![a.isEvent boolValue]) {
        AgendaDetailViewController *advc = [[AgendaDetailViewController alloc] initWithAgenda:a];
        [[self navigationController] pushViewController:advc animated:YES];
    }
}


@end