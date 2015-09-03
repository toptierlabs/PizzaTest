//
//  UIPizzaPlaceDetailsViewController.m
//  PizzaPlace
//
//  Created by Anthony Figueroa on 9/3/15.
//  Copyright (c) 2015 Anthony Figueroa. All rights reserved.
//

#import "UIPizzaPlaceDetailsViewController.h"
#import "CoreHelper.h"
#import "Constants.h"

@interface UIPizzaPlaceDetailsViewController ()

@end

@implementation UIPizzaPlaceDetailsViewController
@synthesize place;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (place != nil)
    {
        NSDictionary *location = [place objectForKey:@"location"];
        self.restaurantName.text = [place objectForKey: @"name"];
        self.restaurantPhone.text = [place objectForKey: @"formattedPhone"];
        self.restaurantAddress.text = [location objectForKey:@"address"];
        self.restaurantlatitude.text = [[location objectForKey:@"lat"] stringValue];
        self.restaurantlongitude.text = [[location objectForKey:@"lng"] stringValue];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(objectSaved)
                                                     name:kNotificationSavedKey
                                                   object:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Events
-(IBAction) back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction) save:(id)sender {
    [[CoreHelper getInstance] saveObject:place];
}

-(void) objectSaved {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Saved"
                                                        message:@"This is a small alert indicating that we are listening to a notification"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    });
    

}
@end
