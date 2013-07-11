//
//  Address.h
//  GoldenLine
//
//  Created by Adam Lipka on 4/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CoreLocation/CLLocation.h"

@interface Address : NSObject

@property(nonatomic, retain) NSString *street;
@property(nonatomic, retain) NSString *number;
@property(nonatomic, retain) NSString *zipcode;
@property(nonatomic, retain) NSString *city;
@property(nonatomic, retain) NSString *country;
@property(nonatomic, retain) NSString *name;
@property(nonatomic, retain) CLLocation *position;

+ (Address *)parseSingleObject:(NSDictionary *)addressDict;

- (NSString *)fullAddress;


- (NSString *)zipWithCity;
@end
