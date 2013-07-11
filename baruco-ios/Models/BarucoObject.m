//
//  BarucoObject.m
//  baruco-ios
//
//  Created by Adam Lipka on 8/20/12.
//  Copyright (c) 2012 EL Passion. All rights reserved.
//

#import "BarucoObject.h"
#import "BarucoAppDelegate.h"

static BarucoAppDelegate *appDelegate;

@implementation BarucoObject

@dynamic objectId;
@dynamic createdAt;
@dynamic updatedAt;

+(NSString *)etag {
    return @"";
}

+(void)saveEtag:(NSString *)newEtag {

}


+(void)initialize {
    appDelegate = (BarucoAppDelegate *) [[UIApplication sharedApplication] delegate];
}

+(BarucoAppDelegate *)appDelegate {
    return appDelegate;
}


- (void)updateWithParams:(NSDictionary *)params {

}


+(NSDate *)parseDate:(NSString *)stringDate {

}

+(NSDate *)parseDateTime:(NSString *)stringDateTime {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:+3600]];
    [dateFormatter setDateFormat:@"MMMM' 'dd', 'YYYY' 'HH':'mm"];
    return [dateFormatter dateFromString:stringDateTime];
}

-(void)fetchObjects:(NSDictionary *)collectionDict {
    NSException *exception = [NSException exceptionWithName: @"AbstractMethodCalled"
                                                     reason: @"Should be implemented into subclass"
                                                   userInfo: nil];
    @throw exception;
}

- (NSString *)detailedPath {
    NSException *exception = [NSException exceptionWithName: @"AbstractMethodCalled"
                                                     reason: @"Should be implemented into subclass"
                                                   userInfo: nil];
    @throw exception;
}

- (void)updateAttributes:(NSDictionary *)params {
    NSException *exception = [NSException exceptionWithName: @"AbstractMethodCalled"
                                                     reason: @"Should be implemented into subclass"
                                                   userInfo: nil];
    @throw exception;
}

- (void)updateDetails:(NSDictionary *)params {
    NSException *exception = [NSException exceptionWithName: @"AbstractMethodCalled"
                                                     reason: @"Should be implemented into subclass"
                                                   userInfo: nil];
    @throw exception;
}



+(id)findObjectWithId:(NSNumber *)objectId error:(NSError **)error {
    
    appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = [appDelegate managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:managedObjectContext];
    [request setEntity:entity];
    NSMutableArray *coreDataArray = [[managedObjectContext executeFetchRequest:request error:nil] mutableCopy];
    
    NSArray *filtered = [coreDataArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(objectId == %@)", objectId]];
    //    NSLog(@"FIFIFIFIFIIFIFIFIFI %@", filtered);
    
    if ([filtered count] > 1) {
        NSLog(@"CRITICAL BUGGGG");
        *error = [NSError errorWithDomain:@"more then one object" code:1 userInfo:nil];
        return nil;
    }
    else if ([filtered count] == 1) {
        NSLog(@"SUCCCESSS");
        return [filtered objectAtIndex:0];
    }
    NSLog(@"NoT FOUND");
    return nil;
}

+(id)createOrUpdateObject:(NSDictionary *)objectDict {

    appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = [appDelegate managedObjectContext];

    BarucoObject *object;
    NSError *error;
    object = [self findObjectWithId:[objectDict valueForKey:@"id"] error:&error];

    if (!object & error == nil) {
        NSString *className = NSStringFromClass(self);
        object = [[[self class] alloc] initWithEntity:[NSEntityDescription entityForName:className inManagedObjectContext:managedObjectContext] insertIntoManagedObjectContext:managedObjectContext];
    }
    [object updateAttributes:objectDict];
    return object;
}
@end
