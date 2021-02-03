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
NSNumber *eId;
- (void)viewDidLoad {
    [super viewDidLoad];
    eId = [[NSNumber alloc]init];
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
  
    [self getEmployeeID];
}
- (void)viewWillAppear:(BOOL)animated{
    NSLog(@"showing View Controller");
    self.txtName.text =@"";
    self.txtSalary.text =@"";
    self.txtID.text =@"";
    [self getEmployeeID];
}
- (IBAction)saveButtonClicked:(id)sender {
    // Create a new managed object
    NSString *empName = self.txtName.text;
    NSString *empSalary= self.txtSalary.text;
    NSString *empID = self.txtID.text;
    if([empName length] != 0 && [empSalary length] != 0 && [empID length] != 0){
        
    
    NSManagedObjectContext *context = [_appDelegate managedObjectContext];
    NSManagedObject *newEmployee = [NSEntityDescription insertNewObjectForEntityForName:@"Employee" inManagedObjectContext:context];
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *dSalary = [f numberFromString:empSalary];
    NSNumber *eId = [f numberFromString:empID];
//    eId = [NSNumber numberWithInt:1];
//    eId = [NSNumber numberWithInt:[eId intValue]+1];
    [newEmployee setValue:eId forKey:@"id"];
    [newEmployee setValue:empName forKey:@"name"];
    [newEmployee setValue:dSalary forKey:@"salary"];
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    EmployeeList *controller = [[EmployeeList alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
    }
    else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert" message:@"All Required Field." preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                //button click event
                            }];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
       
    }
}

-(void)getEmployeeID{
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
        _txtID.text = [NSString stringWithFormat:@"%@" ,eId!=nil ? eId : 0];
        [_txtID setEnabled:NO];
    }
}
@end
