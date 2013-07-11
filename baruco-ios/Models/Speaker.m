//
//  Speaker.m
//  baruco-ios
//
//  Created by Adam Lipka on 8/22/12.
//  Copyright (c) 2012 EL Passion. All rights reserved.
//

#import "Speaker.h"
#import "Agenda.h"
#import "BService.h"
#import "BarucoAppDelegate.h"


@implementation Speaker {
@private
    UIImage *_avatar;
}


@dynamic desc;
@dynamic github;
@dynamic image;
@dynamic imageUrl;
@dynamic name;
@dynamic twitter;
@dynamic website;
@dynamic tagline;
@dynamic info;
@dynamic agendas;


- (void)updateAttributes:(NSDictionary *)params {
    [self setObjectId:[params valueForKey:@"id"]];
    [self setImageUrl:[params valueForKey:@"avatar"]];
    [self setName:[params valueForKey:@"full_name"]];
    [self setTwitter:[params valueForKey:@"twitter"]];
    [self setGithub:[params valueForKey:@"github"]];
    [self setWebsite:[params valueForKey:@"website"]];
    [self setTagline:[params valueForKey:@"tagline"]];
    [self setInfo:[params valueForKey:@"info"]];
    [[BService sharedInstance] loadImage:self.imageUrl delegate:self];
}

-(void)BServiceDidLoadImage:(UIImage *)image {
    NSLog(@"TRYING TO SET IMAGE");
    [self setAvatar:image];
}

- (void)setAvatar:(UIImage *)image {
    [self willChangeValueForKey:@"image"];
    _avatar = image;
    NSData *data = UIImagePNGRepresentation(image);
    [self setPrimitiveValue:data forKey:@"image"];
    [self didChangeValueForKey:@"image"];

    BarucoAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = [appDelegate managedObjectContext];
    [appDelegate saveContext];

}

- (UIImage*)avatar {
    if (!_avatar) {
        [self willAccessValueForKey:@"image"];
        _avatar = [UIImage imageWithData:[self primitiveValueForKey:@"image"]];
        [self didAccessValueForKey:@"image"];
    }
    return _avatar;
}
@end
