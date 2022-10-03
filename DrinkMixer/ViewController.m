//
//  ViewController.m
//  DrinkMixer
//
//  Created by Naveen Yalla on 9/11/22.
//

#import "ViewController.h"
#import "DrinkViewController.h"
#import "DrinkConstants.h"
#import "AddDrinkViewController.h"
@interface ViewController ()

@end

@implementation ViewController
@synthesize drinks = drinks_;
@synthesize addButton = addButton_;

#pragma mark -
#pragma mark View lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
   // NSString *plistSource = [[NSBundle mainBundle]pathForResource:@"DrinkArray" ofType:@"plist"];
    //    drinks_=[[NSMutableArray alloc]initWithContentsOfFile:plistSource];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"DrinkDirections" ofType:@"plist"];
    drinks_ = [[NSMutableArray alloc] initWithContentsOfFile:path];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.navigationItem.rightBarButtonItem = self.addButton;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                          selector:@selector(applicationDidEnterBackground:)
                                          name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    
    
}
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    NSLog(@"%lu",[self.drinks count]);
}
-(void)applicationDidEnterBackground:(NSNotification *)notify{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"DrinkDirections" ofType:@"plist"];
    //drinks_ = [[NSMutableArray alloc] initWithContentsOfFile:path];
    [drinks_ writeToFile:path atomically:YES];
}






#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(!self.editing){
        DrinkViewController *detailViewController =  [[DrinkViewController alloc] initWithNibName:@"DrinkViewController"
                                                                                           bundle:nil];
        detailViewController.drink = [self.drinks objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:detailViewController animated:YES];
        [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    }
    else {
        NSLog(@"cliked add button");
      //AddDrinkViewController *editingDrinkVC = [self.storyboard instantiateViewControllerWithIdentifier:@"addDrinkVC"];
      AddDrinkViewController *editingDrinkVC = [[AddDrinkViewController alloc]initWithNibName:@"DrinkViewController" bundle:nil];
      editingDrinkVC.drink = [self.drinks objectAtIndex:indexPath.row];
      editingDrinkVC.drinkArray = self.drinks;
      
      UINavigationController *editingNavCon = [[UINavigationController alloc] initWithRootViewController:editingDrinkVC];
        //editingNavCon.modalPresentationStyle=UIModalPresentationOverFullScreen;;
      [self presentViewController:editingNavCon animated:YES completion:nil];
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    }
}
#pragma mark -
#pragma mark Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView; {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.drinks count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
   // cell.textLabel.text =[drinks_ objectAtIndex:indexPath.row];
    cell.textLabel.text = [[self.drinks objectAtIndex:indexPath.row] objectForKey:NAME_KEY];
    //cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


#pragma mark -
#pragma mark Actions

- (IBAction)addButtonPressed:(id)sender{
    NSLog(@"%@", @"Add button pressed.");
    
    AddDrinkViewController *addViewController = [[AddDrinkViewController alloc]initWithNibName:@"DrinkViewController" bundle:nil];
   
   
    UINavigationController *addNavController = [[UINavigationController alloc] initWithRootViewController:addViewController];
    addViewController.drinkArray = self.drinks;
    NSLog(@"creating NSNotification for ReloadNotification");
    
    [[NSNotificationCenter defaultCenter]
        addObserver:self
        selector:@selector(receiveNotification:)
        name:@"ReloadNotification"
        object:nil];
    
    //[self presentViewController:addNavController animated:YES completion:nil];
    addViewController.modalPresentationStyle=UIModalPresentationOverFullScreen;
    [self presentViewController:addNavController animated:YES completion:nil];
}



- (void)receiveNotification:(NSNotification *)notif {
  NSLog(@"in receiveNotification, reloading data...");
  [self.tableView reloadData];
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}




//overide editing style

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
   //from ios13 viewwillappear wont work when navigated back from sheet
    [self.tableView reloadData];
    [self setEditing:true animated:true];
   // [super setEditing:true animated:true];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
    
        [self.drinks removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
       
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

//setting the delete icon to all the items in the list 

-(void)setEditing:(BOOL)editing animated:(BOOL)animated {

    [super setEditing:editing animated:animated];

    if(editing) {
        //Do something for edit mode
        [self.tableView setEditing:true animated:true];
    }

    else {
        //Do something for non-edit mode
        [self.tableView setEditing:false animated:false];
    }

}



-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{

return YES;

}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
return UITableViewCellEditingStyleDelete; }




@end
