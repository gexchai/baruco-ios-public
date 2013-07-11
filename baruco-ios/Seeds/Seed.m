//
//  Seed.m
//  baruco-ios
//
//  Created by Piotr Paweł Dębosz on 26.08.2012.
//  Copyright (c) 2012 EL Passion. All rights reserved.
//

#import "Seed.h"
#import "BarucoObject.h"
#import "Agenda.h"
#import "Sponsor.h"
#import "News.h"
#import "AFJSONUtilities.h"
#import "News.h"

@implementation Seed

- (id)init {
    self = [super init];
    
    if (self) {
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        
        bool didSeed = [prefs boolForKey:@"seeded"];
        
        if (!didSeed) {
            [self seedNews];
            [self seedAgenda];
            [self seedSponsor];
            [self seedNews];
        }
        
        [prefs setBool:true forKey:@"seeded"];
        [prefs synchronize];
    }

    return self;
}

- (NSString *)getFile:(NSString *)name {
    NSString* path = [[NSBundle mainBundle] pathForResource:name
                                                     ofType:@"json"];
    NSString* content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];

    return content;
}

- (NSDictionary *)parse:(NSString *)json {
    return AFJSONDecode([json dataUsingEncoding:NSUTF8StringEncoding], nil);
}

- (void)seedNews {
    [News fetchObjects:[self parse:[self getFile:@"news"]]];
}

- (void)seedSponsor {
    [Sponsor saveEtag:@"\"2b7bfcb4b29229ca8d03cae25ae41768\""];
    [Sponsor fetchObjects:[self parse:[self getFile:@"sponsors"]]];
}

- (void)seedAgenda {
    [Agenda saveEtag:@"\"132783b1e6e3f06c343a69b194aebdbc\""];
    [Agenda fetchObjects:[self parse:[self getFile:@"agenda"]]];
}

@end
