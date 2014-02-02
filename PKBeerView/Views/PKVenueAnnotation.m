//
//  PKVenueAnnotation.m
//  PKBeerView
//
//  Created by Patrick King on 2/1/14.
//  Copyright (c) 2014 Patrick King Consulting LLC. All rights reserved.
//

#import "PKVenueAnnotation.h"

@interface PKVenueAnnotation ()

    @property (nonatomic, strong) FSQVenue *venue;

@end

@implementation PKVenueAnnotation

- (id)initWithVenue:(FSQVenue *)venue {
    
    self = [super self];
    
    if(self) {
        
        self.venue = venue;
    }
    
    return self;
}

- (CLLocationCoordinate2D)coordinate {
    return CLLocationCoordinate2DMake([self.venue.latitude floatValue], [self.venue.longitude floatValue]);
}

- (NSString *)title {
    return self.venue.name;
}
                                      

@end