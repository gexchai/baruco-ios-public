//
//  BService.m
//  baruco-ios
//
//  Created by Piotr Paweł Dębosz on 12.08.2012.
//  Copyright (c) 2012 EL Passion. All rights reserved.
//

#import "BService.h"
#import "Agenda.h"
#import "Speaker.h"
#import "Sponsor.h"
#import "News.h"
#import "AFJSONRequestOperation.h"
#import "BarucoObject.h"
#import "AFImageRequestOperation.h"
#import "BarucoAppDelegate.h"
#import "DDMenuController.h"
#import "SponsorsViewController.h"
#import "AgendaViewController.h"
#import "NewsViewController.h"

static NSString *apiUrl = @"http://supersecretapiurl.com";
static BService *sharedInstance = nil;

@implementation BService

-(void)loadObjects:(Class)class queryParams:(NSDictionary *)params delegate:(NSObject <BServiceDelegate> *)caller {

    BarucoAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];

    NSURL *url = [self constructUrlForModelName:class params:params];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    [request addValue:@"\"dfa3af467987d4ad6a5c996704b7a0b3\"" forHTTPHeaderField:@"If-None-Match"];
    [request setCachePolicy:NSURLCacheStorageAllowedInMemoryOnly];
    [request addValue:[class etag] forHTTPHeaderField:@"If-None-Match"];

//    NSLog(@"ETETETETEGGGG %@", [class etag]);

    NSLog(@"BService - getting data for url: %@%@", [url host], [url path]);
    NSLog(@"BService - getting data headersssss: %@", [request allHTTPHeaderFields]);

    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:
                                         ^(NSURLRequest *completedRequest, NSHTTPURLResponse *response, id JSON) {

                                             NSLog(@"REQUESTTSTSTSTSTST %@", response.allHeaderFields);
                                             [class fetchObjects:JSON];
                                             if ([self shouldSendCallbackTo:appDelegate.currentlyRoot withClass:class]) {
                                                 [caller BServiceDidUpdateObjects];
                                             }
                                             else {
                                                 NSLog(@"Not called call back");
                                             }
                                             [class saveEtag:[response.allHeaderFields valueForKey:@"Etag"]];
                                         }
                                         failure:^(NSURLRequest *completedRequest, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                            if (response.statusCode == 304) {
                                                if ([self shouldSendCallbackTo:appDelegate.currentlyRoot withClass:class]) {
                                                    [caller BServiceDidntUpdateObjects];
                                                }
                                                else {
                                                    NSLog(@"Not called call back");
                                                }
                                                NSLog(@"aaa");
                                            }
                                            else {
                                                if ([self shouldSendCallbackTo:appDelegate.currentlyRoot withClass:class]) {
                                                    [caller BServiceDidFailLoadingObjects:error];
                                                }
                                                else {
                                                    NSLog(@"Not called call back");
                                                }
                                            }
                                        }];
    [operation start];
}

- (void)sendPushNotification:(NSData *)token {

    NSString *stoken = [[[token description]
                                 stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]] stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"sending push token: %@", stoken);
    
    NSString *urls = [NSString stringWithFormat:@"%@/new_ios_device/%@", apiUrl, stoken];
    
    NSURL* url = [NSURL URLWithString:urls];
    
    NSLog(@"SENDING PUSH URL: %@", urls);
    
    NSURLRequest* rq = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:rq];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"SUCCCESSFULL SEND TOKEN!");
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"FAILED SENDING TOKEN: %@", error);
        // Deal with failure
    }];
    
    [operation start];
}

- (BOOL)shouldSendCallbackTo:(UIViewController *)controller withClass:(Class)class {
    if ([controller isKindOfClass:[SponsorsViewController class]] && [class isEqual:[Sponsor class]]) {
        return YES;
    }
    if ([controller isKindOfClass:[AgendaViewController class]] && [class isEqual:[Agenda class]]) {
        return YES;
    }
    if ([controller isKindOfClass:[NewsViewController class]] && [class isEqual:[News class]]) {
        return YES;
    }
    NSLog(@"Root has changed");
    return NO;
}

