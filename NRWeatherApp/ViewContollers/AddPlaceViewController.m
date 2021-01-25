//
//  AddPlaceViewController.m
//  NRWeatherApp
//
//  Created by MacBook on 12/19/20.
//  Copyright © 2020 MacBook. All rights reserved.
//

#import "AddPlaceViewController.h"

@interface AddPlaceViewController ()
@property (weak, nonatomic) IBOutlet UITextField *placeTextField;

@end

@implementation AddPlaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.placeTextField becomeFirstResponder];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmissKeyboard)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)viewWillDisappear:(BOOL)animated {
    NSLog(@"AddPlaceViewController viewWillDisappear");
}

- (void)dealloc
{
    NSLog(@"AddPlaceViewController dealloc");
}
- (IBAction)findPlacePressedButton:(UIButton *)sender {
    [self dissmissKeyboard];
    if (self.delegate != nil) {
        [self.delegate setNewLocation:self.placeTextField.text];
    }
    [self.navigationController popViewControllerAnimated:true];
}

-(void) dissmissKeyboard {
    [self.placeTextField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self dissmissKeyboard];
    return true;
}


@end
