//
//  BarucoViewController.m
//  baruco-ios
//
//  Created by Adam Lipka on 04.08.2012.
//  Copyright (c) 2012 EL Passion. All rights reserved.
//

#import "BarucoViewController.h"
#import "BarucoAppDelegate.h"
#import "UIBarButtonItem+customButton.h"
#import "DDMenuController.h"

@interface BarucoViewController ()

@end

@implementation BarucoViewController

- (void)didPressBack {
    [appDelegate.rootController showLeftController:TRUE];
}

- (id)init
{
    self = [super init];
    if (self) {
        appDelegate = (BarucoAppDelegate *) [[UIApplication sharedApplication] delegate];
        UIBarButtonItem *left = [[UIBarButtonItem alloc] buttonWithImage:[UIImage imageNamed:@"nav_button.png"] activeImage:[UIImage imageNamed:@"menu_button_active.png"] target:self action:@selector(didPressBack)];
        [left setEnabled:TRUE];
        [[self navigationItem] setLeftBarButtonItem:left];

        navLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
        navLabel.backgroundColor = [UIColor clearColor];
        navLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:20];
        navLabel.shadowColor = [UIColor colorWithRed:29/255.0 green:114/255.0 blue:110/255.0 alpha:1];
        navLabel.shadowOffset = CGSizeMake(0, 1);
        navLabel.textAlignment = UITextAlignmentCenter;
        navLabel.textColor = [UIColor whiteColor];
        self.navigationItem.titleView = navLabel;
    }
    return self;
}

-(void)safeClear {

}

-(void)setupNavTitle:(NSString *)title {
    [navLabel setText:title];
}

-(void)loadView {
    [super loadView];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 0;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//
//    // Configure the cell...
//
//    return cell;
//}
//
///*
//// Override to support conditional editing of the table view.
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Return NO if you do not want the specified item to be editable.
//    return YES;
//}
//*/
//
///*
//// Override to support editing the table view.
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        // Delete the row from the data source
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    }
//    else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }
//}
//*/
//
///*
//// Override to support rearranging the table view.
//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
//{
//}
//*/
//
///*
//// Override to support conditional rearranging of the table view.
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Return NO if you do not want the item to be re-orderable.
//    return YES;
//}
//*/
//
//#pragma mark - Table view delegate
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Navigation logic may go here. Create and push another view controller.
//    /*
//     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
//     // ...
//     // Pass the selected object to the new view controller.
//     [self.navigationController pushViewController:detailViewController animated:YES];
//     */
//}

@end
