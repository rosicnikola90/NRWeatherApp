//
//  TemperatureModel.m
//  NRWeatherApp
//
//  Created by MacBook on 12/13/20.
//  Copyright © 2020 MacBook. All rights reserved.
//

#import "WeatherModel.h"

@interface WeatherModel ()

@property (nonatomic, strong) NSNumber *temperatureInFar;
@property (nonatomic, strong) NSNumber *temperatureRealFealInFar;
@property (nonatomic, strong) NSNumber *temperatureMAXInFar;
@property (nonatomic, strong) NSNumber *temperatureMINInFar;
@property (nonatomic, strong) NSNumber *humidity;
@property (nonatomic, strong) NSNumber *pressure;
@property (nonatomic, strong) NSNumber *windSpeed;
@property (nonatomic, strong) NSNumber *windDeg;
@property (nonatomic, strong) NSString *nameOfLocation;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSNumber *weatherID;
@property (nonatomic, strong) NSString *weatherDescription;

@end

@implementation WeatherModel

-(void) getRequestWithCurrentPlaceWithLat:(double)lat andLon:(double)lon {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?lat=%f&lon=%f&appid=372f48b67a684d72a7a388742c431ea5", lat, lon]];
    [self dataTaskWithURL:url];
}

-(void) getRequestWithNameOfLocation:(NSString*) name {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?q=%@&appid=372f48b67a684d72a7a388742c431ea5", name ]];
    [self dataTaskWithURL:url];
}

-(void) setWeatherInfoWithTemperature: (NSNumber*) temp  temperatureRealFeal:(NSNumber*) tempRealFeal humidity:(NSNumber*) humidity presure: (NSNumber*) pressure tempMAX: (NSNumber*) tempMax tempMIN: (NSNumber*) tempMin windSpeed: (NSNumber*) windSpeed windDEG: (NSNumber*) windDeg nameOfLocation: (NSString*) nameOfLocation country:(NSString*) country weatherID: (NSNumber*) weatherId weatherDesription:(NSString*) weatherDescr {
    
        [self setTemperatureInFar:temp];
        [self setTemperatureRealFealInFar:tempRealFeal];
        [self setHumidity:humidity];
        [self setPressure:pressure];
        [self setTemperatureMAXInFar:tempMax];
        [self setTemperatureMINInFar:tempMin];
        [self setWindDeg:windDeg];
        [self setWindSpeed:windSpeed];
        [self setNameOfLocation:nameOfLocation];
        [self setCountry:country];
        [self setWeatherID:weatherId];
        [self setWeatherDescription:weatherDescr];
}

-(double) temperatureConversionToCelsiusFromKel: (NSNumber*) tempInFar {
    return tempInFar.doubleValue - 273.15 ;
}
-(NSString*) getCurrentTemperature {
    double tempValue = [self temperatureConversionToCelsiusFromKel:self.temperatureInFar];
    return [NSString stringWithFormat:@"%d", (int)round(tempValue)];
}
-(NSString*) getMAXTemperature {
    double tempValue = [self temperatureConversionToCelsiusFromKel:self.temperatureMAXInFar];
    return [NSString stringWithFormat:@"%d", (int)round(tempValue)] ;
}
-(NSString*) getMINTemperature {
    double tempValue = [self temperatureConversionToCelsiusFromKel:self.temperatureMINInFar];
    return [NSString stringWithFormat:@"%d", (int)round(tempValue)] ;
}
-(NSString*) getRealFealTemperature {
    double tempValue = [self temperatureConversionToCelsiusFromKel:self.temperatureRealFealInFar];
    return [NSString stringWithFormat:@"%d", (int)round(tempValue)] ;
}
-(NSString*) getNameOfLocation {
    return self.nameOfLocation;
}
-(NSString*) getCountryName {
    return self.country;
}
-(NSString*) getPressure {
    return [NSString stringWithFormat:@"%ld", (long)self.pressure.integerValue ];
}
-(NSString*) getHumidity {
    return [NSString stringWithFormat:@"%ld", (long)self.humidity.integerValue ];
}
-(NSString*) getWindSpeed {
    return [NSString stringWithFormat:@"%ld", (long)self.windSpeed.doubleValue ];
}
-(NSString*) getWindDirection {
    
    if (self.windDeg.integerValue >= 337 || self.windDeg.integerValue <= 23) {
        return @"N" ;
    }
    else if (self.windDeg.integerValue > 23 && self.windDeg.integerValue < 68) {
        return @"NE";
    }
    else if (self.windDeg.integerValue > 67 && self.windDeg.integerValue < 112) {
        return @"E" ;
    }
    else if (self.windDeg.integerValue > 111 && self.windDeg.integerValue < 157) {
        return  @"SE";
    }
    else if (self.windDeg.integerValue > 156 && self.windDeg.integerValue < 202) {
        return @"S" ;
    }
    else if (self.windDeg.integerValue > 201 && self.windDeg.integerValue < 247) {
        return @"SW" ;
    }
    else if (self.windDeg.integerValue > 246 && self.windDeg.integerValue < 292) {
        return @"W" ;
    }
    else if (self.windDeg.integerValue > 291 && self.windDeg.integerValue < 337) {
        return @"S" ;
    }
    else {
        return @"-";
    }
}

