//
//  FSQFoursquareAPIClient.m
//  PKBeerView
//
//  Created by Patrick King on 2/1/14.
//  Copyright (c) 2014 Patrick King Consulting LLC. All rights reserved.
//

#import "FSQFoursquareAPIClient.h"

@implementation FSQFoursquareAPIClient

+(FSQFoursquareAPIClient *)sharedClient {
    
    static FSQFoursquareAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        NSURL *baseUrl = [NSURL URLWithString:FOURSQUARE_BASE_URL];
        _sharedClient = [[FSQFoursquareAPIClient alloc] initWithBaseURL:baseUrl];
    });
    
    return _sharedClient;
}

-(id)initWithBaseURL:(NSURL *)url {
    
    self = [super initWithBaseURL:url];
    
    if(self) {
        [self registerHTTPOperationClass: [AFJSONRequestOperation class]];
        [self setDefaultHeader:@"Accept" value:@"application/json"];
    }
    
    return self;
    
}

-(void)fetchVenuesNear:(CLLocationCoordinate2D)coordinates
            searchTerm:(NSString *)searchTerm
        radiusInMeters:(CGFloat)radius
            completion:(FSQVenuesBlock)completion {
    
    id params = @{
                  @"client_id": FOURSQUARE_APP_CLIENT_ID,
                  @"client_secret": FOURSQUARE_APP_CLIENT_SECRET,
                  @"v": @"20130815",
                  @"ll": [self latLongValueForCoordinate:coordinates],
                  @"radius": @(radius),
                  @"query": searchTerm,
                  @"intent": @"browse"
                  };
    
    [self getPath: @"venues/search"
       parameters: params
           success:^(AFHTTPRequestOperation *operation, id responseObject) {
               
               if(responseObject) {
                   NSArray *venues = [self venuesForResponse:responseObject[@"response"][@"venues"]];
                   completion(venues, nil);
               } else {
                   NSLog(@"Error %@", responseObject);
               }
           }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Response status code: %d", operation.response.statusCode);
              NSLog(@"Response body: %@", operation.responseString);
              NSLog(@"RERROR: %@", error);
              completion(nil, error);
          }];
}

-(NSArray *)venuesForResponse:(NSArray *)venueDictionaries {
    
    NSMutableArray *venues = [NSMutableArray arrayWithCapacity:[venueDictionaries count]];
    
    for (id venueDictionary in venueDictionaries) {
        [venues addObject:[FSQVenue venueWithDictionary:venueDictionary]];
    }
    return venues;
}

-(NSString *)latLongValueForCoordinate:(CLLocationCoordinate2D) coordinates {
    return [NSString stringWithFormat:@"%.2f,%.2f", coordinates.latitude, coordinates.longitude];
}

@end
