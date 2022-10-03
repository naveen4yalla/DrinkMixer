//
//  AddDrinkViewController.h
//  DrinkMixer
//
//  Created by Naveen Yalla on 9/14/22.
//

#import <UIKit/UIKit.h>
#import "DrinkViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface AddDrinkViewController : DrinkViewController{
    BOOL keyboardVisible_;
    NSMutableArray *drinkArray;
}
- (IBAction) save: (id) sender;
- (IBAction) cancel: (id) sender;
@property (nonatomic, retain) NSMutableArray *drinkArray;
- (void) keyboardDidShow:(NSNotification *)notif;
- (void) keyboardDidHide:(NSNotification *)notif;

@end


NS_ASSUME_NONNULL_END
