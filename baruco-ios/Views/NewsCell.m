//
//  NewsCell.m
//  baruco-ios
//
//  Created by Piotr Paweł Dębosz on 26.08.2012.
//  Copyright (c) 2012 EL Passion. All rights reserved.
//

#import "NewsCell.h"
#import "UILabel+AlignTop.h"

@implementation NewsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        state = kUnread;
        
        leftBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 66, 66)];
        [leftBackground setBackgroundColor:[UIColor colorWithRed:247/255.0 green:193/255.0 blue:25/255.0 alpha:1]];
        [self addSubview:leftBackground];
        
        unreadLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 66)];
        [unreadLine setBackgroundColor:[UIColor colorWithRed:193/255.0 green:40/255.0 blue:15/255.0 alpha:1]];
        [unreadLine setHidden:YES];
        [leftBackground addSubview:unreadLine];

        hour = [[UILabel alloc] initWithFrame:CGRectMake(5, 18, 61, 20)];
        [hour setBackgroundColor:[UIColor clearColor]];
        [hour setTextAlignment:UITextAlignmentCenter];
        [hour setFont:[UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:18]];
        [hour setText:@"11:45"];
        [self addSubview:hour];
        
        date = [[UILabel alloc] initWithFrame:CGRectMake(5, 40, 61, 13)];
        [date setBackgroundColor:[UIColor clearColor]];
        [date setTextAlignment:UITextAlignmentCenter];
        [date setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
        [date setText:@"08 Sep"];
        [self addSubview:date];
        
        mainTitle = [[UILabel alloc] initWithFrame:CGRectMake(77, 0, 220, 66)];
        [mainTitle setBackgroundColor:[UIColor clearColor]];
        [mainTitle setNumberOfLines:2];
        [mainTitle setFont:[UIFont fontWithName:@"HelveticaNeue-Condensed" size:17]];
        [mainTitle setTextColor:[UIColor blackColor]];
        [mainTitle setText:@"Rubinius - Tales from the\ntrenches of developing"];
        [self addSubview:mainTitle];
        
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

-(void)setNews:(News *)_news {
    news = _news;
    [mainTitle setText:news.title];
    [hour setText:news.sHour];
    [date setText:news.sDayMonth];
    if ([news.isUnread boolValue]) {
        [self setUnread];
    }
    else {
        [self setRead];
    }
}

-(void)setRead {
    [mainTitle setFont:[UIFont fontWithName:@"HelveticaNeue" size:17]];
    [unreadLine setHidden:YES];
    state = kRead;
}

-(void)setUnread {
    [mainTitle setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:17]];
    [unreadLine setHidden:NO];
    state = kUnread;
}

-(void)toggleRead {
    if (state == kRead) {
        [self setUnread];
    } else {
        [self setRead];
    }
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    //    [super setHighlighted:highlighted animated:animated];
    if (highlighted) {
        [self setBackgroundColor:[UIColor colorWithRed:253/255.0 green:218/255.0 blue:110/255.0 alpha:1]];
    }
    else {
        [self setBackgroundColor:[UIColor whiteColor]];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
//    if (selected) {
//        [self setUnread];
//    } else {
//        [self setRead];
//    }
//    [self toggleRead];
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
