//
//  UIBarButtonItem+customButton.h
//  positionly
//
//  Created by Piotr Dębosz on 2/7/12.
//  Copyright (c) 2012 EL Passion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (customButton)

- (id)buttonWithImage:(UIImage *)image activeImage:(UIImage *)activeImage target:(id)target action:(SEL)action;
- (id)plainButtonWithTitle:(NSString*)title normalBackground:(UIImage *)normalImage activeBackground:(UIImage *)activeImage target:(id)target action:(SEL)action;

- (void)setDisabledBackground:(UIImage *)image;


@end
