//
//  ConferenceDay.m
//  baruco-ios
//
//  Created by Adam Lipka on 8/24/12.
//  Copyright (c) 2012 EL Passion. All rights reserved.
//

#import "ConferenceDay.h"
#import "Agenda.h"
#import "BarucoAppDelegate.h"

static BarucoAppDelegate *appDelegate;

@implementation ConferenceDay

@dynamic name;
@dynamic agendas;

+(ConferenceDay *)dayWithName:(NSString *)dayName {
    appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = [appDelegate managedObjectContext];

    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:managedObjectContext];
    [request setEntity:entity];
    NSMutableArray *coreDataArray = [[managedObjectContext executeFetchRequest:request error:nil] mutableCopy];

    NSArray *filtered = [coreDataArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(name == %@)", dayName]];
    //    NSLog(@"FIFIFIFIFIIFIFIFIFI %@", filtered);
    if ([filtered count] > 1) {
        NSLog(@"CRITICAL BUGGGG - MORE THAN ONE %@", dayName);
//        *error = [NSError errorWithDomain:@"more then one object" code:1 userInfo:nil];
//        return nil;
        return [filtered objectAtIndex:0];
    }
    else if ([filtered count] == 1) {
        NSLog(@"SUCCCESSS");
        return [filtered objectAtIndex:0];
    }
    NSLog(@"NoT FOUND %@", dayName);
    ConferenceDay *saturday = [[[self class] alloc] initWithEntity:[NSEntityDescription entityForName:@"ConferenceDay" inManagedObjectContext:managedObjectContext] insertIntoManagedObjectContext:managedObjectContext];
    [saturday setName:dayName];
    [appDelegate saveContext];
    return saturday;
}

-(void)clearAgendas {
    appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = [appDelegate managedObjectContext];
    NSOrderedSet *agendas = [self valueForKey:@"agendas"];
    for (Agenda *agenda in agendas) {
        [managedObjectContext deleteObject:agenda];
    }
    [appDelegate saveContext];
}

-(void)addAgendasObject:(Agenda *)value {
    [self willChangeValueForKey:@"agendas"];
    NSLog(@"TRYING TO ADD AGENDAS TO CONFERENCE DAY");
    NSMutableOrderedSet* tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:self.agendas];
    [tempSet addObject:value];
    self.agendas = tempSet;
    [self didChangeValueForKey:@"agendas"];
}
@end
