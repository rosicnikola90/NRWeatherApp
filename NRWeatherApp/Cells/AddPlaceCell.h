//
//  AddPlaceCell.h
//  NRWeatherApp
//
//  Created by MacBook on 12/15/20.
//  Copyright © 2020 MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol NRAddPlaceCellDelegate <NSObject>

-(void) performAddPlaceAction;

@end

@interface AddPlaceCell : UITableViewCell

@property (weak, nonatomic) id <NRAddPlaceCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
