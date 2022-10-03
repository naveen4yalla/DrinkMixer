//
//  AddDrinkViewController.m
//  DrinkMixer
//
//  Created by Naveen Yalla on 9/14/22.
//

#import "AddDrinkViewController.h"
#import "DrinkConstants.h"
@interface AddDrinkViewController ()

@end

@implementation AddDrinkViewController
@synthesize drinkArray= drinkArray;
- (void)viewDidLoad {
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                          target:self action:@selector(cancel:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                                            target:self action:@selector(save:)] ;
}
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSLog(@"%@", @"Registering for keyboard events...");
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    keyboardVisible_ = NO;
     
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)viewWillDisappear:(BOOL)animated {
  NSLog(@"Unregistering for keyboard events");
  [[NSNotificationCenter defaultCenter]
   removeObserver:self];
}
- (IBAction) save: (id) sender {
    NSLog(@"%@", @"Save pressed!");
    
    if (self.drink != nil) {
        // We're working with an existing drink, so let's remove
        // it from the array and just recreate it like we would a new
        // drink...
        [drinkArray removeObject:self.drink];
        self.drink = nil; // This will release our reference and set the property to nil
    }
    
    // Create a new drink dictionary for the new values
    NSMutableDictionary *newDrink = [[NSMutableDictionary alloc] init];
    [newDrink setValue:self.drinkName.text forKey:NAME_KEY];
    [newDrink setValue:self.ingredients.text forKey:INGREDIENTS_KEY];
    [newDrink setValue:self.directions.text forKey:DIRECTIONS_KEY];
    
    // Add it to the master drink array and release our reference
    [drinkArray addObject:newDrink];
   
    
    // Sort the array since we just added a new drink
    NSSortDescriptor *nameSorter = [[NSSortDescriptor alloc] initWithKey:NAME_KEY ascending:YES selector:@selector(caseInsensitiveCompare:)];
    [drinkArray sortUsingDescriptors:[NSArray arrayWithObject:nameSorter]];
   
    
    // Pop the modal view and go back to the list
   // [self dismissModalViewControllerAnimated:YES];
   
   
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction) cancel: (id) sender {
    NSLog(@"%@", @"Cancel pressed!");
    [self dismissModalViewControllerAnimated:YES];
}
- (void) keyboardDidShow:(NSNotification *)notif {
    NSLog(@"%@", @"Received UIKeyboardDidShowNotification");
    
    if (keyboardVisible_) {
        NSLog(@"%@", @"Keyboard is already visible.  Ignoring notifications.");
        return;
    }
    
    // The keyboard wasn't visible before
    NSLog(@"Resizing smaller for keyboard");
    
    // Get the origin of the keyboard when it finishes animating
    NSDictionary *info = [notif userInfo];
    NSValue *aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    // Get the top of the keyboard in view's coordinate system.
    // We need to set the bottom of the scrollview to line up with it
    CGRect keyboardRect = [aValue CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    CGFloat keyboardTop = keyboardRect.origin.y;

    // Resize the scroll view to make room for the keyboard
    CGRect viewFrame = self.view.bounds;
    viewFrame.size.height = keyboardTop - self.view.bounds.origin.y;
    
    self.scrollView.frame = viewFrame;
    keyboardVisible_ = YES;
}
- (void) keyboardDidHide:(NSNotification *)notif {
    NSLog(@"%@", @"Received UIKeyboardDidHideNotification");
    
    if (!keyboardVisible_) {
        NSLog(@"%@", @"Keyboard already hidden.  Ignoring notification.");
        return;
    }
    
    // The keyboard was visible
    NSLog(@"%@", @"Resizing bigger with no keyboard");

    // Resize the scroll view back to the full size of our view
    self.scrollView.frame = self.view.bounds;
    keyboardVisible_ = NO;
}

@end
