//
//  FSQVenue.h
//  PKBeerView
//
//  Created by Patrick King on 2/1/14.
//  Copyright (c) 2014 Patrick King Consulting LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSQVenue : NSObject

@property (nonatomic, copy) NSString *venueId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSNumber *latitude;
@property (nonatomic, copy) NSNumber *longitude;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, copy) NSString *postalCode;
@property (nonatomic, copy) NSString *country;

+(id)venueWithDictionary:(NSDictionary *)dictionary;
-(id)initWithDictionary:(NSDictionary *)dictionary;

@end