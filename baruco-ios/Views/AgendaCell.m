//
//  AgendaCell.m
//  baruco-ios
//
//  Created by Adam Lipka on 05.08.2012.
//  Copyright (c) 2012 EL Passion. All rights reserved.
//

#import "AgendaCell.h"
#import "UILabel+AlignTop.h"

@implementation AgendaCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        UIView *highlighted = [[UIView alloc] initWithFrame:CGRectZero];
//        [highlighted setBackgroundColor:[UIColor colorWithRed:251/255.0 green:191/255.0 blue:37/255.0 alpha:.8]];
//        [self setSelectedBackgroundView:highlighted];
        [self setBackgroundColor:[UIColor whiteColor]];

        leftBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 66, 66)];
        [leftBackground setBackgroundColor:[UIColor colorWithRed:251/255.0 green:191/255.0 blue:37/255.0 alpha:1]];
        [self addSubview:leftBackground];
        
        [self setBackgroundColor:[UIColor whiteColor]];

        hour = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 66, 66)];
        [hour setBackgroundColor:[UIColor clearColor]];
        [hour setTextAlignment:UITextAlignmentCenter];
        [hour setFont:[UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:18]];
        [hour setText:@"11:45"];
        [self addSubview:hour];

        mainTitle = [[UILabel alloc] initWithFrame:CGRectMake(77, 7, 225       , 40)];
        [mainTitle setBackgroundColor:[UIColor clearColor]];
        [mainTitle setNumberOfLines:2];
        [mainTitle setFont:[UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:17]];
        [mainTitle setTextColor:[UIColor colorWithRed:182/255.0 green:58/255.0 blue:38/255.0 alpha:1]];
        [mainTitle setText:@"Tammer Saleh & Randall Thomas"];
        [mainTitle alignTop];
        [self addSubview:mainTitle];

        subTitle = [[UILabel alloc] initWithFrame:CGRectMake(77, 30, 220, 30)];
        [subTitle setBackgroundColor:[UIColor clearColor]];
        [subTitle setNumberOfLines:2];
        [subTitle setFont:[UIFont fontWithName:@"HelveticaNeue-Italic" size:12]];
        [subTitle setTextColor:[UIColor grayColor]];
        [subTitle setText:@"Rubinius - Tales from the trenches of developing a Ruby implementation"];
        [subTitle alignTop];
        [self addSubview:subTitle];
        
        UIView *bottomWhite = [[UIView alloc] initWithFrame:CGRectMake(0, 65, 66, 1)];
        [bottomWhite setBackgroundColor:[UIColor whiteColor]];
        [leftBackground addSubview:bottomWhite];

        UIView *bottomGrey = [[UIView alloc] initWithFrame:CGRectMake(67, 65, 254, 1)];
        [bottomGrey setBackgroundColor:[UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1]];
        [self addSubview:bottomGrey];
        
        accessory = [[UIImageView alloc] initWithFrame:CGRectMake(301, 26, 9, 14)];
        [accessory setImage:[UIImage imageNamed:@"accessory.png"]];
        
        [self addSubview:accessory];
    }
    return self;
}

- (void)setAgenda:(Agenda *)_agenda {
    agenda = _agenda;
    [mainTitle setText:agenda.title];
    [mainTitle alignTop];
    [hour setText:agenda.sTime];
    [subTitle setText:agenda.subtitle];
    
    if (![agenda.isEvent boolValue]) {
        [accessory setHidden:NO];
        [mainTitle setTextColor:[UIColor colorWithRed:182/255.0 green:58/255.0 blue:38/255.0 alpha:1]];
    } else {
        [mainTitle setTextColor:[UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1]];
        [accessory setHidden:YES];
    }
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [self setBackgroundColor:[UIColor whiteColor]];

    if (![agenda.isEvent boolValue]) {
//    [super setHighlighted:highlighted animated:animated];
        if (highlighted) {
            [self setBackgroundColor:[UIColor colorWithRed:253/255.0 green:218/255.0 blue:110/255.0 alpha:1]];
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
//    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
