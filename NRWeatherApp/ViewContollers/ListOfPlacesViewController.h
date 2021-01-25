//
//  ListOfPlacesViewController.h
//  NRWeatherApp
//
//  Created by MacBook on 12/15/20.
//  Copyright © 2020 MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherCell.h"
#import "AddPlaceCell.h"
#import "WeatherModel.h"
#import "AddPlaceViewController.h"
#import "NRWeatherModelListManager.h"

NS_ASSUME_NONNULL_BEGIN

@class ListOfPlacesViewController ;

@protocol NRListOfPlacesDelegate <NSObject>

-(void) weatherModelToSetOnPlaceVC : (NSInteger) index ;

@end


@interface ListOfPlacesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NRAddPlaceCellDelegate, NRAddPlaceViewContollerDelegate>

@property (weak, nonatomic) id <NRListOfPlacesDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
