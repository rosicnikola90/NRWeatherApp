//
//  PageViewController.m
//  NRWeatherApp
//
//  Created by MacBook on 1/16/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

#import "PageViewController.h"

@interface PageViewController () {
    UIPageControl *pageControl;
    NSInteger pageNo;
    NSMutableArray *arrayOfWeatherModels;
}

@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    arrayOfWeatherModels = [[NSMutableArray alloc]init];
    [self updateArrayOfWeatherModels];
    self.dataSource = self;
    self.delegate = self;
    NRPlaceViewController *initialVC = [self addPlaceViewControllerAtIndex:0];
    [self setViewControllers:@[initialVC] direction:UIPageViewControllerNavigationDirectionForward animated:false completion:nil];
 
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, (self.view.frame.size.height - (self.navigationController.toolbar.frame.size.height + 10)) , self.view.frame.size.width, 10)];
    [pageControl setBackgroundColor:UIColor.clearColor];
    [pageControl setPageIndicatorTintColor:UIColor.grayColor];
    [pageControl setCurrentPageIndicatorTintColor:UIColor.whiteColor];
    [self.view addSubview:pageControl];
    [self updatePageNo];
    [pageControl setUserInteractionEnabled:false];
}
-(NRPlaceViewController *) addPlaceViewControllerAtIndex:(NSInteger)index {
    NRPlaceViewController *placeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PlaceViewController"];
    if (arrayOfWeatherModels.count == 0){
        WeatherModel *model = [[WeatherModel alloc] init];
        [arrayOfWeatherModels addObject:model];
    }
    placeVC.weather = arrayOfWeatherModels[index];
    placeVC.indexVc = index;
    return placeVC;
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSInteger index = ((NRPlaceViewController*) viewController).indexVc;
    if (index == 0 || index == NSNotFound) {
        return nil;
    }
    index--;
    return [self addPlaceViewControllerAtIndex:index];
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    
    NSInteger index = ((NRPlaceViewController*) viewController).indexVc;
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    
    if (index == arrayOfWeatherModels.count) {
        return nil;
    }
    return [self addPlaceViewControllerAtIndex:index];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"goToListView"]) {
        ListOfPlacesViewController *listVC = segue.destinationViewController;
        listVC.delegate = self;
    }
}

// popraviti protokol
-(void) weatherModelToSetOnPlaceVC : (NSInteger) index {
    [self updateArrayOfWeatherModels];
    [self updatePageNo];
    
    NSLog(@"PROTOKOL  viewControllers: %@", self.viewControllers);
    NRPlaceViewController *placeVc = [self addPlaceViewControllerAtIndex:index];
    [self setViewControllers:@[placeVc] direction:UIPageViewControllerNavigationDirectionForward animated:false completion:nil];
    pageNo = index;
    pageControl.currentPage = pageNo;
    
    [self reloadInputViews];
}

- (IBAction)buttonPressed:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"goToListView" sender:self];
}

-(void) updatePageNo {
    pageControl.numberOfPages = arrayOfWeatherModels.count;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    
    pageControl.currentPage = pageNo;
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    
    NRPlaceViewController *placeVc = (NRPlaceViewController*)pendingViewControllers[0] ;
    pageNo = placeVc.indexVc;
}

-(void) updateArrayOfWeatherModels {
    arrayOfWeatherModels = NRWeatherModelListManager.listOfWeatherModels;
}
@end
