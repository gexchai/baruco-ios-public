//
//  News.m
//  baruco-ios
//
//  Created by Adam Lipka on 26.08.2012.
//  Copyright (c) 2012 EL Passion. All rights reserved.
//

#import "BServiceDelegate.h"
#import "News.h"
#import "BarucoAppDelegate.h"


@implementation News {
@private
    UIImage *_photo;
}


@dynamic isShort;
@dynamic title;
@dynamic body;
@dynamic imageUrl;
@dynamic createdAtInt;
@dynamic image;
@dynamic sDateTime;
@dynamic sHour;
@dynamic sDayMonth;
@dynamic isUnread;
@synthesize photo = _photo;


+(void)initialize {
    [super initialize];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    lastNews = [defaults objectForKey:@"LastNews"];
}

+(void)saveLastNews:(NSNumber *)newsTime {
//    NSString *updatedEtag = [NSString stringWithFormat:@"\"%@\"",newEtag];
    NSLog(@"TRYING TO SAVE LAST NEWS TIME %@", [newsTime stringValue]);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    lastNews = [newsTime stringValue];
    [defaults setObject:[newsTime stringValue] forKey:@"LastNews"];
    [defaults synchronize];
}

+(NSString *)lastNewsTime {
//    NSString *updatedEtag = [etag stringByReplacingOccurrencesOfString:@"\"" withString:@"\""];
    return lastNews;
}

- (void)updateAttributes:(NSDictionary *)params {
    [self setObjectId:[params valueForKey:@"id"]];
    [self setTitle:[params valueForKey:@"title"]];
    [self setBody:[params valueForKey:@"body"]];
    [self setSDayMonth:[params valueForKey:@"day_month"]];
    [self setSHour:[params valueForKey:@"hour"]];
    if (![[params valueForKey:@"image_url"] isEqual:[NSNull null]]) {
        NSLog(@"SHOULD GETTTT NEWSSS PHOTOOO");
        [self setImageUrl:[params valueForKey:@"image_url"]];
        [[BService sharedInstance] loadImage:self.imageUrl delegate:self];
    }
    [self setSDateTime:[params valueForKey:@"created_at_human"]];

    NSNumberFormatter * formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [self setCreatedAtInt:[formatter numberFromString:[params valueForKey:@"created_at"]]];

    NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:[[formatter numberFromString:[params valueForKey:@"created_at"]] doubleValue]];
    NSLog(@"NEEEEEEWSSSSSSSSSSS DATEEEEEEE %@", date);
}

-(void)BServiceDidLoadImage:(UIImage *)image {
    NSLog(@"TRYING TO SET NEWS IMAGE");
    [self setPhoto:image];
}

- (void)setPhoto:(UIImage *)image {
    [self willChangeValueForKey:@"image"];
    NSData *data = UIImagePNGRepresentation(image);
    [self setPrimitiveValue:data forKey:@"image"];
    [self didChangeValueForKey:@"image"];

    _photo = [UIImage imageWithData:[self primitiveValueForKey:@"image"]];

    BarucoAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = [appDelegate managedObjectContext];
    [appDelegate saveContext];
}

- (UIImage*)photo {
    if (!_photo) {
        [self willAccessValueForKey:@"image"];
        _photo = [UIImage imageWithData:[self primitiveValueForKey:@"image"]];
        [self didAccessValueForKey:@"image"];
    }
    return _photo;
}

+(id)findObjectWithId:(NSNumber *)objectId error:(NSError **)error {

    BarucoAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = [appDelegate managedObjectContext];

    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"News" inManagedObjectContext:managedObjectContext];
    [request setEntity:entity];
    NSMutableArray *coreDataArray = [[managedObjectContext executeFetchRequest:request error:nil] mutableCopy];

    NSArray *filtered = [coreDataArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(objectId == %@)", objectId]];

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

    BarucoAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = [appDelegate managedObjectContext];

    NSError *error;
    News *news;
    news = [self findObjectWithId:[objectDict valueForKey:@"id"] error:&error];
    if (!news & error == nil) {
        news = [[News alloc] initWithEntity:[NSEntityDescription entityForName:@"News" inManagedObjectContext:managedObjectContext] insertIntoManagedObjectContext:managedObjectContext];
        [news setIsUnread:[NSNumber numberWithBool:TRUE]];
    }
    [news updateAttributes:objectDict];
    return news;
}

+(void)fetchObjects:(NSDictionary *)collectionDict {
    NSLog(@"NEWS: TRIED TO PARSE %@", collectionDict);

    BarucoAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = [appDelegate managedObjectContext];
    int i = 1;

    for (NSDictionary *objectDict in [collectionDict valueForKey:@"mobile_news"]) {
        News *breakingNews = [[self class] createOrUpdateObject:objectDict];
//        News *breakingNews = [[[self class] alloc] initWithEntity:[NSEntityDescription entityForName:@"News" inManagedObjectContext:managedObjectContext] insertIntoManagedObjectContext:managedObjectContext];
//        [breakingNews updateAttributes:objectDict];
        [breakingNews setIsUnread:[NSNumber numberWithBool:TRUE]];
        if (i == [[collectionDict valueForKey:@"mobile_news"] count]) {
            [News saveLastNews:breakingNews.objectId];
        }
        i++;
    }
    [appDelegate saveContext];
}
@end
