//
//  PKMapViewController.h
//  PKBeerView
//
//  Created by Patrick King on 2/1/14.
//  Copyright (c) 2014 Patrick King Consulting LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <SVProgressHUD.h>

@interface PKMapViewController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end
