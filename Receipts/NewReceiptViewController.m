//
//  NewReceiptViewController.m
//  Receipts
//
//  Created by Chloe on 2016-02-04.
//  Copyright © 2016 Chloe Horgan. All rights reserved.
//

#import "NewReceiptViewController.h"
#import "Receipt.h"


@interface NewReceiptViewController () <UITextFieldDelegate, UIPickerViewDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *amountField;
@property (weak, nonatomic) IBOutlet UITextView *descrField;
@property (weak, nonatomic) IBOutlet UITableView *categoryTable;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;

@end

@implementation NewReceiptViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)donePressed:(id)sender {
    [self createReceipt];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Core Data

- (void)createReceipt {
//    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Receipt"
//                                                         inManagedObjectContext:self.managedObjectContext];
    Receipt *receipt = [NSEntityDescription insertNewObjectForEntityForName:@"Receipt" inManagedObjectContext:self.managedObjectContext];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *numberAmount = [formatter numberFromString:self.amountField.text];
    
    receipt.amount = numberAmount;
    receipt.note = self.descrField.text;
    receipt.timeStamp = self.datePicker.date;
    
    NSError *createError = nil;
    
    if (![self.managedObjectContext save:&createError]) {
        NSLog(@"Unable to save managed object context.");
        NSLog(@"%@, %@", createError, createError.localizedDescription);
    }
}

@end
