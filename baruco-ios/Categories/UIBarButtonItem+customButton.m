//
//  UIBarButtonItem+customButton.m
//  positionly
//
//  Created by Piotr Dębosz on 2/7/12.
//  Copyright (c) 2012 EL Passion. All rights reserved.
//

#import "UIBarButtonItem+customButton.h"
#import <CoreGraphics/CoreGraphics.h>

#define BUTTON_FONT [UIFont boldSystemFontOfSize:12]
#define MARGIN 20

@implementation UIBarButtonItem (customButton)

- (id)buttonWithImage:(UIImage *)image activeImage:(UIImage *)activeImage target:(id)target action:(SEL)action
{
    UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [aButton setBackgroundImage:image forState:UIControlStateNormal];
    [aButton setBackgroundImage:activeImage forState:UIControlStateHighlighted];
    [aButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [aButton setFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    UIBarButtonItem *sself = [super init];
    [sself setCustomView:aButton];
    [aButton setEnabled:TRUE];
    return sself;
}

- (id)plainButtonWithTitle:(NSString*)title normalBackground:(UIImage *)normalImage activeBackground:(UIImage *)activeImage target:(id)target action:(SEL)action
{
    CGSize actualWidth = [title sizeWithFont:BUTTON_FONT];
    UIImage *stretchableNormal = [normalImage stretchableImageWithLeftCapWidth:20 topCapHeight:normalImage.size.height];
    UIImage *stretchableActive = [activeImage stretchableImageWithLeftCapWidth:20 topCapHeight:normalImage.size.height];
    
    UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [aButton setBackgroundImage:stretchableNormal forState:UIControlStateNormal];
    [aButton setBackgroundImage:stretchableActive forState:UIControlStateHighlighted];
    float proper_width;
    if (actualWidth.width + MARGIN > normalImage.size.width) {
        proper_width = actualWidth.width + MARGIN;
    }
    else {
        proper_width = normalImage.size.width;
    }
    [aButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [aButton setFrame:CGRectMake(0, 0, proper_width, normalImage.size.height)];
    [aButton.titleLabel setFont:BUTTON_FONT];
    [aButton setTitleColor:[UIColor colorWithRed:100/255.0 green:67/255.0 blue:32/255.0 alpha:1] forState:UIControlStateNormal];
    [aButton setTitleColor:[UIColor colorWithRed:100/255.0 green:67/255.0 blue:32/255.0 alpha:.5] forState:UIControlStateDisabled];
    [aButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [aButton setTitle:title forState:UIControlStateNormal];
    UIBarButtonItem *sself = [super init];
    [sself setCustomView:aButton];
    [aButton setEnabled:TRUE];
    return sself;
}

//-(void)setDisabledBackground:(UIImage *)image {
//    UIImage *stretchableImage = [image stretchableImageWithLeftCapWidth:20 topCapHeight:image.size.height];
//}
@end
