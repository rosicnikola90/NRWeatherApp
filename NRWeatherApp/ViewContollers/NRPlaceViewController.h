//
//  ViewController.h
//  NRWeatherApp
//
//  Created by MacBook on 12/11/20.
//  Copyright © 2020 MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "ListOfPlacesViewController.h"
#import "WeatherModel.h"
#import "NRWeatherModelListManager.h"


@interface NRPlaceViewController : UITableViewController <CLLocationManagerDelegate, NRWeatherModelDelegate, NRListOfPlacesDelegate>

@property (strong, nonatomic) WeatherModel *weather;
@property ( nonatomic) NSInteger indexVc;

@end

