//
//  ViewController.m
//  PizzaPlace
//
//  Created by Anthony Figueroa on 9/3/15.
//  Copyright (c) 2015 Anthony Figueroa. All rights reserved.
//

#import "RestaurantsViewController.h"
#import "RestaurantCell.h"
#import "FoursquareProxy.h"
#import "PizzaRestaurant.h"
#import "UIPizzaPlaceDetailsViewController.h"

#define RESTAURANT_CELL_ID @"RestaurantCell"

@interface RestaurantsViewController ()

@end

@implementation RestaurantsViewController
@synthesize restaurantsTable, restaurants;

#pragma mark Lifecycle events
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        [locationManager requestWhenInUseAuthorization];
    
    [locationManager startUpdatingLocation];
    
    [self initializeLocation];
    [self getRestaurants];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) initializeLocation {
    currentLatitude = 40.76336;
    currentLongitude = -73.98287;
}

#pragma mark UITableView datasource
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (restaurants == nil)
    {
        return 0;
    }
    else
        return [restaurants count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RestaurantCell *restaurantCell = [tableView dequeueReusableCellWithIdentifier: RESTAURANT_CELL_ID];
    if (!restaurantCell)
    {
        [tableView registerNib:[UINib nibWithNibName:@"RestaurantCell" bundle:nil] forCellReuseIdentifier:RESTAURANT_CELL_ID];
        restaurantCell = [tableView dequeueReusableCellWithIdentifier: RESTAURANT_CELL_ID];
        
    }
    
    
    return restaurantCell;
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(RestaurantCell *) restaurantCell forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *restaurant = [restaurants objectAtIndex:indexPath.row];
    
    restaurantCell.restaurantName.text = [restaurant objectForKey: @"name"];
}

#pragma mark UITableView delegates
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    selectedRestaurant = [self.restaurants objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"DetailsSegue" sender:self];
}


#pragma mark Backend Integration
-(void) getRestaurants {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
    dispatch_async(queue, ^{
        [[FoursquareProxy getInstance] getRestaurantsForLatitude:currentLatitude Longitude:currentLongitude WithCompletionHandler:^(NSArray *restList) {
            
            restaurants = restList;
            [restaurantsTable reloadData];
            
        }];
    });
}

#pragma mark - CoreLocation stuff

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    currentLatitude = newLocation.coordinate.latitude;
    currentLongitude = newLocation.coordinate.longitude;
}

#pragma mark Segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    NSLog(@"prepareForSegue: %@", segue.identifier);
    if([segue.identifier isEqualToString:@"DetailsSegue"])
    {
        UIPizzaPlaceDetailsViewController *vc = segue.destinationViewController;
        vc.place = selectedRestaurant;
    }
    
}

@end
