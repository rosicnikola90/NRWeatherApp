//
//  AddPlaceViewController.h
//  NRWeatherApp
//
//  Created by MacBook on 12/19/20.
//  Copyright © 2020 MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NRAddPlaceViewContollerDelegate <NSObject>

-(void) setNewLocation : (NSString*) name ;

@end

NS_ASSUME_NONNULL_BEGIN

@interface AddPlaceViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) id <NRAddPlaceViewContollerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
