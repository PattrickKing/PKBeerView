//
//  FSQFoursquareAPIClient.h
//  PKBeerView
//
//  Created by Patrick King on 2/1/14.
//  Copyright (c) 2014 Patrick King Consulting LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "AFNetworking.h"
#import "AFHTTPClient.h"
#import "FSQVenue.h"

typedef void (^FSQVenuesBlock)(NSArray *venues, NSError *error);

@interface FSQFoursquareAPIClient : AFHTTPClient

+(FSQFoursquareAPIClient *)sharedClient;

-(void)fetchVenuesNear:(CLLocationCoordinate2D)coordinates
            searchTerm:(NSString *)searchTerm
        radiusInMeters:(CGFloat)radius
            completion:(FSQVenuesBlock)completion;

@end
