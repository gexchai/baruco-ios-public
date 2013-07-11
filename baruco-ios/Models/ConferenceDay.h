//
//  ConferenceDay.h
//  baruco-ios
//
//  Created by Adam Lipka on 8/24/12.
//  Copyright (c) 2012 EL Passion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Agenda;

@interface ConferenceDay : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSOrderedSet *agendas;

+ (ConferenceDay *)dayWithName:(NSString *)dayName;

+ (ConferenceDay *)saturday;

- (void)clearAgendas;


@end

@interface ConferenceDay (CoreDataGeneratedAccessors)

- (void)insertObject:(Agenda *)value inAgendasAtIndex:(NSUInteger)idx;
- (void)removeObjectFromAgendasAtIndex:(NSUInteger)idx;
- (void)insertAgendas:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeAgendasAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInAgendasAtIndex:(NSUInteger)idx withObject:(Agenda *)value;
- (void)replaceAgendasAtIndexes:(NSIndexSet *)indexes withAgendas:(NSArray *)values;
- (void)addAgendasObject:(Agenda *)value;
- (void)removeAgendasObject:(Agenda *)value;
- (void)addAgendas:(NSOrderedSet *)values;
- (void)removeAgendas:(NSOrderedSet *)values;
@end
