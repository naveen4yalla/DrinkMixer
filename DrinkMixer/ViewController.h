//
//  ViewController.h
//  DrinkMixer
//
//  Created by Naveen Yalla on 9/11/22.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray* drinks_;
    UIBarButtonItem* addButton_;
}
- (IBAction)addButtonPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *addButton;

@property (strong, nonatomic) NSMutableArray *drinks;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