-(NSString*) getWeatherImageName {
    
    if (0 < self.weatherID.intValue && self.weatherID.intValue < 301) {
        return @"tstorm1" ;
    }
    else if (300 < self.weatherID.intValue && self.weatherID.intValue < 501) {
        return @"light_rain" ;
    }
    else if (500 < self.weatherID.intValue && self.weatherID.intValue < 601) {
        return @"shower3" ;
    }
    else if (600 < self.weatherID.intValue && self.weatherID.intValue < 701) {
        return @"snow4" ;
    }
    else if (700 < self.weatherID.intValue && self.weatherID.intValue < 772) {
        return @"fog" ;
    }
    else if (721 < self.weatherID.intValue && self.weatherID.intValue < 800) {
        return @"tstorm3" ;
    }
    else if ( self.weatherID.intValue == 800) {
        return @"sunny" ;
    }
    else if (800 < self.weatherID.intValue && self.weatherID.intValue < 805) {
        return @"cloudy2" ;
    }
    else if (899 < self.weatherID.intValue && self.weatherID.intValue < 904) {
        return @"tstorm3" ;
    }
    else if (904 < self.weatherID.intValue && self.weatherID.intValue < 1001) {
        return @"tstorm3" ;
    }
    else if ( self.weatherID.intValue == 903) {
        return @"snow5" ;
    }
    else if ( self.weatherID.intValue == 904) {
        return @"sunny" ;
    }
    else {
        return @"dunno";
    }
}

-(NSString*) getUpdateTime {
    self.updatedTime = [[NSString alloc] init];
    NSDate *date = [[NSDate alloc] init];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yy  HH:mm"];
    return [formatter stringFromDate:date];
}

-(void) dataTaskWithURL : (NSURL*) url  {
    NSURLSession *urlSession = NSURLSession.sharedSession;
    if (@available(iOS 11.0, *)) {
        [urlSession.configuration setWaitsForConnectivity:true];
    }
    [[urlSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        __weak WeatherModel *weakSelf = self ;
        if (error == nil) {
            NSError *err ;
            NSDictionary *jsons = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
            
            [weakSelf setWeatherInfoWithTemperature:jsons[@"main"][@"temp"] temperatureRealFeal:jsons[@"main"][@"feels_like"] humidity:jsons[@"main"][@"humidity"] presure:jsons[@"main"][@"pressure"] tempMAX:jsons[@"main"][@"temp_max"] tempMIN:jsons[@"main"][@"temp_min"] windSpeed: jsons[@"wind"][@"speed"] windDEG: jsons[@"wind"][@"deg"] nameOfLocation: jsons [@"name"] country:jsons[@"sys"][@"country"] weatherID: jsons[@"weather"][0][@"id"] weatherDesription:jsons [@"weather"][0][@"description"]];
            
            weakSelf.isModelUpdated = true;
            
            weakSelf.updatedTime = (NSString*)[weakSelf getUpdateTime];
            
            if (weakSelf.delegate != nil) {
                [weakSelf.delegate weatherDataHasBeenUpdatedForWeatherModel:self];
                
            }
            
            if (weakSelf.delegateList != nil) {
                [weakSelf.delegateList weatherDataHasBeenUpdatedForListWeatherModel];
            }
        }
        //error handling
        else {
            if (weakSelf.delegate !=nil){
                [weakSelf.delegate weatherDataErrorPassed:error];
            }
            if (weakSelf.delegateList != nil) {
                [weakSelf.delegateList weatherDataErrorPassed:error forModel:weakSelf];
            }
        }
    }] resume];
}

@end
