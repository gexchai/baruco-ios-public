//
//  AgendaDetailViewController.h
//  baruco-ios
//
//  Created by Piotr Debosz on 8/17/12.
//  Copyright (c) 2012 EL Passion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Agenda.h"
#import "BarucoViewController.h"

@interface AgendaDetailViewController : BarucoViewController {
    Agenda *agenda;
    UIScrollView *scrollView;
    UIView *userView;
}

- (id) initWithAgenda:(Agenda *)_agenda;

@end
