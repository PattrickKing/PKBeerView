//
//  PKVenueAnnotation.h
//  PKBeerView
//
//  Created by Patrick King on 2/1/14.
//  Copyright (c) 2014 Patrick King Consulting LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "FSQVenue.h"

@interface PKVenueAnnotation : NSObject <MKAnnotation>

- (id)initWithVenue:(FSQVenue *)venue;

@end
