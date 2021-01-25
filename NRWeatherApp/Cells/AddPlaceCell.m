//
//  AddPlaceCell.m
//  NRWeatherApp
//
//  Created by MacBook on 12/15/20.
//  Copyright © 2020 MacBook. All rights reserved.
//

#import "AddPlaceCell.h"



@implementation AddPlaceCell

- (void)awakeFromNib {
    [super awakeFromNib];
}



- (IBAction)addPlaceButtonPressed {
    if (self.delegate != nil) {
        [self.delegate performAddPlaceAction];
    }
}


@end
