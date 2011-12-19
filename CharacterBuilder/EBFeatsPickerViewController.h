//
//  EBFeatsPickerViewController.h
//  CharacterBuilder
//
//  Created by Scott Austin on 11/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CharacterFeat.h"

@protocol EBFeatsPickerViewController;

@interface EBFeatsPickerViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) IBOutlet UITextField *featsRemainingTextField;
@property (strong, nonatomic) IBOutlet UITableView *featsTableView;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, unsafe_unretained) id<EBFeatsPickerViewController>delegate;


- (void)configureCell:(UITableViewCell *)cell
          atIndexPath:(NSIndexPath *)indexPath;

@end

@protocol EBFeatsPickerViewController <NSObject>

- (NSManagedObjectContext *)managedObjectContext;

@end