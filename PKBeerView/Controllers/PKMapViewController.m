//
//  PKMapViewController.m
//  PKBeerView
//
//  Created by Patrick King on 2/1/14.
//  Copyright (c) 2014 Patrick King Consulting LLC. All rights reserved.
//

#import "PKMapViewController.h"
#import "FSQFoursquareAPIClient.h"
#import "PKVenueAnnotation.h"

@interface PKMapViewController () <CLLocationManagerDelegate>

    @property (nonatomic, strong) CLLocationManager *locationManager;
    @property (nonatomic, strong) NSArray *venues;

@end

@implementation PKMapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self updateLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    self.locationManager = nil;
}

- (CLLocationManager *)locationManager {
    
    if (!_locationManager) {
     
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        _locationManager.delegate = self;
    }
    
    return _locationManager;
}

- (void)updateLocation {
    
    [self.locationManager startUpdatingLocation];
}

- (void)zoomToLocation:(CLLocation *)location radius:(CGFloat)radius {
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location.coordinate, radius * 2, radius * 2);
    [self.mapView setRegion:region animated:YES];
}

- (void)fetchVenuesForLocation:(CLLocation *)location {
    
    [SVProgressHUD show];
    [[FSQFoursquareAPIClient sharedClient] fetchVenuesNear:location.coordinate
                                                searchTerm:@"beer"
                                            radiusInMeters:4000
                                                completion:^(NSArray *venues, NSError *error) {
                                                    if(error) {
                                                        [SVProgressHUD showErrorWithStatus: error.description];
                                                    } else {
                                                        [SVProgressHUD dismiss];
                                                        self.venues = venues;
                                                        [self updateAnnotations];
                                                    }
                                                }];
}

- (void)updateAnnotations {
    
    for (FSQVenue *venue in self.venues) {
        
        PKVenueAnnotation *annotation = [[PKVenueAnnotation alloc] initWithVenue:venue];
        [self.mapView addAnnotation:annotation];
    }
}

#pragma mark - CLLocationManagerDelegate methods

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    CLLocation *location = [locations lastObject];
    [self fetchVenuesForLocation:location];
    [self zoomToLocation:location radius:2000];
    [self.locationManager stopUpdatingLocation];
}

@end
