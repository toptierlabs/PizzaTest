//
//  ViewController.h
//  PizzaPlace
//
//  Created by Anthony Figueroa on 9/3/15.
//  Copyright (c) 2015 Anthony Figueroa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "PizzaRestaurant.h"

@interface RestaurantsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate> {
    
    // Location stuff
    CLLocationManager *locationManager;
    CLLocationDegrees currentLatitude;
    CLLocationDegrees currentLongitude;
    
    NSArray *restaurants;
    NSDictionary *selectedRestaurant;
    
}

@property (nonatomic, weak) IBOutlet UITableView *restaurantsTable;
@property (nonatomic, strong) NSArray *restaurants;



@end

