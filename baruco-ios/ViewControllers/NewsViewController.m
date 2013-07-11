//
//  NewsViewController.m
//  baruco-ios
//
//  Created by Adam Lipka on 04.08.2012.
//  Copyright (c) 2012 EL Passion. All rights reserved.
//

#import "NewsViewController.h"
#import "BarucoAppDelegate.h"
#import "DDMenuController.h"
#import "NewsCell.h"
#import "NewsDetailViewController.h"

@interface NewsViewController ()

@end

@implementation NewsViewController

- (id)init
{
    self = [super init];
    if (self) {
        NSLog(@"NEWS VC init");
        [self setupNavTitle:@"NEWS"];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification) name:@"showNews" object:nil];
    }
    return self;
}

- (void)handleNotification {
    [self getNews];
    [self importNews];
}

-(void)loadView {
    [super loadView];
    
    newsTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 417)];
    [newsTable setDataSource:self];
    [newsTable setDelegate:self];
    [newsTable setBackgroundColor:[UIColor clearColor]];
    [newsTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:newsTable];

    [self importNews];

}

- (void)importNews {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if ([News lastNewsTime]) {
        [params setValue:[News lastNewsTime] forKey:@"newer_than"];
    }
    [[BService sharedInstance] loadObjects:[News class] queryParams:params delegate:self];
}

- (void)getNews {
    news = [[NSMutableArray alloc] init];

    BarucoAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = [appDelegate managedObjectContext];

    NSFetchRequest *request = [[NSFetchRequest alloc] init];

    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"objectId" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptors];

    NSEntityDescription *entity = [NSEntityDescription entityForName:@"News" inManagedObjectContext:managedObjectContext];
    [request setEntity:entity];
    NSMutableArray *coreDataArray = [[managedObjectContext executeFetchRequest:request error:nil] mutableCopy];

    [news addObjectsFromArray:coreDataArray];
    [newsTable reloadData];
}


- (void)BServiceDidFailLoadingObjects:(NSError *)error {
    NSLog(@"NEWS - DidFailLoadingObjects, error: %@", error);
}

- (void)BServiceDidLoadObjects:(NSArray *)objects {

}

-(void)BServiceDidUpdateObjects {
    [self getNews];
}


-(void)BServiceDidntUpdateObjects {
    NSLog(@"NOTHING NEW WITH NEWS");
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self getNews];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewDidAppear:(BOOL)animated {
//    [appDelegate.rootController showLeftController:TRUE];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsCell *cell;
    static NSString *MyIdentifier = @"NewsCell";
    cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[NewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    [cell setNews:[news objectAtIndex:indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [news count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 66;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    News *n = [news objectAtIndex:indexPath.row];

    NewsDetailViewController *advc = [[NewsDetailViewController alloc] initWithNews:n];
    [[self navigationController] pushViewController:advc animated:YES];

    [(NewsCell *) [tableView cellForRowAtIndexPath:indexPath] setRead];
    BarucoAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [n setIsUnread:[NSNumber numberWithBool:FALSE]];
    [appDelegate saveContext];

}

@end
