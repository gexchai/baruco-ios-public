//
//  News.h
//  baruco-ios
//
//  Created by Adam Lipka on 26.08.2012.
//  Copyright (c) 2012 EL Passion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "BarucoObject.h"
#import "BServiceDelegate.h"

static NSString *lastNews;

@interface News : BarucoObject <BServiceDelegate>

@property (nonatomic, retain) NSNumber * isShort;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * body;
@property (nonatomic, retain) NSString * imageUrl;
@property (nonatomic, retain) NSNumber * createdAtInt;
@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) NSString * sDateTime;
@property (nonatomic, retain) NSString * sHour;
@property (nonatomic, retain) NSString * sDayMonth;
@property (nonatomic, retain) UIImage *photo;
@property (nonatomic, retain) NSNumber * isUnread;


+ (void)saveLastNews:(NSNumber *)newsTime;

+ (NSString *)lastNewsTime;

- (void)setPhoto:(UIImage *)image;
- (UIImage *)photo;

@end
