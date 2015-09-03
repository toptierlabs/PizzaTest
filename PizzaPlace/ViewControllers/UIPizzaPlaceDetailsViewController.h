//
//  UIPizzaPlaceDetailsViewController.h
//  PizzaPlace
//
//  Created by Anthony Figueroa on 9/3/15.
//  Copyright (c) 2015 Anthony Figueroa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PizzaRestaurant.h"

@interface UIPizzaPlaceDetailsViewController : UIViewController {
    NSDictionary *place;
}

@property(weak, nonatomic) IBOutlet UILabel *restaurantName;
@property(weak, nonatomic) IBOutlet UILabel *restaurantAddress;
@property(weak, nonatomic) IBOutlet UILabel *restaurantPhone;
@property(weak, nonatomic) IBOutlet UILabel *restaurantlatitude;
@property(weak, nonatomic) IBOutlet UILabel *restaurantlongitude;
@property(strong, nonatomic) NSDictionary *place;

@end
