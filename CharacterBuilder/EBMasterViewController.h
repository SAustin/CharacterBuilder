//
//  EBMasterViewController.h
//  CharacterBuilder
//
//  Created by Scott Austin on 11/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EBDetailViewController;

#import <CoreData/CoreData.h>

@interface EBMasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) EBDetailViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
