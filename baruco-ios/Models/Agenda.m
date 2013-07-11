//
//  Agenda.m
//  baruco-ios
//
//  Created by Adam Lipka on 8/22/12.
//  Copyright (c) 2012 EL Passion. All rights reserved.
//

#import "Agenda.h"
#import "Speaker.h"
#import "BarucoAppDelegate.h"
#import "ConferenceDay.h"

static BarucoAppDelegate *appDelegate;


@implementation Agenda

@dynamic date;
@dynamic desc;
@dynamic isEvent;
@dynamic sDay;
@dynamic sDateTime;
@dynamic sTime;
@dynamic subtitle;
@dynamic title;
@dynamic speakers;


+(void)initialize {
    [super initialize];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    etag = [defaults objectForKey:@"AgendaEtag"];
}

+(void)saveEtag:(NSString *)newEtag {
//    NSString *updatedEtag = [NSString stringWithFormat:@"\"%@\"",newEtag];
    NSLog(@"TRYING TO SAVE ETAG %@", newEtag);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    etag = newEtag;
    [defaults setObject:newEtag forKey:@"AgendaEtag"];
    [defaults synchronize];
}

+(NSString *)etag {
//    NSString *updatedEtag = [etag stringByReplacingOccurrencesOfString:@"\"" withString:@"\""];
    return etag;
}

- (void)updateAttributes:(NSDictionary *)params {

    appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = [appDelegate managedObjectContext];

    [self setIsEvent:[params valueForKey:@"is_event"]];
    [self setObjectId:[params valueForKey:@"id"]];
    [self setTitle:[params valueForKey:@"title"]];
    [self setSubtitle:[params valueForKey:@"sub_title"]];
    [self setSTime:[params valueForKey:@"schedule_time"]];
    [self setSDay:[params valueForKey:@"schedule_day"]];
    [self setDate:[BarucoObject parseDateTime:[params valueForKey:@"schedule_datetime"]]];
    [self setSDateTime:[params valueForKey:@"schedule_datetime"]];
    [self setDesc:[params valueForKey:@"description"]];

    [self willChangeValueForKey:@"speakers"];
    NSMutableOrderedSet* tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:self.speakers];
    for (Speaker *speaker in tempSet) {
        [managedObjectContext deleteObject:speaker];
    }
    [tempSet removeAllObjects];
    for (NSDictionary *speakerDict in [params valueForKey:@"speakers"]) {
        Speaker *speaker = [[[self class] alloc] initWithEntity:[NSEntityDescription entityForName:@"Speaker" inManagedObjectContext:managedObjectContext] insertIntoManagedObjectContext:managedObjectContext];
        [speaker updateAttributes:speakerDict];
        [tempSet addObject:speaker];
    }
    [self setSpeakers:tempSet];
    [self didChangeValueForKey:@"speakers"];
}

- (void)updateDetails:(NSDictionary *)params {

    params = [params valueForKey:@"talk_details"];

    appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = [appDelegate managedObjectContext];

    NSLog(@"SHOULD UPDATE THESE PARAMS %@", params);
    [self setDesc:[params valueForKey:@"description"]];


    [self willChangeValueForKey:@"speakers"];
    NSMutableOrderedSet* tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:self.speakers];
    for (Speaker *speaker in tempSet) {
        [managedObjectContext deleteObject:speaker];
    }
    [tempSet removeAllObjects];
    for (NSDictionary *speakerDict in [params valueForKey:@"speakers"]) {
        Speaker *speaker = [[[self class] alloc] initWithEntity:[NSEntityDescription entityForName:@"Speaker" inManagedObjectContext:managedObjectContext] insertIntoManagedObjectContext:managedObjectContext];
        [speaker updateAttributes:speakerDict];
        [tempSet addObject:speaker];
    }
    [self setSpeakers:tempSet];
//    NSLog(@"AFTERRRRRRR TOPICS ADDDD %@", [[self topicsData] needsToReload]);
    [self didChangeValueForKey:@"speakers"];
    [appDelegate saveContext];
}

- (NSString *)detailedPath {
    return [NSString stringWithFormat:@"/agenda/%@.json", self.objectId];
}

+(void)fetchObjects:(NSDictionary *)collectionDict {
    appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = [appDelegate managedObjectContext];

    ConferenceDay *saturday = [ConferenceDay dayWithName:@"saturday"];
    ConferenceDay *sunday = [ConferenceDay dayWithName:@"sunday"];

    [saturday clearAgendas];
    [sunday clearAgendas];

    for (NSDictionary *objectDict in [collectionDict valueForKey:@"talks"]) {
        NSLog(@"TRYING TO ADDD AGENDASSSSS");
        Agenda *newAgenda = [[[self class] alloc] initWithEntity:[NSEntityDescription entityForName:@"Agenda" inManagedObjectContext:managedObjectContext] insertIntoManagedObjectContext:managedObjectContext];
        [newAgenda updateAttributes:objectDict];
        if ([newAgenda.sDay isEqualToString:@"saturday"]) {
            [saturday addAgendasObject:newAgenda];
        }
        else {
            [sunday addAgendasObject:newAgenda];
        }
//        NSLog(@"CREATED OBJECT %@", newAgenda);
    }

    NSLog(@"SUNDAYYYYY %@", sunday);

    [appDelegate saveContext];
}
@end
