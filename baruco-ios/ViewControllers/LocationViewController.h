//
//  LocationViewController.h
//  baruco-ios
//
//  Created by Adam Lipka on 05.08.2012.
//  Copyright (c) 2012 EL Passion. All rights reserved.
//

#import "BarucoViewController.h"

@class Address;

@interface LocationViewController : BarucoViewController {
    Address *congressAddress;
    Address *partyAddress;
    UIView *background;
}

@end
