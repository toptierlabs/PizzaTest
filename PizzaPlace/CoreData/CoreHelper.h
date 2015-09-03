//
//  FoursquareProxy.h
//  PizzaPlace
//
//  Created by Anthony Figueroa on 9/3/15.
//  Copyright (c) 2015 Anthony Figueroa. All rights reserved.
//

#ifndef PizzaPlace_CoreHelper_h
#define PizzaPlace_CoreHelper_h


#import <UIKit/UIKit.h>
#import "PizzaRestaurant.h"

@interface CoreHelper: NSObject
{
    NSManagedObjectContext *managedContext;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    NSManagedObjectModel *managedObjectModel;
}

+ (id) getInstance;
-(PizzaRestaurant *)parseRestaurant: (NSDictionary *) restaurantDic;
-(void) saveObject :(NSDictionary *) pizzaRest;
@end


#endif
