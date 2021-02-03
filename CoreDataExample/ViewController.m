//
//  ViewController.m
//  CoreDataExample
//
//  Created by differenz157 on 02/02/21.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController
NSMutableArray *devices;
- (void)viewDidLoad {
    [super viewDidLoad];
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    //Setting Employee ID
    NSManagedObjectContext *context = [_appDelegate managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Employee"];
    devices = [[context executeFetchRequest:fetchRequest error:nil] mutableCopy];
    if([devices count]>0)
    {
        NSManagedObject *device = [devices objectAtIndex:[devices count] - 1];
        NSLog(@"%@",[device valueForKey:@"id"]);
        NSLog(@"%@",[device valueForKey:@"name"]);
        NSLog(@"%@",[device valueForKey:@"salary"]);
        
        NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
        f.numberStyle = NSNumberFormatterDecimalStyle;
        NSNumber *eId = [f numberFromString:[NSString stringWithFormat:@"%@" ,[device valueForKey:@"id"]]];
        eId = [NSNumber numberWithInt:[eId intValue] + 1];
        
        _txtID.text = [NSString stringWithFormat:@"%@" ,eId];
        [_txtID setEnabled:NO];
    }
}
- (IBAction)saveButtonClicked:(id)sender {
    // Create a new managed object
    NSManagedObjectContext *context = [_appDelegate managedObjectContext];
    //For Saving Data
    NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Employee" inManagedObjectContext:context];
    
    NSString *empName = self.txtName.text;
    NSString *empSalary= self.txtSalary.text;
    NSString *empID = self.txtID.text;
    
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *dSalary = [f numberFromString:empSalary];
    NSNumber *eId = [f numberFromString:empID];
//    eId = [NSNumber numberWithInt:1];
//    eId = [NSNumber numberWithInt:[eId intValue]+1];
    
    
    
    [newDevice setValue:eId forKey:@"id"];
    [newDevice setValue:empName forKey:@"name"];
    [newDevice setValue:dSalary forKey:@"salary"];
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    EmployeeList *controller = [[EmployeeList alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
    
}
@end
