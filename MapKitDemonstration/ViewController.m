//
//  ViewController.m
//  MapKitDemonstration
//
//  Created by T. Andrew Binkowski on 11/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "MyLocation.h"

@implementation ViewController
@synthesize mapView;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CLLocation *userLoc = mapView.userLocation.location;
    CLLocationCoordinate2D userCoordinate = userLoc.coordinate;
    NSLog(@"user latitude = %f",userCoordinate.latitude);
    NSLog(@"user longitude = %f",userCoordinate.longitude);
    [self addPlaces];
}

- (void)viewDidUnload
{
    [self setMapView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

/*******************************************************************************
 * @method          <# Method Name #>
 * @abstract        <# Abstract #>
 * @description     <# Description #>
 ******************************************************************************/
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setInitialMapPosition];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark - Map Helpers
/*******************************************************************************
 * @method      initialMapPosition
 * @abstract    <# abstract #>
 * @description <# description #>
 *******************************************************************************/
- (void)setInitialMapPosition
{
    // Set the initial position of the map
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 28.53806;
    zoomLocation.longitude = -81.37944;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 10*METERS_PER_MILE, 10*METERS_PER_MILE);
    MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:viewRegion];                
    [self.mapView setRegion:adjustedRegion animated:YES];  
}

/*******************************************************************************
 * @method      addPlaces
 * @abstract    <# abstract #>
 * @description <# description #>
 *******************************************************************************/
- (void)addPlaces
{
    // Add some data
    CLLocationCoordinate2D coordinates;
    coordinates.latitude = 28.53806;
    coordinates.longitude = -81.37944;
    MyLocation *annotation = [[MyLocation alloc] initWithName:@"Disney World" address:@"Orlando" coordinate:coordinates];
    [mapView addAnnotation:annotation];

    // Add another point
    CLLocationCoordinate2D coordinates2;
    coordinates2.latitude = 28.47399;
    coordinates2.longitude = -81.46228;
    MyLocation *annotation2 = [[MyLocation alloc] initWithName:@"Universal Studios" address:@"Orlando" coordinate:coordinates2];
    [mapView addAnnotation:annotation2];
}

/*******************************************************************************
 * @method          refresh
 * @abstract        <# Abstract #>
 * @description     <# Description #>
 ******************************************************************************/
- (IBAction)refresh:(id)sender {
    for (id<MKAnnotation> annotation in self.mapView.annotations) {
        [self.mapView removeAnnotation:annotation];
    }
        
    [self addPlaces];
    
}

//
// <# Comment Goes Here #>
// 

/*******************************************************************************
 * @method          <# Method Name #>
 * @abstract        <# Abstract #>
 * @description     <# Description #>
 ******************************************************************************/
- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation {

    static NSString *identifier = @"MyLocation";   

    if ([annotation isKindOfClass:[MyLocation class]]) {
        MyLocation *location = (MyLocation *) annotation;
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [theMapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:location reuseIdentifier:identifier];
        } else {
            annotationView.annotation = location;
        }
        annotationView.animatesDrop = YES;
        annotationView.enabled = YES;
        annotationView.canShowCallout = YES;
        annotationView.draggable = YES;
        annotationView.pinColor = MKPinAnnotationColorPurple;
        annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
       
        // Show Mickey
        if ([location.title isEqualToString:@"Disney World"]) {
            annotationView.leftCalloutAccessoryView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"MickeyMouse.png"]];
        } else {
            annotationView.leftCalloutAccessoryView = nil;
        }
        return annotationView;
    }

    return nil; 
}

/*******************************************************************************
 * @method          <# Method Name #>
 * @abstract        <# Abstract #>
 * @description     <# Description #>
 ******************************************************************************/
-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    NSLog(@"%@ %@",view,control);
}
@end
