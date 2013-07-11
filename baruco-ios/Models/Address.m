//
//  Address.m
//  GoldenLine
//
//  Created by Adam Lipka on 4/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Address.h"

@implementation Address {
@private
    NSString *_street;
    NSString *_number;
    NSString *_zipcode;
    NSString *_city;
    NSString *_country;
    CLLocation *_position;
    NSString *_name;
}

@synthesize street = _street;
@synthesize number = _number;
@synthesize zipcode = _zipcode;
@synthesize city = _city;
@synthesize country = _country;
@synthesize position = _position;
@synthesize name = _name;


+ (Address *)parseSingleObject:(NSDictionary *)addressDict {
    Address *address = [[Address alloc] init];
    [address setCountry:[addressDict valueForKey:@"country"]];
    [address setCity:[addressDict valueForKey:@"city"]];
    [address setStreet:[addressDict valueForKey:@"street"]];
    [address setNumber:[addressDict valueForKey:@"number"]];
    [address setZipcode:[addressDict valueForKey:@"zipcode"]];
    float lat = [[addressDict valueForKey:@"latitude"] floatValue];
    float lng = [[addressDict valueForKey:@"longitude"] floatValue];
    [address setPosition:[[CLLocation alloc] initWithLatitude:lat longitude:lng]];
    return address;
}

- (NSString *) fullAddress {
    return [NSString stringWithFormat:@"%@ %@", _street, _number];
}


- (NSString *)zipWithCity {
    if (_zipcode) {
        return _city;
    }
    return [NSString stringWithFormat:@"%@ %@", _zipcode, _city];
}
@end
