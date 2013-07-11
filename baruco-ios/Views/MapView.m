//
//  MapView.m
//  SoShape
//
//  Created by Piotr Debosz on 4/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>
#import "MapView.h"
#import "Address.h"
#import "Annotation.h"

#define MERCATOR_OFFSET 268435456
#define MERCATOR_RADIUS 85445659.44705395

@implementation MapView

@synthesize caller;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        map = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [map setShowsUserLocation:TRUE];
//        [map setDelegate:self];
        loaded = FALSE;
        [self addSubview:map];
        annotations = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {

}

- (MKMapView *)map {
    return map;
}

- (void)showAddresses:(NSArray *)addresses {
    [map removeAnnotations:annotations];
    [annotations removeAllObjects];

    for (Address *address in addresses) {
        [self showAddress:address];
    }

    Address *firstAddress = [addresses objectAtIndex:0];
    [self centreAtAddress:firstAddress];
}

- (void)showAddress:(Address *)address {
    Annotation *annotationPoint = [[Annotation alloc] init];
    annotationPoint.title = [address name];
    annotationPoint.subtitle = [address fullAddress];
    annotationPoint.coordinate = address.position.coordinate;
    [map addAnnotation:annotationPoint];
    [annotations addObject:annotationPoint];

    [self centreAtAddress:address];
}

- (void)centreAtAddress:(Address *)address {
    [self zoomMapAndCenterAtLocation:address.position.coordinate withZoom:13];
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    Annotation *annTapped = [mapView.selectedAnnotations objectAtIndex:0];
    
//    ClubVC *cvc = [[ClubVC alloc] initWithClub:annTapped.club];
//    [[caller navigationController] pushViewController:cvc animated:TRUE];
}

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id) annotation
{
    //    return nil;
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
        //        MKPinAnnotationView *a = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Annotation"];
        //        a.pinColor = MKPinAnnotationColorPurple;
        //        return a;
    }
    
    MKPinAnnotationView *newAnnotation = (MKPinAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier: @"Annotation"];
    if (newAnnotation == nil) {
        newAnnotation = [[MKPinAnnotationView alloc] initWithAnnotation: annotation reuseIdentifier: @"Annotation"];
    } else {
        newAnnotation.annotation = annotation;
    }
    
    newAnnotation.canShowCallout = YES;
    newAnnotation.animatesDrop = YES;
    newAnnotation.pinColor = MKPinAnnotationColorRed;
//    newAnnotation.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];

    return newAnnotation;
}

- (void)removeLocationsFromMap {
    [map removeAnnotations:map.annotations];
}

- (void)addLocationsOnMapFromArray:(NSArray *)locations {
//    if (annotations == nil) {
//        annotations = [[NSMutableArray alloc] init];
//    }
//
//    [map removeAnnotations:annotations];
//    [annotations removeAllObjects];
//
//    for (Club *c in locations) {
//
//        if (c.lat != 0 && c.lng != 0) {
//            CLLocation *l = [[CLLocation alloc] initWithLatitude:c.lat longitude:c.lng];
//
//            Annotation *annotationPoint = [[Annotation alloc] init];
//            annotationPoint.title = c.name;
//            annotationPoint.coordinate = l.coordinate;
//            annotationPoint.club = c;
//            [map addAnnotation:annotationPoint];
//            [annotations addObject:annotationPoint];
//        }
//    }
}

- (double)longitudeToPixelSpaceX:(double)longitude
{
    return round(MERCATOR_OFFSET + MERCATOR_RADIUS * longitude * M_PI / 180.0);
}

- (double)latitudeToPixelSpaceY:(double)latitude
{
    return round(MERCATOR_OFFSET - MERCATOR_RADIUS * logf((1 + sinf(latitude * M_PI / 180.0)) / (1 - sinf(latitude * M_PI / 180.0))) / 2.0);
}

- (double)pixelSpaceXToLongitude:(double)pixelX
{
    return ((round(pixelX) - MERCATOR_OFFSET) / MERCATOR_RADIUS) * 180.0 / M_PI;
}

- (double)pixelSpaceYToLatitude:(double)pixelY
{
    return (M_PI / 2.0 - 2.0 * atan(exp((round(pixelY) - MERCATOR_OFFSET) / MERCATOR_RADIUS))) * 180.0 / M_PI;
}


- (MKCoordinateSpan)coordinateSpanWithMapView:(MKMapView *)mapView
                             centerCoordinate:(CLLocationCoordinate2D)centerCoordinate
                                 andZoomLevel:(NSUInteger)zoomLevel
{
    // convert center coordiate to pixel space
    double centerPixelX = [self longitudeToPixelSpaceX:centerCoordinate.longitude];
    double centerPixelY = [self latitudeToPixelSpaceY:centerCoordinate.latitude];
    
    // determine the scale value from the zoom level
    NSInteger zoomExponent = 20 - zoomLevel;
    double zoomScale = pow(2, zoomExponent);
    
    // scale the map’s size in pixel space
    CGSize mapSizeInPixels = mapView.bounds.size;
    double scaledMapWidth = mapSizeInPixels.width * zoomScale;
    double scaledMapHeight = mapSizeInPixels.height * zoomScale;
    
    // figure out the position of the top-left pixel
    double topLeftPixelX = centerPixelX - (scaledMapWidth / 2);
    double topLeftPixelY = centerPixelY - (scaledMapHeight / 2);
    
    // find delta between left and right longitudes
    CLLocationDegrees minLng = [self pixelSpaceXToLongitude:topLeftPixelX];
    CLLocationDegrees maxLng = [self pixelSpaceXToLongitude:topLeftPixelX + scaledMapWidth];
    CLLocationDegrees longitudeDelta = maxLng - minLng;
    
    // find delta between top and bottom latitudes
    CLLocationDegrees minLat = [self pixelSpaceYToLatitude:topLeftPixelY];
    CLLocationDegrees maxLat = [self pixelSpaceYToLatitude:topLeftPixelY + scaledMapHeight];
    CLLocationDegrees latitudeDelta = -1 * (maxLat - minLat);
    
    // create and return the lat/lng span
    MKCoordinateSpan span = MKCoordinateSpanMake(latitudeDelta, longitudeDelta);
    return span;
}

- (void)zoomMapAndCenterAtLocation:(CLLocationCoordinate2D)location withZoom:(NSUInteger)zoomLevel {    
    zoomLevel = MIN(zoomLevel, 28);
    
    // use the zoom level to compute the region
    MKCoordinateSpan span = [self coordinateSpanWithMapView:map centerCoordinate:location andZoomLevel:zoomLevel];
    MKCoordinateRegion region = MKCoordinateRegionMake(location, span);
    
    // set the region like normal
    [map setRegion:region animated:NO];
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
