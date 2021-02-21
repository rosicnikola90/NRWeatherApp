//
//  WeatherCell.h
//  NRWeatherApp
//
//  Created by MacBook on 12/15/20.
//  Copyright © 2020 MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//@class WeatherCell;

//@protocol LongPressDelegate <NSObject>
//
//-(void) longPressDetectedForCell: (WeatherCell*) cell ;

//@end


@interface WeatherCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameOfPlaceLabel ;
@property (weak, nonatomic) IBOutlet UIImageView *weatherStatusImage;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;

//@property(weak, nonatomic) id <LongPressDelegate> longPressDelegate;

@end

NS_ASSUME_NONNULL_END
