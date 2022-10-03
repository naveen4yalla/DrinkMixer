//
//  DrinkDetailViewController.m
//  DrinkMixer
//
//  Created by Naveen Yalla on 9/12/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DrinkDetailViewController :UIViewController{
    @private
    UITextField *nameTextField_;
    UITextView *ingredientsTextView_;
    UITextView *directionsTextView_;
}
@property (nonatomic, retain) IBOutlet UITextField *nameTextField;
@property (nonatomic, retain) IBOutlet UITextView *ingredientsTextView;
@property (nonatomic, retain) IBOutlet UITextView *directionsTextView;

@end
