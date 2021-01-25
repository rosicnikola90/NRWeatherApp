//
//  NRWeatherModelListManager.m
//  NRWeatherApp
//
//  Created by MacBook on 1/15/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

#import "NRWeatherModelListManager.h"

@implementation NRWeatherModelListManager

static NSMutableArray *_listOfWeatherModels;

+ ( NSMutableArray *)listOfWeatherModels {
    if (_listOfWeatherModels==nil) {
        _listOfWeatherModels = [[NSMutableArray alloc]init];
    }
    return _listOfWeatherModels;
}

+ (void) setListOfWeatherModels:(NSMutableArray*)model {
    _listOfWeatherModels = [[NSMutableArray alloc]init];
}


@end
