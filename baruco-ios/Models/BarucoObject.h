//
//  BarucoObject.h
//  baruco-ios
//
//  Created by Adam Lipka on 8/20/12.
//  Copyright (c) 2012 EL Passion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BarucoAppDelegate;


@interface BarucoObject : NSManagedObject

@property (nonatomic, retain) NSNumber * objectId;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSDate * updatedAt;

- (void)updateAttributes:(NSDictionary *)params;

+ (NSString *)etag;

+ (BarucoAppDelegate *)appDelegate;

- (void)updateWithParams:(NSDictionary *)params;

+ (NSDate *)parseDate:(NSString *)stringDate;

+ (NSDate *)parseDateTime:(NSString *)stringDateTime;


+ (void)fetchObjects:(NSDictionary *)collectionDict;


- (NSString *)detailedPath;

- (void)updateDetails:(NSDictionary *)params;

+ (id)findObjectWithId:(NSNumber *)objectId error:(NSError **)error;

+ (id)createOrUpdateObject:(NSDictionary *)objectDict;


- (void)updateDetails;
@end
