//
//  AgendaViewController.h
//  baruco-ios
//
//  Created by Adam Lipka on 05.08.2012.
//  Copyright (c) 2012 EL Passion. All rights reserved.
//

#import "BarucoViewController.h"
#import "Agenda.h"

@class ConferenceDay;

typedef enum {AgendaSaturday, AgendaSunday} BarucoDay;

@interface AgendaViewController : BarucoViewController <UITableViewDataSource, UITableViewDelegate> {
    UITableView *agendaTable;
    NSMutableArray *satAgendas;
    NSMutableArray *sunAgendas;
    BarucoDay *selectedDay;
    
    UIView *bottomBar;
    UIButton *saturday;
    UIButton *sunday;
    ConferenceDay *saturdayConference;
    ConferenceDay *sundayConference;
}

@end
