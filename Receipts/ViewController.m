//
//  ViewController.m
//  Receipts
//
//  Created by Chloe on 2016-02-04.
//  Copyright © 2016 Chloe Horgan. All rights reserved.
//

#import "ViewController.h"
#import "Receipt.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *addReciptButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;

    [self createReceipt];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addRecipt:(id)sender {
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
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

    //    [info enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
    //        [mObj setValue:obj forKey:key];
    //    }];
    
    NSError *createError = nil;
    
    if (![receipt.managedObjectContext save:&createError]) {
        NSLog(@"Unable to save managed object context.");
        NSLog(@"%@, %@", createError, createError.localizedDescription);
    }
    
    NSLog(@"%@", receipt);
}

#pragma mark - READ

- (void)fetchReceipt {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Receipt" inManagedObjectContext:self.managedObjectContext];
    fetchRequest.entity = entity;
    
    NSError *readError = nil;
    
    NSArray *result = [self.managedObjectContext executeFetchRequest:fetchRequest error:&readError];
    
//    if (result.count > 0) {
//                NSManagedObject *person = (NSManagedObject *)[result objectAtIndex:0];
//                NSLog(@"1 - %@", person);
//        
//                NSLog(@"%@ %@", [person valueForKey:@"first"], [person valueForKey:@"last"]);
//        
//                NSLog(@"2 - %@", person);
//            }

}

#pragma mark - UPDATE

//- (void)updateReceipt {
//        Receipt *receipt = (Receipt *)[result objectAtIndex:0];
//    
//        [person setValue:@30 forKey:@"age"];
//    
//        NSError *saveError = nil;
//    
//        if (![person.managedObjectContext save:&saveError]) {
//            NSLog(@"Unable to save managed object context.");
//            NSLog(@"%@, %@", saveError, saveError.localizedDescription);
//        }
//}

#pragma mark - DELETE


@end
