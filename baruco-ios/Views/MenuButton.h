//
//  MenuButton.h
//  baruco-ios
//
//  Created by Adam Lipka on 05.08.2012.
//  Copyright (c) 2012 EL Passion. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BarucoViewController;

typedef enum {BarucoNews, BarucoAgenda, BarucoSponsors, BarucoLocation} BarucoOption;

@interface MenuButton : UIButton {
    UIColor *mainColor;
    UIColor *currentColor;
//    NSString *controllerClass;
    Class controllerClass;
}

@property(nonatomic, strong) UIColor *mainColor;
@property(nonatomic, assign) BarucoOption controllerType;
@property(nonatomic, strong) Class controllerClass;


- (id)initWithPoint:(CGPoint)point;


@end
