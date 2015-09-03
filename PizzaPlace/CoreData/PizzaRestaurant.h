//
//  PizzaRestaurant.h
//  PizzaPlace
//
//  Created by Anthony Figueroa on 9/3/15.
//  Copyright (c) 2015 Anthony Figueroa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PizzaRestaurant : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * formatted_phone;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * lat;
@property (nonatomic, retain) NSString * longitude;

@end
