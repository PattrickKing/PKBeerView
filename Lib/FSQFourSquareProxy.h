//
//  FSQFourSquareProxy.h
//  PKBeerView
//
//  Created by Patrick King on 2/2/14.
//  Copyright (c) 2014 Patrick King Consulting LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "AFNetworking.h"
#import "AFHTTPSessionManager.h"
#import "FSQVenue.h"

typedef void (^FSQVenuesBlock)(NSArray *venues, NSError *error);

@interface FSQFourSquareProxy : NSObject

+ (FSQFourSquareProxy *)proxy;

- (void)fetchVenuesNear:(CLLocationCoordinate2D)coordinates
            searchTerm:(NSString *)searchTerm
        radiusInMeters:(CGFloat)radius
            completion:(FSQVenuesBlock)completion;


@end
