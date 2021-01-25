//
//  NRWeatherModelListManager.h
//  NRWeatherApp
//
//  Created by MacBook on 1/15/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NRWeatherModelListManager : NSObject 

@property (nonatomic, class, retain) NSMutableArray *listOfWeatherModels;

+ (void) setListOfWeatherModels:(NSMutableArray*)model;
+ ( NSMutableArray *)listOfWeatherModels ;
@end

NS_ASSUME_NONNULL_END
