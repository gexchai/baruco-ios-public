//
//  Speaker.h
//  baruco-ios
//
//  Created by Adam Lipka on 8/22/12.
//  Copyright (c) 2012 EL Passion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "BarucoObject.h"
#import "BServiceDelegate.h"

@class Agenda;

@interface Speaker : BarucoObject <BServiceDelegate>

@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSString * github;
@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) NSString * imageUrl;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * twitter;
@property (nonatomic, retain) NSString * website;
@property (nonatomic, retain) NSString * tagline;
@property (nonatomic, retain) NSString * info;
@property (nonatomic, retain) Agenda *agendas;
@property (nonatomic, retain) UIImage *avatar;

- (void)setAvatar:(UIImage *)image;
- (UIImage *)avatar;

@end
