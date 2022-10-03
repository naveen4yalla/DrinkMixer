//
//  DrinkViewController.m
//  DrinkMixer
//
//  Created by Naveen Yalla on 9/12/22.
//
#import "DrinkViewController.h"
#import "DrinkConstants.h"
@interface DrinkViewController ()

@end

@implementation DrinkViewController

@synthesize drink = drink_;
@synthesize scrollView =scrollView_;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView.contentSize = self.view.frame.size;
}
-(void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
    self.drinkName.text = [self.drink objectForKey:NAME_KEY];
    self.ingredients.text = [self.drink objectForKey:INGREDIENTS_KEY];
    self.directions.text = [self.drink objectForKey:DIRECTIONS_KEY];
 
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
