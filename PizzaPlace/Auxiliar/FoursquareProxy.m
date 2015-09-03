//
//  FoursquareProxy.m
//  PizzaPlace
//
//  Created by Anthony Figueroa on 9/3/15.
//  Copyright (c) 2015 Anthony Figueroa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FoursquareProxy.h"
#import "AFNetworking/AFNetworking.h"
#import "Constants.h"
#import "CoreHelper.h"
#import "PizzaRestaurant.h"

@implementation FoursquareProxy
// Calls from background thread is assumed

#pragma mark LifeCycle events

- (id)init {
    if (self = [super init]) {
    }
    return self;
}

- (void)dealloc {
    
}

+ (id) getInstance {
    static FoursquareProxy *instance = nil;
    @synchronized(self) {
        if (instance == nil)
            instance = [[self alloc] init];
    }
    return instance;
}

#pragma mark Methods

-(void)getRestaurantsForLatitude: (float) latitude Longitude: (float) longitude WithCompletionHandler:(void (^)(NSArray *restaurants))handler {
    
    NSString *foursquareUrl = [NSString stringWithFormat:@"%@%@?client_id=%@&client_secret=%@&v=%@&ll=%f,%f&query=%@", kBaseURL, kProximitySearch, kClientId, kClientSecret, kApiVersion, latitude, longitude, kApiQuery ];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:foursquareUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *venues = [[responseObject objectForKey:@"response"] objectForKey:@"venues"];
        
        handler(venues);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}


@end