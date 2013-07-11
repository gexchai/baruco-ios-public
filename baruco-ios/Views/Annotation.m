//
//  Annotation.m
//  SoShape
//
//  Created by Piotr Debosz on 4/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Annotation.h"
#import "Address.h"

@implementation Annotation {
    CLLocationCoordinate2D _coordinate;
    NSString *_title;
    NSString *_subtitle;
@private
    Address *_address;
}

@synthesize coordinate = _coordinate;
@synthesize title = _title;
@synthesize subtitle = _subtitle;
@synthesize address = _address;

@end
