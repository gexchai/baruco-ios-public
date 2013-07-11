//
//  MenuButton.m
//  baruco-ios
//
//  Created by Adam Lipka on 05.08.2012.
//  Copyright (c) 2012 EL Passion. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "MenuButton.h"
#import "BarucoViewController.h"

@implementation MenuButton

@synthesize mainColor;
@synthesize controllerType;
//@synthesize controllerClass;

- (id)initWithPoint:(CGPoint)point
{
    self = [super initWithFrame:CGRectMake(point.x, point.y, 142, 142)];
    if (self) {
        // Initialization code
//        [self.titleLabel setTextColor:[UIColor whiteColor]];
        [self.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:23]];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted|UIControlStateSelected];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [self setTitleEdgeInsets:UIEdgeInsetsMake(80, 0, 0, 0)];
        self.layer.borderWidth = 1;
        self.layer.borderColor = [[UIColor blackColor] CGColor];
        currentColor = [UIColor clearColor];
        self.backgroundColor = currentColor;
    }
    return self;
}

-(void)setHighlighted:(BOOL)aHighlighted {
    [super setHighlighted:aHighlighted];
    if (aHighlighted) {
        [self setBackgroundColor:[mainColor colorWithAlphaComponent:.5]];
    }
    else {
        [self setBackgroundColor:currentColor];
    }
}

-(void)setSelected:(BOOL)aSelected {
    [super setSelected:aSelected];
    if (aSelected) {
        currentColor = mainColor;
    }
    else {
        currentColor = [UIColor clearColor];
    }
    [self setBackgroundColor:currentColor];
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
