//
//  NewsCell.h
//  baruco-ios
//
//  Created by Piotr Paweł Dębosz on 26.08.2012.
//  Copyright (c) 2012 EL Passion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News.h"

typedef enum {kUnread, kRead} State;

@interface NewsCell : UITableViewCell {
    UIView *leftBackground;
    UILabel *hour;
    UILabel *mainTitle;
    UILabel *date;
    UILabel *subTitle;
    UIImageView *accessory;
    UIView *unreadLine;
    State state;
    News *news;
}

-(void)setNews:(News *)_news;
-(void)setRead;
-(void)setUnread;

@end
