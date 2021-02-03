//
//  ViewController.h
//  CoreDataExample
//
//  Created by differenz157 on 02/02/21.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "EmployeeList.h"
#import <CoreData/CoreData.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *txtID;
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtSalary;
@property(weak,nonatomic)AppDelegate *appDelegate;
- (IBAction)saveButtonClicked:(id)sender;


@end

