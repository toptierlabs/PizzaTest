//
//  FoursquareProxy.h
//  PizzaPlace
//
//  Created by Anthony Figueroa on 9/3/15.
//  Copyright (c) 2015 Anthony Figueroa. All rights reserved.
//

#ifndef PizzaPlace_FoursquareProxy_h
#define PizzaPlace_FoursquareProxy_h


#import <UIKit/UIKit.h>

@interface FoursquareProxy: NSObject

+ (id) getInstance;

-(void)getRestaurantsForLatitude: (float) latitude Longitude: (float) longitude WithCompletionHandler:(void (^)(NSArray *restaurants))handler;

@end


#endif
