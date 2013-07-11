//
//  Sponsor.h
//  baruco-ios
//
//  Created by Piotr Paweł Dębosz on 12.08.2012.
//  Copyright (c) 2012 EL Passion. All rights reserved.
//

#import "BarucoObject.h"

static NSString *etag;

static NSString *html;

@interface Sponsor : BarucoObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *imageUrl;
@property (nonatomic, retain) NSString *website;
@property (nonatomic, retain) UIImage *image;

+ (void)saveHtml:(NSString *)newHtml;

+ (NSString *)html;
+(void)saveEtag:(NSString *)newEtag;

@end
