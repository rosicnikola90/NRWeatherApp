//
//  PageViewController.h
//  NRWeatherApp
//
//  Created by MacBook on 1/16/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaceViewController.h"
#import "WeatherModel.h"
#import "ListOfPlacesViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PageViewController : UIPageViewController <UIPageViewControllerDataSource, NRListOfPlacesDelegate, UIPageViewControllerDelegate>

@end

NS_ASSUME_NONNULL_END
