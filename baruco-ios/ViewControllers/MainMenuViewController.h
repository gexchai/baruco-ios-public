//
//  MainMenuViewController.h
//  baruco-ios
//
//  Created by Adam Lipka on 04.08.2012.
//  Copyright (c) 2012 EL Passion. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MenuButton;
@class BarucoAppDelegate;

@interface MainMenuViewController : UIViewController {
    MenuButton *newsButton;
    MenuButton *agendaButton;
    MenuButton *sponsorsButton;
    MenuButton *locationButton;
    MenuButton *currentlySelected;
    BarucoAppDelegate *appDelegate;
}

@end
