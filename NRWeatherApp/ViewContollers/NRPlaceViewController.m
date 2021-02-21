//
//  ViewController.m
//  NRWeatherApp
//
//  Created by MacBook on 12/11/20.
//  Copyright © 2020 MacBook. All rights reserved.
//

#import "NRPlaceViewController.h"

@interface NRPlaceViewController ()

@property (strong, nonatomic) CLLocationManager *locationManager ;
@property (strong, nonatomic) CLLocation *userLocation;
@property (strong, nonatomic) NSURL *url ;

@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *realFealLabel;
@property (weak, nonatomic) IBOutlet UILabel *countryLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempMinLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempMaxLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImage;
@property (weak, nonatomic) IBOutlet UILabel *pressureLabel;
@property (weak, nonatomic) IBOutlet UILabel *humidityLabel;
@property (weak, nonatomic) IBOutlet UILabel *windInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *windDirectionLabel;
@property (weak, nonatomic) IBOutlet UILabel *updatedTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;

@end

@implementation NRPlaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.weather == nil) {
        self.weather = [self setInitWeatherModel];
    }
    self.weather.delegate = self;
    
    if (self.weather.isModelUpdated == false){
        [self setAndConfigureLocationManager];
    }
    [self.navigationController.navigationBar setHidden:true];
        if (NRWeatherModelListManager.listOfWeatherModels.count == 0) {
            [NRWeatherModelListManager.listOfWeatherModels addObject:self.weather];
        }
    if (self.weather.isModelUpdated == true) {
    [self updateUI];
    }
    
}

-(WeatherModel*) setInitWeatherModel {
    WeatherModel *model = [[WeatherModel alloc] init];
    return  model;
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
    [self.locationManager startUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    if (locations.lastObject != nil){
    self.userLocation = locations.lastObject;
    [self.locationManager stopUpdatingLocation];
    [self.weather getRequestWithCurrentPlaceWithLat:self.userLocation.coordinate.latitude andLon:self.userLocation.coordinate.longitude];
    }
}

-(void) setAndConfigureLocationManager {
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager setDelegate:self];
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    [self.locationManager setDistanceFilter:100.0];
}

-(void) updateUI {
    [self.temperatureLabel setText:self.weather.getCurrentTemperature];
    [self.locationLabel setText:self.weather.getNameOfLocation];
    [self.realFealLabel setText:self.weather.getRealFealTemperature ];
    [self.countryLabel setText:self.weather.getCountryName];
    [self.tempMaxLabel setText:self.weather.getMAXTemperature];
    [self.tempMinLabel setText:self.weather.getMINTemperature];
    [self.weatherImage setImage:[UIImage imageNamed:self.weather.getWeatherImageName]];
    [self.pressureLabel setText:self.weather.getPressure];
    [self.humidityLabel setText:self.weather.getHumidity];
    [self.windDirectionLabel setText:[self.weather getWindDirection]];
    [self.windInfoLabel setText:self.weather.getWindSpeed];
    [self.updatedTimeLabel setText:[NSString stringWithFormat:@"last update: %@", self.weather.updatedTime]];
    [self.errorLabel setHidden:true];
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([segue.identifier isEqualToString: @"showListOfPlaces"]) {
//        ListOfPlacesViewController *listVC = segue.destinationViewController;
//        ListOfPlacesViewController __weak *weakListVC = listVC;
//        [listVC setDelegate:weakListVC];
//    }
//}



#pragma mark - delegate methods

- (void)weatherDataHasBeenUpdatedForWeatherModel:(nonnull WeatherModel *)model {
    self.weather = model ;
    dispatch_async(dispatch_get_main_queue(), ^{
            __weak NRPlaceViewController *weakSelf = self;
            [weakSelf updateUI];
    });
}

-(void) weatherDataErrorPassed: (NSError*) error {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.errorLabel setText:[NSString stringWithFormat:@"%@", error.localizedDescription]];
        [self.errorLabel setHidden:false];
    });
}


@end
