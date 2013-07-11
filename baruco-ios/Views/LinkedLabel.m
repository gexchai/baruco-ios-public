//
//  LinkedLabel.m
//  baruco-ios
//
//  Created by Adam Lipka on 26.08.2012.
//  Copyright (c) 2012 EL Passion. All rights reserved.
//

#import "LinkedLabel.h"

@implementation LinkedLabel {
@private
    NSURL *_url;
}

@synthesize url = _url;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openURL)];
        [self addGestureRecognizer:tapGestureRecognizer];
        [self setUserInteractionEnabled:TRUE];
    }
    return self;
}

- (void)openURL {
    NSLog(@"OPENENENENNE URLLLLLLL");
    [[UIApplication sharedApplication] openURL:_url];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
