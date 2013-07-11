//
//  BService.h
//  baruco-ios
//
//  Created by Piotr Paweł Dębosz on 12.08.2012.
//  Copyright (c) 2012 EL Passion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BServiceDelegate.h"

@class BarucoObject;

@interface BService : NSObject

-(void)loadObjects:(Class)class queryParams:(NSDictionary *)params delegate:(NSObject <BServiceDelegate> *)caller;

- (void)loadImage:(NSString *)path delegate:(NSObject <BServiceDelegate> *)caller;

-(void)loadObject:(Class)class queryParams:(NSDictionary *)params delegate:(NSObject <BServiceDelegate> *)caller;

- (void)updateObject:(BarucoObject *)object delegate:(NSObject <BServiceDelegate> *)caller;


- (NSURL *)constructUrlForModelName:(Class)class params:(NSDictionary *)dictionary;

+ (BService *)sharedInstance;
- (void)sendPushNotification:(NSData *)token;

@end
