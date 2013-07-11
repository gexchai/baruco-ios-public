//
//  BarucoViewController.h
//  baruco-ios
//
//  Created by Adam Lipka on 04.08.2012.
//  Copyright (c) 2012 EL Passion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BServiceDelegate.h"
#import "BService.h"

@class BarucoAppDelegate;

@interface BarucoViewController : UIViewController<BServiceDelegate> {
    BarucoAppDelegate *appDelegate;
    UILabel *navLabel;
}
- (void)safeClear;

- (void)setupNavTitle:(NSString *)title;


@end
