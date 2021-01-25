//
//  TemperatureModel.h
//  NRWeatherApp
//
//  Created by MacBook on 12/13/20.
//  Copyright © 2020 MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@class WeatherModel ;

@protocol NRWeatherModelDelegate <NSObject>

-(void) weatherDataHasBeenUpdatedForWeatherModel: (WeatherModel*) model ;
-(void) weatherDataErrorPassed: (NSError*) error ;

@end

@protocol NRWeatherModelDelegateForList <NSObject>

-(void) weatherDataHasBeenUpdatedForListWeatherModel;
-(void) weatherDataErrorPassed: (NSError*) error forModel: (WeatherModel*) model;

@end

@interface WeatherModel : NSObject

@property (nonatomic, weak) id <NRWeatherModelDelegate> delegate;
@property (nonatomic, weak) id <NRWeatherModelDelegateForList> delegateList;
@property (nonatomic) BOOL isModelUpdated;
@property (nonatomic, strong) NSString *updatedTime ;

-(void) getRequestWithCurrentPlaceWithLat:(double)lat andLon:(double)lon;
-(void) getRequestWithNameOfLocation:(NSString*) name;

-(NSString*) getCurrentTemperature;
-(NSString*) getMAXTemperature;
-(NSString*) getMINTemperature;
-(NSString*) getRealFealTemperature;
-(NSString*) getNameOfLocation;
-(NSString*) getCountryName;
-(NSString*) getWeatherImageName;
-(NSString*) getWindDirection;
-(NSString*) getPressure;
-(NSString*) getHumidity;
-(NSString*) getWindSpeed;



@end

NS_ASSUME_NONNULL_END
