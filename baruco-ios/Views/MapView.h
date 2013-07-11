//
//  MapView.h
//  SoShape
//
//  Created by Piotr Debosz on 4/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class Address;

@interface MapView : UIView<MKMapViewDelegate> {
    MKMapView *map;
    NSMutableArray *annotations;
    BOOL loaded;
}

@property (nonatomic, retain) UIViewController *caller;

- (MKMapView *)map;

- (void)showAddresses:(NSArray *)address;


- (void)showAddress:(Address *)address;

- (void)centreAtAddress:(Address *)address;


- (void)addLocationsOnMapFromArray:(NSArray *)array;
- (void)zoomMapAndCenterAtLocation:(CLLocationCoordinate2D)location withZoom:(NSUInteger)zoomLevel;
@end