-(void)loadImage:(NSString *)path delegate:(NSObject <BServiceDelegate> *)caller {
    NSURL *url = [NSURL URLWithString:path];
    NSLog(@"TRYING TO GET IMAGE %@", path);

    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLCacheStorageAllowed timeoutInterval:180];
    AFImageRequestOperation *operation = [AFImageRequestOperation imageRequestOperationWithRequest:request success:^(NSURLRequest *completedRequest, NSHTTPURLResponse *response, UIImage *image) {
//    AFImageRequestOperation *operation = [AFImageRequestOperation imageRequestOperationWithRequest:request success:^(UIImage *image) {
        [caller BServiceDidLoadImage:image];
    }];
    [operation start];
}

-(void)loadObject:(Class)class queryParams:(NSDictionary *)params delegate:(NSObject <BServiceDelegate> *)caller {
    NSURL *url = [self constructUrlForModelName:class params:params];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSLog(@"BService - getting data for url: %@%@", [url host], [url path]);
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:
                                         ^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                             [caller BServiceDidLoadObject:JSON];
                                         }
                                        
                                        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                            [caller BServiceDidFailLoadingObject:error];
                                        }];
    
    
    [operation start];
}




-(void)updateObject:(BarucoObject *)object delegate:(NSObject <BServiceDelegate> *)caller {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", apiUrl, [object detailedPath]]];

    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    NSLog(@"BService - getting data for url: %@%@", [url host], [url path]);

    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:
                                         ^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                             [object updateDetails:JSON];
                                             [caller BServiceDidLoadObject:JSON];
                                         }

                                        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                            [caller BServiceDidFailLoadingObject:error];
                                        }];
    [operation start];
}



//
//- (NSArray *)getObjectsForClass:(Class)class json:(id)json {
//    NSString *key;
//
//    if ([class isEqual:[Agenda class]]) {
//        key = @"talks";
//    }
//
//    NSMutableArray *data = [[NSMutableArray alloc] init];
//
//    NSLog(@"parsing !");
//
//    for (NSDictionary *dict in [json objectForKey:key]) {
//        [data addObject:[class parse:dict]];
//    }
//
//    return data;
//}

- (NSURL *)constructUrlForModelName:(Class)class params:(NSDictionary *)dictionary {
    if ([class isEqual:[Agenda class]]) {
        if ([dictionary objectForKey:@"objectId"]) {
            return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", apiUrl, [dictionary valueForKey:@"objectId"]]];
        } else {
            return [NSURL URLWithString:[NSString stringWithFormat:@"%@", apiUrl]];
        }
    }
    if ([class isEqual:[Sponsor class]]) {
        NSLog(@"SPONOSSRSRSRSRSR");
        return [NSURL URLWithString:[NSString stringWithFormat:@"%@", apiUrl]];
    }
    if ([class isEqual:[News class]]) {
        NSLog(@"%@", [News lastNewsTime]);
        if ([dictionary valueForKey:@"newer_than"]) {
            NSString *path = [NSString stringWithFormat:@"%@%@", apiUrl, [dictionary valueForKey:@"newer_than"]];
            NSLog(@"TRYING TOO GETTT NEWS %@", path);
            return [NSURL URLWithString:path];
        }
        else {
            return [NSURL URLWithString:[NSString stringWithFormat:@"%@", apiUrl]];
        }
    }

    return NULL;
}

+ (BService *)sharedInstance {
    @synchronized (self) {
        if (sharedInstance == nil) {
            sharedInstance = [[BService alloc] init];
        }
    }
    return sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone {
    @synchronized (self) {
        if (sharedInstance == nil) {
            sharedInstance = [super allocWithZone:zone];
            return sharedInstance;
        }
    }
    return nil;
}


@end
