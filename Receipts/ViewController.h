//
//  ViewController.h
//  Receipts
//
//  Created by Chloe on 2016-02-04.
//  Copyright © 2016 Chloe Horgan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

@interface ViewController : UIViewController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end

