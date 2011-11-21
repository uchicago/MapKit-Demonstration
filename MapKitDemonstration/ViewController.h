//
//  ViewController.h
//  MapKitDemonstration
//
//  Created by T. Andrew Binkowski on 11/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#define METERS_PER_MILE 1609.344

@interface ViewController : UIViewController <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

- (IBAction)refresh:(id)sender;
- (void)setInitialMapPosition;
- (void)addPlaces;

@end
