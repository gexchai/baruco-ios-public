//
//  Agenda.h
//  baruco-ios
//
//  Created by Adam Lipka on 8/22/12.
//  Copyright (c) 2012 EL Passion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "BarucoObject.h"

static NSString *etag;

@class Speaker;
@class BarucoAppDelegate;

@interface Agenda : BarucoObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSNumber * isEvent;
@property (nonatomic, retain) NSString * sDay;
@property (nonatomic, retain) NSString * sDateTime;
@property (nonatomic, retain) NSString * sTime;
@property (nonatomic, retain) NSString * subtitle;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSOrderedSet *speakers;


- (void)updateAttributes:(NSDictionary *)params;

@end

@interface Agenda (CoreDataGeneratedAccessors)

- (void)insertObject:(Speaker *)value inSpeakersAtIndex:(NSUInteger)idx;
- (void)removeObjectFromSpeakersAtIndex:(NSUInteger)idx;
- (void)insertSpeakers:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeSpeakersAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInSpeakersAtIndex:(NSUInteger)idx withObject:(Speaker *)value;
- (void)replaceSpeakersAtIndexes:(NSIndexSet *)indexes withSpeakers:(NSArray *)values;
- (void)addSpeakersObject:(Speaker *)value;
- (void)removeSpeakersObject:(Speaker *)value;
- (void)addSpeakers:(NSOrderedSet *)values;
- (void)removeSpeakers:(NSOrderedSet *)values;
+ (void)saveEtag:(NSString *)etag;
+ (NSString *)etag;
@end
