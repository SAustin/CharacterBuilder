//
//  EBClassDetailViewController.h
//  CharacterBuilder
//
//  Created by Scott Austin on 11/20/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CharacterClass.h"

@protocol EBClassDetailViewControllerDelegate;

@interface EBClassDetailViewController : UIViewController 
<UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate, UITextFieldDelegate>

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, unsafe_unretained) id<EBClassDetailViewControllerDelegate>delegate;
@property (strong, nonatomic) IBOutlet UILabel *classNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *classRoleLabel;

- (void)configureCell:(UITableViewCell *)cell
          atIndexPath:(NSIndexPath *)indexPath;
- (IBAction)chooseWasPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *classRoleDescriptionLabel;

@end

@protocol EBClassDetailViewControllerDelegate <NSObject>

- (NSManagedObjectContext *)managedObjectContext;
- (void)userDidChooseClass:(CharacterClass *)characterClass;

@end
