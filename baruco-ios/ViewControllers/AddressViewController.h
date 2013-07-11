//
//  AddressViewController.h
//  GoldenLine
//
//  Created by Adam Lipka on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import "BarucoViewController.h"


@interface AddressViewController : BarucoViewController {
    Address *address;
}
- (id)initWithAddress:(Address *)newAddress;

@end
