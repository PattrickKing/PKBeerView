//
//  FSQFourSquareProxy.m
//  PKBeerView
//
//  Created by Patrick King on 2/2/14.
//  Copyright (c) 2014 Patrick King Consulting LLC. All rights reserved.
//

#import "FSQFourSquareProxy.h"

@implementation FSQFourSquareProxy

+ (FSQFourSquareProxy *)proxy {
    
    static FSQFourSquareProxy *_proxy = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _proxy = [[FSQFourSquareProxy alloc] init];
    });
    
    return _proxy;
}

- (void)fetchVenuesNear:(CLLocationCoordinate2D)coordinates
            searchTerm:(NSString *)searchTerm
        radiusInMeters:(CGFloat)radius
            completion:(FSQVenuesBlock)completion {
    
    [[AFHTTPSessionManager manager] GET:[self searchVenuesUrl]
                             parameters:[self buildParams:coordinates radius:radius query:searchTerm]
                                success:^(NSURLSessionDataTask *task, id responseObject) {
                                    NSArray *venues = [self venuesForResponse:responseObject[@"response"][@"venues"]];
                                    completion(venues, nil);
                                }
                                failure:^(NSURLSessionDataTask *task, NSError *error) {
                                    NSLog(@"RERROR: %@", error);
                                    completion(nil, error);
                                }];
}

- (id)buildParams:(CLLocationCoordinate2D)coordinates
           radius:(CGFloat)radius
            query:(NSString *)query {
    
    id params = @{
                  @"client_id": FOURSQUARE_APP_CLIENT_ID,
                  @"client_secret": FOURSQUARE_APP_CLIENT_SECRET,
                  @"v": @"20130815",
                  @"ll": [self latLongValueForCoordinate:coordinates],
                  @"radius": @(radius),
                  @"query": query,
                  @"intent": @"browse"
                  };
    return params;
}

- (NSString *)latLongValueForCoordinate:(CLLocationCoordinate2D) coordinates {
    return [NSString stringWithFormat:@"%.2f,%.2f", coordinates.latitude, coordinates.longitude];
}

- (NSString *)searchVenuesUrl {
    return [NSString stringWithFormat:@"%@%@", FOURSQUARE_BASE_URL, @"venues/search"];
}

-(NSArray *)venuesForResponse:(NSArray *)venueDictionaries {
    
    NSMutableArray *venues = [NSMutableArray arrayWithCapacity:[venueDictionaries count]];
    
    for (id venueDictionary in venueDictionaries) {
        [venues addObject:[FSQVenue venueWithDictionary:venueDictionary]];
    }
    return venues;
}

@end
