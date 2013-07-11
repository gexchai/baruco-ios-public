//
//  BarucoAppDelegate.h
//  baruco-ios
//
//  Created by Adam Lipka on 04.08.2012.
//  Copyright (c) 2012 EL Passion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "BarucoViewController.h"

@class NewsViewController;
@class DDMenuController;
@class MainMenuViewController;

@interface BarucoAppDelegate : UIResponder <UIApplicationDelegate>  {
    NewsViewController *_newsViewController;
    MainMenuViewController *menuViewController;
    DDMenuController *_rootController;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NewsViewController *newsViewController;
@property (readonly, strong, nonatomic) DDMenuController *rootController;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) MainMenuViewController *menuViewController;
@property (nonatomic, strong) BarucoViewController *currentlyRoot;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
