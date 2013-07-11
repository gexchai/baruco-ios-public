//
//  AgendaCell.h
//  baruco-ios
//
//  Created by Adam Lipka on 05.08.2012.
//  Copyright (c) 2012 EL Passion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Agenda.h"

@interface AgendaCell : UITableViewCell {
    UIView *leftBackground;
    UILabel *hour;
    UILabel *mainTitle;
    UILabel *subTitle;
    UIImageView *accessory;
    Agenda *agenda;
}


-(void)setAgenda:(Agenda *)_agenda;
@end
