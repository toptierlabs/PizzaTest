//
//  FoursquareProxy.m
//  PizzaPlace
//
//  Created by Anthony Figueroa on 9/3/15.
//  Copyright (c) 2015 Anthony Figueroa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreHelper.h"
#import "Constants.h"

@implementation CoreHelper
// Calls from background thread is assumed

#pragma mark LifeCycle events

- (id)init {
    if (self = [super init]) {
        persistentStoreCoordinator = [self persistentStoreCoordinator];
        if (persistentStoreCoordinator != nil) {
            managedContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
            [managedContext setPersistentStoreCoordinator:persistentStoreCoordinator];
        }
    }
    return self;
}

- (void)dealloc {
    
}

+ (id) getInstance {
    static CoreHelper *instance = nil;
    @synchronized(self) {
        if (instance == nil)
            instance = [[self alloc] init];
    }
    return instance;
}

#pragma mark Methods

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created by merging all of the models found in the application bundle.
 */
- (NSManagedObjectModel *)managedObjectModel {
    
    if (managedObjectModel != nil) {
        return managedObjectModel;
    }
    managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    return managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }
    
    // copy the default store (with a pre-populated data) into our Documents folder
    //
    NSString *documentsStorePath =
    [[[self applicationDocumentsDirectory] path] stringByAppendingPathComponent:@"Recipes.sqlite"];
    
    // if the expected store doesn't exist, copy the default store
    if (![[NSFileManager defaultManager] fileExistsAtPath:documentsStorePath]) {
        NSString *defaultStorePath = [[NSBundle mainBundle] pathForResource:@"Recipes" ofType:@"sqlite"];
        if (defaultStorePath) {
            [[NSFileManager defaultManager] copyItemAtPath:defaultStorePath toPath:documentsStorePath error:NULL];
        }
    }
    
    persistentStoreCoordinator =
    [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    // add the default store to our coordinator
    NSError *error;
    NSURL *defaultStoreURL = [NSURL fileURLWithPath:documentsStorePath];
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                   configuration:nil
                                                             URL:defaultStoreURL
                                                         options:nil
                                                           error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible
         * The schema for the persistent store is incompatible with current managed object model
         Check the error message to determine what the actual problem was.
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    // setup and add the user's store to our coordinator
    NSURL *userStoreURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"UserRecipes.sqlite"];
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                   configuration:nil
                                                             URL:userStoreURL
                                                         options:nil
                                                           error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible
         * The schema for the persistent store is incompatible with current managed object model
         Check the error message to determine what the actual problem was.
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return persistentStoreCoordinator;
}

/**
 Returns the URL to the application's documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

-(void) saveObject: (NSDictionary *) restaurantDic {
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"PizzaRestaurant" inManagedObjectContext: managedContext];
    
    PizzaRestaurant *restaurant = [[PizzaRestaurant alloc] initWithEntity:entity insertIntoManagedObjectContext:managedContext];
    
    restaurant.name = [restaurantDic objectForKey:@"name"];
    restaurant.formatted_phone = [restaurantDic objectForKey:@"formattedPhone"];
    NSDictionary *location = [restaurantDic objectForKey:@"location"];
    
    restaurant.address = [location objectForKey:@"address"];
    restaurant.lat = [[location objectForKey:@"lat"] stringValue];
    restaurant.longitude = [[location objectForKey:@"lng"] stringValue];
    
    [managedContext performBlock:^{
        NSError *saveError = nil;
        if (![managedContext save:&saveError]) {
            NSLog(@"Error saving context: %@", saveError);
        } else {
            [[NSNotificationCenter defaultCenter]
             postNotificationName: kNotificationSavedKey
             object:self];
            NSLog(@"Saved data import in background!");
        }
    }];
}



@end