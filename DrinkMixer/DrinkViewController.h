//
//  DrinkViewController.h
//  DrinkMixer
//
//  Created by Naveen Yalla on 9/12/22.
//

//#ifndef DrinkViewController_h
#define DrinkViewController_h

#include <UIKit/UIKit.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface DrinkViewController : UIViewController{
UITextField *drinkName_;
   
   UIScrollView *scrollView_;
   NSDictionary *drink_;
}


@property (strong, nonatomic) IBOutlet UITextField *drinkName;
@property (strong, nonatomic) IBOutlet UITextView *ingredients;
@property (strong, nonatomic) IBOutlet UITextView *directions;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property(strong, retain) NSDictionary *drink;
@end


NS_ASSUME_NONNULL_END
//#define DetailViewController_h

//#include <UIKit/UIKit.h>

//@interface DetailViewController : UIViewController {
//@private
 //   NSDictionary *drink;
  //  UIScrollView *scrollView_;
//}
//@property (strong, nonatomic) IBOutlet UITextField *drinkName;
//@property (strong, nonatomic) IBOutlet UITextView *ingredients;
//@property (strong, nonatomic) IBOutlet UITextView *directions;
//@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;


//@property(strong, retain) NSDictionary *drink;

//@end

//#endif /* DetailViewController_h */
