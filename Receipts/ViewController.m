//
//  ViewController.m
//  Receipts
//
//  Created by Chloe on 2016-02-04.
//  Copyright © 2016 Chloe Horgan. All rights reserved.
//

#import "ViewController.h"
#import "Receipt.h"
#import "NewReceiptViewController.h"
#import "ReceiptCell.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *addReciptButton;
@property (strong, nonatomic) NSArray *receiptsArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;
}

- (void)viewWillAppear:(BOOL)animated {
    [self fetchReceipt];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addRecipt:(id)sender {
    [self performSegueWithIdentifier:@"addReceipt" sender:sender];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"addReceipt"]) {
        NewReceiptViewController *controller = (NewReceiptViewController *)segue.destinationViewController;
        controller.managedObjectContext = self.managedObjectContext;
    }
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.receiptsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReceiptCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    Receipt *receipt = self.receiptsArray[indexPath.row];
    cell.receiptLabel.text = receipt.note;
    return cell;
}

#pragma mark - CREATE

- (void)createReceipt {
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Receipt"
                                                         inManagedObjectContext:self.managedObjectContext];
    Receipt *receipt = [[Receipt alloc] initWithEntity:entityDescription
                        insertIntoManagedObjectContext:self.managedObjectContext];
    
    receipt.amount = @50;
    receipt.note = @"Testing";
    
    NSError *createError = nil;
    
    if (![receipt.managedObjectContext save:&createError]) {
        NSLog(@"Unable to save managed object context.");
        NSLog(@"%@, %@", createError, createError.localizedDescription);
    }

}

#pragma mark - READ

- (void)fetchReceipt {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Receipt" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *readError = nil;
    
    self.receiptsArray = [self.managedObjectContext executeFetchRequest:fetchRequest error:&readError];

    NSLog(@"%@", self.receiptsArray);

    
//    if (result.count > 0) {
//                NSManagedObject *person = (NSManagedObject *)[result objectAtIndex:0];
//                NSLog(@"1 - %@", person);
//        
//                NSLog(@"%@ %@", [person valueForKey:@"first"], [person valueForKey:@"last"]);
//        
//                NSLog(@"2 - %@", person);
//            }

}

//#pragma mark - UPDATE
//
//- (void)updateReceipt {
//        Receipt *receipt = (Receipt *)[result objectAtIndex:0];
//    
//        [recept setValue:@30 forKey:@"amount"];
//    
//        NSError *saveError = nil;
//    
//        if (![person.managedObjectContext save:&saveError]) {
//            NSLog(@"Unable to save managed object context.");
//            NSLog(@"%@, %@", saveError, saveError.localizedDescription);
//        }
//}
//
//#pragma mark - DELETE
//
//    [self.managedObjectContext deleteObject:receipt];
//
//    NSError *deleteError = nil;
//
//    if (![receipt.managedObjectContext save:&deleteError]) {
//        NSLog(@"Unable to save managed object context.");
//        NSLog(@"%@, %@", deleteError, deleteError.localizedDescription);
//    }


@end
