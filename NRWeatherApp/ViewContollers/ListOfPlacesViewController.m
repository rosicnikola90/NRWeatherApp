//
//  ListOfPlacesViewController.m
//  NRWeatherApp
//
//  Created by MacBook on 12/15/20.
//  Copyright © 2020 MacBook. All rights reserved.
//

#import "ListOfPlacesViewController.h"
#import "NRPlaceViewController.h"

@interface ListOfPlacesViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) WeatherCell *cellForEdit ;

@end

@implementation ListOfPlacesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:true];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"goToAddPlaceVC"]) {
        AddPlaceViewController *addVC = segue.destinationViewController ;
        [addVC setDelegate:self];
    }
}

#pragma mark - TableView methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return NRWeatherModelListManager.listOfWeatherModels.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (NRWeatherModelListManager.listOfWeatherModels != nil) {
        if (indexPath.row == NRWeatherModelListManager.listOfWeatherModels.count) {
        AddPlaceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addCell" forIndexPath:indexPath];
        [cell setDelegate:self];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else {
    WeatherCell *cell = [tableView dequeueReusableCellWithIdentifier:@"weatherCell" forIndexPath:indexPath];
        //[cell setLongPressDelegate:self];
        WeatherModel *model = NRWeatherModelListManager.listOfWeatherModels[indexPath.row];
        [cell.weatherStatusImage setImage:[UIImage imageNamed:[model getWeatherImageName]]];
        if (model.isModelUpdated == true ) {
        [cell.nameOfPlaceLabel setText:[model getNameOfLocation]];
        
        [cell.temperatureLabel setText:[model getCurrentTemperature]];
        }
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        [cell.contentView.layer setBorderColor:UIColor.blackColor.CGColor];
        [cell.contentView.layer setBorderWidth:1.0];
    return cell;
        }
    }
    else {
        return [[AddPlaceCell alloc]init];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   WeatherCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isMemberOfClass:[WeatherCell class]]) {
        if (self.delegate != nil) {
            [self.delegate weatherModelToSetOnPlaceVC:indexPath.row];
            
        }
        [self.navigationController popViewControllerAnimated:true];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == NRWeatherModelListManager.listOfWeatherModels.count){
    }
    else {
    [NRWeatherModelListManager.listOfWeatherModels removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSIndexPath *indexPathPressedCell  = [self.tableView indexPathForCell:self.cellForEdit];
//    if (indexPathPressedCell.row == indexPath.row){
//        return true;
//    }
//    else {
//        return false;
//    }
// }


//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
//
//}


-(void) setNewLocation : (NSString*) name {
    WeatherModel *newWeatherModel = [[WeatherModel alloc]init];
    newWeatherModel.delegateList = self;

    
    [newWeatherModel getRequestWithNameOfLocation:name];
    [NRWeatherModelListManager.listOfWeatherModels addObject:newWeatherModel];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:NRWeatherModelListManager.listOfWeatherModels.count inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath]
                          withRowAnimation:UITableViewRowAnimationFade];
    
    [self.tableView reloadData];
    
}

-(void) weatherDataHasBeenUpdatedForListWeatherModel {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

-(void) performAddPlaceAction {
    [self performSegueWithIdentifier:@"goToAddPlaceVC" sender:self];
}

//-(void) longPressDetectedForCell: (WeatherCell*) cell {
//    NSLog(@"LONG PRESS Deceted");
//    if (NRWeatherModelListManager.listOfWeatherModels.count >= 2) {
//    self.cellForEdit = cell;
//    [self.tableView setEditing:true];
//    }
//}

- (void)dealloc
{
    NSLog(@"ListOfPlacesVC dealloc");
}

-(void) weatherDataErrorPassed: (NSError*) error forModel:(nonnull WeatherModel *)model {
    
    NSInteger index = [NRWeatherModelListManager.listOfWeatherModels indexOfObject:model];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    
    WeatherCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [cell.errorLabel setHidden:false];
        [cell.errorLabel setText:[NSString stringWithFormat:@"%@", error.localizedDescription ]];
    });
    
}

@end
