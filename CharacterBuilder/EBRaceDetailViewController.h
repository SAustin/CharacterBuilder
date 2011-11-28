//
//  EBRaceDetailViewController.h
//  CharacterBuilder
//
//  Created by Scott Austin on 11/20/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CharacterRace.h"

@protocol EBRaceDetailViewControllerDelegate;

@interface EBRaceDetailViewController : UIViewController 
<UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate, UITextFieldDelegate>

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, unsafe_unretained) id<EBRaceDetailViewControllerDelegate>delegate;
@property (strong, nonatomic) IBOutlet UILabel *raceNameLabel;

- (void)configureCell:(UITableViewCell *)cell
          atIndexPath:(NSIndexPath *)indexPath;
- (IBAction)chooseWasPressed:(id)sender;

@end

@protocol EBRaceDetailViewControllerDelegate <NSObject>

- (NSManagedObjectContext *)managedObjectContext;
- (void)userDidChooseRace:(CharacterRace *)raceClass;

@end
