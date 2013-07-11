//
//  NewsViewController.h
//  baruco-ios
//
//  Created by Adam Lipka on 04.08.2012.
//  Copyright (c) 2012 EL Passion. All rights reserved.
//

#import "BarucoViewController.h"

@interface NewsViewController : BarucoViewController<UITableViewDataSource, UITableViewDelegate> {
    UITableView *newsTable;
    NSMutableArray *news;
}
@end