//
//  LinkedLabel.h
//  baruco-ios
//
//  Created by Adam Lipka on 26.08.2012.
//  Copyright (c) 2012 EL Passion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LinkedLabel : UILabel


@property (nonatomic, retain) NSURL *url;

- (void)openURL;


@end
