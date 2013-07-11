//
//  Sponsor.m
//  baruco-ios
//
//  Created by Piotr Paweł Dębosz on 12.08.2012.
//  Copyright (c) 2012 EL Passion. All rights reserved.
//

#import "Sponsor.h"
#import "BarucoAppDelegate.h"
#import "Agenda.h"

@implementation Sponsor

@synthesize imageUrl, name, website, image;


+(void)initialize {
    NSLog(@"KJKJKHKLKLHKLJH");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    etag = [defaults objectForKey:@"SponsorEtag"];
    html = [defaults objectForKey:@"SponsorHtml"];
    NSLog(@"KJKJKHKLKLHKLJH 4444444444444444");
}

+(void)saveEtag:(NSString *)newEtag {
//    NSString *updatedEtag = [NSString stringWithFormat:@"\"%@\"",newEtag];
    NSLog(@"TRYING TO SAVE SPONSOR ETAG %@", newEtag);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    etag = newEtag;
    [defaults setObject:newEtag forKey:@"SponsorEtag"];
    [defaults synchronize];
}

+(NSString *)etag {
//    NSString *updatedEtag = [etag stringByReplacingOccurrencesOfString:@"\"" withString:@"\""];
    return etag;
}

+(void)saveHtml:(NSString *)newHtml {
//    NSLog(@"TRYING TO SAVE SPONSOR HTML %@", newHtml);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    html = newHtml;
    [defaults setObject:newHtml forKey:@"SponsorHtml"];
    [defaults synchronize];
}

+(NSString *)html {
    if (!html) {
//        NSLog(@"getting empty html !");
        return @"";
        
    }
    else {
//        NSLog(@"getting some html ! %@", html);
        return html;
    }
}

+(void)fetchObjects:(NSDictionary *)collectionDict {
    [Sponsor saveHtml:[collectionDict valueForKey:@"html"]];
//    NSLog(@"SHOULD SAVE HTML %@", collectionDict);
}
@end
