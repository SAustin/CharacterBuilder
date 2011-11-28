//
//  EBMasterViewController.m
//  CharacterBuilder
//
//  Created by Scott Austin on 11/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "EBMasterViewController.h"

#import "EBDetailViewController.h"

@interface EBMasterViewController ()
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation EBMasterViewController

@synthesize detailViewController = _detailViewController;
@synthesize fetchedResultsController = __fetchedResultsController;
@synthesize managedObjectContext = __managedObjectContext;

- (void)awakeFromNib
{
    self.clearsSelectionOnViewWillAppear = NO;
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    [super awakeFromNib];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.detailViewController = (EBDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    self.detailViewController.delegate = self;
    // Set up the edit and add buttons.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd 
                                                                               target:self 
                                                                               action:@selector(insertNewObject)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    [self prepDatabase];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

#pragma mark - Table View Methods

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CharacterCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [self configureCell:cell 
            atIndexPath:indexPath];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView 
 canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView 
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle 
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the managed object for the given index path
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        // Save the context.
        NSError *error = nil;
        if (![context save:&error]) {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }   
}

- (BOOL)tableView:(UITableView *)tableView 
canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // The table view should not be re-orderable.
    return NO;
}

- (void)tableView:(UITableView *)tableView 
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSManagedObject *selectedObject = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    //self.detailViewController.detailItem = selectedObject;    
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (__fetchedResultsController != nil) {
        return __fetchedResultsController;
    }
    
    // Set up the fetched results controller.
    // Create the fetch request for the entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Character" 
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest 
                                                                                                managedObjectContext:self.managedObjectContext 
                                                                                                  sectionNameKeyPath:nil cacheName:@"Master"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
	    /*
	     Replace this implementation with code to handle the error appropriately.

	     abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
	     */
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return __fetchedResultsController;
}    

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

/*
// Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed. 
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    // In the simplest, most efficient, case, reload the table view.
    [self.tableView reloadData];
}
 */

- (void)configureCell:(UITableViewCell *)cell 
          atIndexPath:(NSIndexPath *)indexPath
{
    Character *character = [self.fetchedResultsController objectAtIndexPath:indexPath];
    CharacterClass *characterClass = character.characterClass;
    CharacterRace *characterRace = character.characterRace;
    ((UILabel *)[cell viewWithTag:1]).text = character.name;
    ((UILabel *)[cell viewWithTag:2]).text = [NSString stringWithFormat:@"%@ - %@", 
                                              characterClass.name,
                                              characterRace.name];
}
/*
- (void)insertNewObject
{
    // Create a new instance of the entity managed by the fetched results controller.
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
    
    // If appropriate, configure the new managed object.
    // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}
*/
- (void)prepDatabase
{
    NSManagedObjectContext *context = self.managedObjectContext;

    NSError *error;
    CharacterClass *characterClass = [NSEntityDescription insertNewObjectForEntityForName:@"CharacterClass" 
                                                                   inManagedObjectContext:context];
    
    characterClass.name = @"Ranger";
    characterClass.role = @"Striker";
    characterClass.roleDescription = @"You concentrate on either ranged attacks or two-weapon melee fighting to deal a lot of damage to one enemy at a time. Your attacks rely on speed and mobility, since you prefer to use hit-and- run tactics whenever possible.";
    characterClass.powerSource = @"Martial";
    characterClass.powerSourceDescription = @"Your talents depend on extensive training and practice, inner confidence, and natural proficiency";
    characterClass.keyStrengths = @"Strength, Dexterity, Wisdom";
    characterClass.armorProf = @"Cloth, Leather, Hide";
    characterClass.meleeProf = @"Military";
    characterClass.rangedProf = @"Military";
    characterClass.weaponProf = @"";    
    characterClass.implement = @"";
    characterClass.armorClassBonus = [NSNumber numberWithInt:0];
    characterClass.fortitudeBonus = [NSNumber numberWithInt:1];
    characterClass.reflexBonus = [NSNumber numberWithInt:1];
    characterClass.willBonus = [NSNumber numberWithInt:1];
    characterClass.baseHitPoints = [NSNumber numberWithInt:12];
    characterClass.hitPointModifier = @"Constitution";
    characterClass.hitPointsPerLevel = [NSNumber numberWithInt:5];
    characterClass.healingSurgesPerDay = [NSNumber numberWithInt:6];
    characterClass.healingSurgModifier = @"Constitution";
    characterClass.firstLevelSkillCount = [NSNumber numberWithInt:4];
    characterClass.acrobaticsSkill = [NSNumber numberWithInt:1];
    characterClass.arcanaSkill = [NSNumber numberWithInt:0];
    characterClass.athleticsSkill = [NSNumber numberWithInt:1];
    characterClass.bluffSkill = [NSNumber numberWithInt:0];
    characterClass.diplomacySkill = [NSNumber numberWithInt:0];
    characterClass.dungeoneeringSkill = [NSNumber numberWithInt:3];
    characterClass.enduranceSkill = [NSNumber numberWithInt:1];
    characterClass.healSkill = [NSNumber numberWithInt:1];
    characterClass.historySkill = [NSNumber numberWithInt:0];
    characterClass.insightSkill = [NSNumber numberWithInt:0];
    characterClass.intimidateSkill = [NSNumber numberWithInt:0];
    characterClass.natureSkill = [NSNumber numberWithInt:3];
    characterClass.perceptionSkill = [NSNumber numberWithInt:1];
    characterClass.religionSkill = [NSNumber numberWithInt:0];
    characterClass.stealthSkill = [NSNumber numberWithInt:1];
    characterClass.streetwiseSkill = [NSNumber numberWithInt:0];
    characterClass.theiverySkill = [NSNumber numberWithInt:0];
    
    [context save:&error];
    
    characterClass = [NSEntityDescription insertNewObjectForEntityForName:@"CharacterClass" 
                                                   inManagedObjectContext:context];
    
    characterClass.name = @"Cleric";
    characterClass.role = @"Leader";
    characterClass.roleDescription = @"You lead by shielding allies with your prayers, healing, and using powers that improve your allies' attacks.";
    characterClass.powerSource = @"Divine";
    characterClass.powerSourceDescription = @"You have been invested with the authority to wield divine power on behalf of a deity, faith, or philosophy.";
    characterClass.keyStrengths = @"Wisdom, Strength, Charisma";
    characterClass.armorProf = @"Cloth, Leather, Hide, Chainmail";
    characterClass.meleeProf = @"Simple";
    characterClass.rangedProf = @"Simple";
    characterClass.weaponProf = @"";    
    characterClass.implement = @"Holy Symbol";
    characterClass.armorClassBonus = [NSNumber numberWithInt:0];
    characterClass.fortitudeBonus = [NSNumber numberWithInt:0];
    characterClass.reflexBonus = [NSNumber numberWithInt:0];
    characterClass.willBonus = [NSNumber numberWithInt:2];
    characterClass.baseHitPoints = [NSNumber numberWithInt:12];
    characterClass.hitPointModifier = @"Constitution";
    characterClass.hitPointsPerLevel = [NSNumber numberWithInt:5];
    characterClass.healingSurgesPerDay = [NSNumber numberWithInt:7];
    characterClass.healingSurgModifier = @"Constitution";
    characterClass.firstLevelSkillCount = [NSNumber numberWithInt:3];
    characterClass.acrobaticsSkill = [NSNumber numberWithInt:0];
    characterClass.arcanaSkill = [NSNumber numberWithInt:1];
    characterClass.athleticsSkill = [NSNumber numberWithInt:0];
    characterClass.bluffSkill = [NSNumber numberWithInt:0];
    characterClass.diplomacySkill = [NSNumber numberWithInt:1];
    characterClass.dungeoneeringSkill = [NSNumber numberWithInt:0];
    characterClass.enduranceSkill = [NSNumber numberWithInt:0];
    characterClass.healSkill = [NSNumber numberWithInt:1];
    characterClass.historySkill = [NSNumber numberWithInt:1];
    characterClass.insightSkill = [NSNumber numberWithInt:1];
    characterClass.intimidateSkill = [NSNumber numberWithInt:0];
    characterClass.natureSkill = [NSNumber numberWithInt:0];
    characterClass.perceptionSkill = [NSNumber numberWithInt:0];
    characterClass.religionSkill = [NSNumber numberWithInt:2];
    characterClass.stealthSkill = [NSNumber numberWithInt:0];
    characterClass.streetwiseSkill = [NSNumber numberWithInt:0];
    characterClass.theiverySkill = [NSNumber numberWithInt:0];
    
    [context save:&error];
    
    characterClass = [NSEntityDescription insertNewObjectForEntityForName:@"CharacterClass" 
                                                   inManagedObjectContext:context];
    
    characterClass.name = @"Fighter";
    characterClass.role = @"Defender";
    characterClass.roleDescription = @"You are very tough and have the exceptional ability to contain enemies in melee.";
    characterClass.powerSource = @"Martial";
    characterClass.powerSourceDescription = @"You are very tough and have the exceptional ability to contain enemies in melee.	Martial	You have become a master of combat through endless hours of practice, determination, and your own sheer physical toughness.";
    characterClass.keyStrengths = @"Strength, Dexterity, Wisdom";
    characterClass.armorProf = @"Cloth, Leather, Hide, Chainmail, Scale, Light Shield, Heavy Shield";
    characterClass.meleeProf = @"Military";
    characterClass.rangedProf = @"Military";
    characterClass.weaponProf = @"";    
    characterClass.implement = @"";
    characterClass.armorClassBonus = [NSNumber numberWithInt:0];
    characterClass.fortitudeBonus = [NSNumber numberWithInt:2];
    characterClass.reflexBonus = [NSNumber numberWithInt:0];
    characterClass.willBonus = [NSNumber numberWithInt:0];
    characterClass.baseHitPoints = [NSNumber numberWithInt:15];
    characterClass.hitPointModifier = @"Constitution";
    characterClass.hitPointsPerLevel = [NSNumber numberWithInt:6];
    characterClass.healingSurgesPerDay = [NSNumber numberWithInt:9];
    characterClass.healingSurgModifier = @"Constitution";
    characterClass.firstLevelSkillCount = [NSNumber numberWithInt:3];
    characterClass.acrobaticsSkill = [NSNumber numberWithInt:0];
    characterClass.arcanaSkill = [NSNumber numberWithInt:0];
    characterClass.athleticsSkill = [NSNumber numberWithInt:1];
    characterClass.bluffSkill = [NSNumber numberWithInt:0];
    characterClass.diplomacySkill = [NSNumber numberWithInt:0];
    characterClass.dungeoneeringSkill = [NSNumber numberWithInt:0];
    characterClass.enduranceSkill = [NSNumber numberWithInt:1];
    characterClass.healSkill = [NSNumber numberWithInt:1];
    characterClass.historySkill = [NSNumber numberWithInt:0];
    characterClass.insightSkill = [NSNumber numberWithInt:0];
    characterClass.intimidateSkill = [NSNumber numberWithInt:1];
    characterClass.natureSkill = [NSNumber numberWithInt:0];
    characterClass.perceptionSkill = [NSNumber numberWithInt:0];
    characterClass.religionSkill = [NSNumber numberWithInt:0];
    characterClass.stealthSkill = [NSNumber numberWithInt:0];
    characterClass.streetwiseSkill = [NSNumber numberWithInt:1];
    characterClass.theiverySkill = [NSNumber numberWithInt:0];
    
    [context save:&error];
    
    characterClass = [NSEntityDescription insertNewObjectForEntityForName:@"CharacterClass" 
                                                   inManagedObjectContext:context];
    
    characterClass.name = @"Paladin";
    characterClass.role = @"Defender";
    characterClass.roleDescription = @"You are extremely durable, with high hit points and the ability to wear the heaviest armor. You can issue bold challenges to foes and compel them to fight you rather than your allies.";
    characterClass.powerSource = @"Divine";
    characterClass.powerSourceDescription = @"You are a divine warrior, a crusader and protector of your faith.";
    characterClass.keyStrengths = @"Strength, Charisma, Wisdom";
    characterClass.armorProf = @"Cloth, Leather, Hide, Chainmail, Scale, Plate, Light Shield, Heavy Shield";
    characterClass.meleeProf = @"Military";
    characterClass.rangedProf = @"Simple";
    characterClass.weaponProf = @"";    
    characterClass.implement = @"Holy Symbol";
    characterClass.armorClassBonus = [NSNumber numberWithInt:0];
    characterClass.fortitudeBonus = [NSNumber numberWithInt:1];
    characterClass.reflexBonus = [NSNumber numberWithInt:1];
    characterClass.willBonus = [NSNumber numberWithInt:1];
    characterClass.baseHitPoints = [NSNumber numberWithInt:15];
    characterClass.hitPointModifier = @"Constitution";
    characterClass.hitPointsPerLevel = [NSNumber numberWithInt:6];
    characterClass.healingSurgesPerDay = [NSNumber numberWithInt:10];
    characterClass.healingSurgModifier = @"Constitution";
    characterClass.firstLevelSkillCount = [NSNumber numberWithInt:3];
    characterClass.acrobaticsSkill = [NSNumber numberWithInt:0];
    characterClass.arcanaSkill = [NSNumber numberWithInt:0];
    characterClass.athleticsSkill = [NSNumber numberWithInt:0];
    characterClass.bluffSkill = [NSNumber numberWithInt:0];
    characterClass.diplomacySkill = [NSNumber numberWithInt:1];
    characterClass.dungeoneeringSkill = [NSNumber numberWithInt:0];
    characterClass.enduranceSkill = [NSNumber numberWithInt:1];
    characterClass.healSkill = [NSNumber numberWithInt:1];
    characterClass.historySkill = [NSNumber numberWithInt:1];
    characterClass.insightSkill = [NSNumber numberWithInt:1];
    characterClass.intimidateSkill = [NSNumber numberWithInt:1];
    characterClass.natureSkill = [NSNumber numberWithInt:0];
    characterClass.perceptionSkill = [NSNumber numberWithInt:0];
    characterClass.religionSkill = [NSNumber numberWithInt:2];
    characterClass.stealthSkill = [NSNumber numberWithInt:0];
    characterClass.streetwiseSkill = [NSNumber numberWithInt:0];
    characterClass.theiverySkill = [NSNumber numberWithInt:0];
    
    [context save:&error];
    
    characterClass = [NSEntityDescription insertNewObjectForEntityForName:@"CharacterClass" 
                                                   inManagedObjectContext:context];
    
    characterClass.name = @"Rogue";
    characterClass.role = @"Striker";
    characterClass.roleDescription = @"You dart in to attack, do massive damage, and then retreat to safety. You do best when teamed with a defender to flank enemies.";
    characterClass.powerSource = @"Martial";
    characterClass.powerSourceDescription = @"Your talents depend on extensive training and constant practice, innate skill, and natural coordination.";
    characterClass.keyStrengths = @"Dexterity, Strength, Charisma";
    characterClass.armorProf = @"Cloth, Leather";
    characterClass.meleeProf = @"None";
    characterClass.rangedProf = @"None";
    characterClass.weaponProf = @"Dagger, Hand Crossbow, Shuriken, Sling, Short Sword";    
    characterClass.implement = @"";
    characterClass.armorClassBonus = [NSNumber numberWithInt:0];
    characterClass.fortitudeBonus = [NSNumber numberWithInt:0];
    characterClass.reflexBonus = [NSNumber numberWithInt:2];
    characterClass.willBonus = [NSNumber numberWithInt:0];
    characterClass.baseHitPoints = [NSNumber numberWithInt:12];
    characterClass.hitPointModifier = @"Constitution";
    characterClass.hitPointsPerLevel = [NSNumber numberWithInt:5];
    characterClass.healingSurgesPerDay = [NSNumber numberWithInt:6];
    characterClass.healingSurgModifier = @"Constitution";
    characterClass.firstLevelSkillCount = [NSNumber numberWithInt:4];
    characterClass.acrobaticsSkill = [NSNumber numberWithInt:1];
    characterClass.arcanaSkill = [NSNumber numberWithInt:0];
    characterClass.athleticsSkill = [NSNumber numberWithInt:1];
    characterClass.bluffSkill = [NSNumber numberWithInt:1];
    characterClass.diplomacySkill = [NSNumber numberWithInt:0];
    characterClass.dungeoneeringSkill = [NSNumber numberWithInt:1];
    characterClass.enduranceSkill = [NSNumber numberWithInt:0];
    characterClass.healSkill = [NSNumber numberWithInt:0];
    characterClass.historySkill = [NSNumber numberWithInt:0];
    characterClass.insightSkill = [NSNumber numberWithInt:1];
    characterClass.intimidateSkill = [NSNumber numberWithInt:1];
    characterClass.natureSkill = [NSNumber numberWithInt:0];
    characterClass.perceptionSkill = [NSNumber numberWithInt:1];
    characterClass.religionSkill = [NSNumber numberWithInt:0];
    characterClass.stealthSkill = [NSNumber numberWithInt:2];
    characterClass.streetwiseSkill = [NSNumber numberWithInt:1];
    characterClass.theiverySkill = [NSNumber numberWithInt:2];
    
    [context save:&error];
    
    characterClass = [NSEntityDescription insertNewObjectForEntityForName:@"CharacterClass" 
                                                   inManagedObjectContext:context];
    
    characterClass.name = @"Warlock";
    characterClass.role = @"Striker";
    characterClass.roleDescription = @"Your attack powers are highly damaging and often weaken or hamper the target in some way. You can elude attacks by flying, teleporting, or turning invisible.";
    characterClass.powerSource = @"Arcane";
    characterClass.powerSourceDescription = @"You gain your magical power from a pact you forge with a powerful, supernatural force or an unnamed entity.";
    characterClass.keyStrengths = @"Charisma, Constitution, Intelligence";
    characterClass.armorProf = @"Cloth, Leather";
    characterClass.meleeProf = @"Simple";
    characterClass.rangedProf = @"Simple";
    characterClass.weaponProf = @"";    
    characterClass.implement = @"Rods, Wands";
    characterClass.armorClassBonus = [NSNumber numberWithInt:0];
    characterClass.fortitudeBonus = [NSNumber numberWithInt:0];
    characterClass.reflexBonus = [NSNumber numberWithInt:1];
    characterClass.willBonus = [NSNumber numberWithInt:1];
    characterClass.baseHitPoints = [NSNumber numberWithInt:12];
    characterClass.hitPointModifier = @"Constitution";
    characterClass.hitPointsPerLevel = [NSNumber numberWithInt:5];
    characterClass.healingSurgesPerDay = [NSNumber numberWithInt:6];
    characterClass.healingSurgModifier = @"Constitution";
    characterClass.firstLevelSkillCount = [NSNumber numberWithInt:4];
    characterClass.acrobaticsSkill = [NSNumber numberWithInt:0];
    characterClass.arcanaSkill = [NSNumber numberWithInt:1];
    characterClass.athleticsSkill = [NSNumber numberWithInt:0];
    characterClass.bluffSkill = [NSNumber numberWithInt:1];
    characterClass.diplomacySkill = [NSNumber numberWithInt:0];
    characterClass.dungeoneeringSkill = [NSNumber numberWithInt:0];
    characterClass.enduranceSkill = [NSNumber numberWithInt:0];
    characterClass.healSkill = [NSNumber numberWithInt:0];
    characterClass.historySkill = [NSNumber numberWithInt:1];
    characterClass.insightSkill = [NSNumber numberWithInt:1];
    characterClass.intimidateSkill = [NSNumber numberWithInt:1];
    characterClass.natureSkill = [NSNumber numberWithInt:0];
    characterClass.perceptionSkill = [NSNumber numberWithInt:0];
    characterClass.religionSkill = [NSNumber numberWithInt:1];
    characterClass.stealthSkill = [NSNumber numberWithInt:0];
    characterClass.streetwiseSkill = [NSNumber numberWithInt:1];
    characterClass.theiverySkill = [NSNumber numberWithInt:1];
    
    [context save:&error];    
    
    characterClass = [NSEntityDescription insertNewObjectForEntityForName:@"CharacterClass" 
                                                   inManagedObjectContext:context];
    
    characterClass.name = @"Warlord";
    characterClass.role = @"Leader";
    characterClass.roleDescription = @"You are an inspiring commander and a master of battle tactics.";
    characterClass.powerSource = @"Martial";
    characterClass.powerSourceDescription = @"You have become an expert in tactics through endless hours of training and practice, personal determination, and your own sheer physical toughness.";
    characterClass.keyStrengths = @"Strength, Intelligence, Charisma";
    characterClass.armorProf = @"Cloth, Leather, Hide, Chainmail, Light Shield";
    characterClass.meleeProf = @"Military";
    characterClass.rangedProf = @"Simple";
    characterClass.weaponProf = @"";    
    characterClass.implement = @"";
    characterClass.armorClassBonus = [NSNumber numberWithInt:0];
    characterClass.fortitudeBonus = [NSNumber numberWithInt:1];
    characterClass.reflexBonus = [NSNumber numberWithInt:0];
    characterClass.willBonus = [NSNumber numberWithInt:1];
    characterClass.baseHitPoints = [NSNumber numberWithInt:12];
    characterClass.hitPointModifier = @"Constitution";
    characterClass.hitPointsPerLevel = [NSNumber numberWithInt:5];
    characterClass.healingSurgesPerDay = [NSNumber numberWithInt:7];
    characterClass.healingSurgModifier = @"Constitution";
    characterClass.firstLevelSkillCount = [NSNumber numberWithInt:4];
    characterClass.acrobaticsSkill = [NSNumber numberWithInt:0];
    characterClass.arcanaSkill = [NSNumber numberWithInt:0];
    characterClass.athleticsSkill = [NSNumber numberWithInt:1];
    characterClass.bluffSkill = [NSNumber numberWithInt:0];
    characterClass.diplomacySkill = [NSNumber numberWithInt:1];
    characterClass.dungeoneeringSkill = [NSNumber numberWithInt:0];
    characterClass.enduranceSkill = [NSNumber numberWithInt:1];
    characterClass.healSkill = [NSNumber numberWithInt:1];
    characterClass.historySkill = [NSNumber numberWithInt:1];
    characterClass.insightSkill = [NSNumber numberWithInt:0];
    characterClass.intimidateSkill = [NSNumber numberWithInt:1];
    characterClass.natureSkill = [NSNumber numberWithInt:0];
    characterClass.perceptionSkill = [NSNumber numberWithInt:0];
    characterClass.religionSkill = [NSNumber numberWithInt:0];
    characterClass.stealthSkill = [NSNumber numberWithInt:0];
    characterClass.streetwiseSkill = [NSNumber numberWithInt:0];
    characterClass.theiverySkill = [NSNumber numberWithInt:0];
    
    [context save:&error];        
    
    characterClass = [NSEntityDescription insertNewObjectForEntityForName:@"CharacterClass" 
                                                   inManagedObjectContext:context];
    
    characterClass.name = @"Wizard";
    characterClass.role = @"Controller";
    characterClass.roleDescription = @"You exert control through magical effects that cover large areas—sometimes hindering foes, sometimes consuming them with fire.";
    characterClass.powerSource = @"Arcane";
    characterClass.powerSourceDescription = @"You channel arcane forces through extensive study, hidden knowledge, and intricate preparation. To you, magic is an art form, an expressive and powerful method by which you seek to control the world around you.";
    characterClass.keyStrengths = @"Strength, Wisdom, Dexterity";
    characterClass.armorProf = @"Cloth";
    characterClass.meleeProf = @"None";
    characterClass.rangedProf = @"None";
    characterClass.weaponProf = @"Dagger, Quarterstaff";    
    characterClass.implement = @"Orbs, Staffs, Wands";
    characterClass.armorClassBonus = [NSNumber numberWithInt:0];
    characterClass.fortitudeBonus = [NSNumber numberWithInt:0];
    characterClass.reflexBonus = [NSNumber numberWithInt:0];
    characterClass.willBonus = [NSNumber numberWithInt:2];
    characterClass.baseHitPoints = [NSNumber numberWithInt:10];
    characterClass.hitPointModifier = @"Constitution";
    characterClass.hitPointsPerLevel = [NSNumber numberWithInt:4];
    characterClass.healingSurgesPerDay = [NSNumber numberWithInt:6];
    characterClass.healingSurgModifier = @"Constitution";
    characterClass.firstLevelSkillCount = [NSNumber numberWithInt:3];
    characterClass.acrobaticsSkill = [NSNumber numberWithInt:0];
    characterClass.arcanaSkill = [NSNumber numberWithInt:2];
    characterClass.athleticsSkill = [NSNumber numberWithInt:0];
    characterClass.bluffSkill = [NSNumber numberWithInt:0];
    characterClass.diplomacySkill = [NSNumber numberWithInt:1];
    characterClass.dungeoneeringSkill = [NSNumber numberWithInt:1];
    characterClass.enduranceSkill = [NSNumber numberWithInt:0];
    characterClass.healSkill = [NSNumber numberWithInt:0];
    characterClass.historySkill = [NSNumber numberWithInt:1];
    characterClass.insightSkill = [NSNumber numberWithInt:1];
    characterClass.intimidateSkill = [NSNumber numberWithInt:0];
    characterClass.natureSkill = [NSNumber numberWithInt:1];
    characterClass.perceptionSkill = [NSNumber numberWithInt:0];
    characterClass.religionSkill = [NSNumber numberWithInt:1];
    characterClass.stealthSkill = [NSNumber numberWithInt:0];
    characterClass.streetwiseSkill = [NSNumber numberWithInt:0];
    characterClass.theiverySkill = [NSNumber numberWithInt:0];
    
    [context save:&error];            
    
    CharacterRace *characterRace = [NSEntityDescription insertNewObjectForEntityForName:@"CharacterRace" 
                                                                 inManagedObjectContext:context];
    characterRace.name = @"Elf";
    characterRace.heightRange = @"64-70";
    characterRace.weightRange = @"130-170";
    characterRace.acrobaticsMod = [NSNumber numberWithInt:0];
    characterRace.arcanaMod = [NSNumber numberWithInt:0];
    characterRace.athleticsMod = [NSNumber numberWithInt:0];
    characterRace.bluffMod = [NSNumber numberWithInt:0];
    characterRace.charismaMod = [NSNumber numberWithInt:0];
    characterRace.constitutionMod = [NSNumber numberWithInt:0];
    characterRace.dexterityMod = [NSNumber numberWithInt:2];
    characterRace.diplomacyMod = [NSNumber numberWithInt:0];
    characterRace.dungeoneeringMod = [NSNumber numberWithInt:0];
    characterRace.enduranceMod = [NSNumber numberWithInt:0];
    characterRace.healMod = [NSNumber numberWithInt:0];
    characterRace.historyMod = [NSNumber numberWithInt:0];
    characterRace.insightMod = [NSNumber numberWithInt:0];
    characterRace.intelligenceMod = [NSNumber numberWithInt:0];
    characterRace.intimidateMod = [NSNumber numberWithInt:0];
    characterRace.languages = @"Common, Elven";
    characterRace.natureMod = [NSNumber numberWithInt:2];
    characterRace.perceptionMod = [NSNumber numberWithInt:2];
    characterRace.religionMod = [NSNumber numberWithInt:0];
    characterRace.size = @"Medium";
    characterRace.speed = [NSNumber numberWithInt:7];
    characterRace.stealthMod = [NSNumber numberWithInt:0];
    characterRace.streetwiseMod = [NSNumber numberWithInt:0];
    characterRace.strengthMod = [NSNumber numberWithInt:0];
    characterRace.thieveryMod = [NSNumber numberWithInt:0];
    characterRace.vision = @"Low-Light";
    characterRace.wisdomMod = [NSNumber numberWithInt:2];
    
    if (![context save:&error]) 
    {
        NSLog(@"Couldn't save: %@", [error localizedDescription]);
    }
    
    characterRace = [NSEntityDescription insertNewObjectForEntityForName:@"CharacterRace" 
                                                  inManagedObjectContext:context];
    characterRace.name = @"Dragonborn";
    characterRace.heightRange = @"74-80";
    characterRace.weightRange = @"220-320";
    characterRace.strengthMod = [NSNumber numberWithInt:2];
    characterRace.constitutionMod = [NSNumber numberWithInt:0];
    characterRace.dexterityMod = [NSNumber numberWithInt:0];
    characterRace.intelligenceMod = [NSNumber numberWithInt:0];
    characterRace.wisdomMod = [NSNumber numberWithInt:0];
    characterRace.charismaMod = [NSNumber numberWithInt:2];
    characterRace.size = @"Medium";
    characterRace.speed = [NSNumber numberWithInt:6];
    characterRace.vision = @"Normal";
    characterRace.languages = @"Common, Draconic";
    characterRace.acrobaticsMod = [NSNumber numberWithInt:0];
    characterRace.arcanaMod = [NSNumber numberWithInt:0];
    characterRace.athleticsMod = [NSNumber numberWithInt:0];
    characterRace.bluffMod = [NSNumber numberWithInt:0];
    characterRace.diplomacyMod = [NSNumber numberWithInt:0];
    characterRace.dungeoneeringMod = [NSNumber numberWithInt:0];
    characterRace.enduranceMod = [NSNumber numberWithInt:0];
    characterRace.healMod = [NSNumber numberWithInt:0];
    characterRace.historyMod = [NSNumber numberWithInt:2];
    characterRace.insightMod = [NSNumber numberWithInt:0];
    characterRace.intimidateMod = [NSNumber numberWithInt:2];
    characterRace.natureMod = [NSNumber numberWithInt:0];
    characterRace.perceptionMod = [NSNumber numberWithInt:0];
    characterRace.religionMod = [NSNumber numberWithInt:0];
    characterRace.stealthMod = [NSNumber numberWithInt:0];
    characterRace.streetwiseMod = [NSNumber numberWithInt:0];
    characterRace.thieveryMod = [NSNumber numberWithInt:0];
    if (![context save:&error]) 
    {
        NSLog(@"Couldn't save: %@", [error localizedDescription]);
    }
    
    characterRace = [NSEntityDescription insertNewObjectForEntityForName:@"CharacterRace" 
                                                  inManagedObjectContext:context];
    characterRace.name = @"Dwarf";
    characterRace.heightRange = @"51-57";
    characterRace.weightRange = @"160-220";
    characterRace.strengthMod = [NSNumber numberWithInt:0];
    characterRace.constitutionMod = [NSNumber numberWithInt:2];
    characterRace.dexterityMod = [NSNumber numberWithInt:0];
    characterRace.intelligenceMod = [NSNumber numberWithInt:0];
    characterRace.wisdomMod = [NSNumber numberWithInt:2];
    characterRace.charismaMod = [NSNumber numberWithInt:0];
    characterRace.size = @"Medium";
    characterRace.speed = [NSNumber numberWithInt:5];
    characterRace.vision = @"Low-Light";
    characterRace.languages = @"Common, Dwarven";
    characterRace.acrobaticsMod = [NSNumber numberWithInt:0];
    characterRace.arcanaMod = [NSNumber numberWithInt:0];
    characterRace.athleticsMod = [NSNumber numberWithInt:0];
    characterRace.bluffMod = [NSNumber numberWithInt:0];
    characterRace.diplomacyMod = [NSNumber numberWithInt:0];
    characterRace.dungeoneeringMod = [NSNumber numberWithInt:2];
    characterRace.enduranceMod = [NSNumber numberWithInt:2];
    characterRace.healMod = [NSNumber numberWithInt:0];
    characterRace.historyMod = [NSNumber numberWithInt:0];
    characterRace.insightMod = [NSNumber numberWithInt:0];
    characterRace.intimidateMod = [NSNumber numberWithInt:0];
    characterRace.natureMod = [NSNumber numberWithInt:0];
    characterRace.perceptionMod = [NSNumber numberWithInt:0];
    characterRace.religionMod = [NSNumber numberWithInt:0];
    characterRace.stealthMod = [NSNumber numberWithInt:0];
    characterRace.streetwiseMod = [NSNumber numberWithInt:0];
    characterRace.thieveryMod = [NSNumber numberWithInt:0];
    if (![context save:&error]) 
    {
        NSLog(@"Couldn't save: %@", [error localizedDescription]);
    }  
    
    characterRace = [NSEntityDescription insertNewObjectForEntityForName:@"CharacterRace" 
                                                  inManagedObjectContext:context];
    characterRace.name = @"Eladrin";
    characterRace.heightRange = @"65-71";
    characterRace.weightRange = @"130-180";
    characterRace.strengthMod = [NSNumber numberWithInt:0];
    characterRace.constitutionMod = [NSNumber numberWithInt:0];
    characterRace.dexterityMod = [NSNumber numberWithInt:2];
    characterRace.intelligenceMod = [NSNumber numberWithInt:2];
    characterRace.wisdomMod = [NSNumber numberWithInt:0];
    characterRace.charismaMod = [NSNumber numberWithInt:0];
    characterRace.size = @"Medium";
    characterRace.speed = [NSNumber numberWithInt:6];
    characterRace.vision = @"Low-Light";
    characterRace.languages = @"Common, Elven";
    characterRace.acrobaticsMod = [NSNumber numberWithInt:0];
    characterRace.arcanaMod = [NSNumber numberWithInt:2];
    characterRace.athleticsMod = [NSNumber numberWithInt:0];
    characterRace.bluffMod = [NSNumber numberWithInt:0];
    characterRace.diplomacyMod = [NSNumber numberWithInt:0];
    characterRace.dungeoneeringMod = [NSNumber numberWithInt:0];
    characterRace.enduranceMod = [NSNumber numberWithInt:0];
    characterRace.healMod = [NSNumber numberWithInt:0];
    characterRace.historyMod = [NSNumber numberWithInt:2];
    characterRace.insightMod = [NSNumber numberWithInt:0];
    characterRace.intimidateMod = [NSNumber numberWithInt:0];
    characterRace.natureMod = [NSNumber numberWithInt:0];
    characterRace.perceptionMod = [NSNumber numberWithInt:0];
    characterRace.religionMod = [NSNumber numberWithInt:0];
    characterRace.stealthMod = [NSNumber numberWithInt:0];
    characterRace.streetwiseMod = [NSNumber numberWithInt:0];
    characterRace.thieveryMod = [NSNumber numberWithInt:0];
    if (![context save:&error]) 
    {
        NSLog(@"Couldn't save: %@", [error localizedDescription]);
    }  
    
    characterRace = [NSEntityDescription insertNewObjectForEntityForName:@"CharacterRace" 
                                                  inManagedObjectContext:context];
    characterRace.name = @"Half Elf";
    characterRace.heightRange = @"55-74";
    characterRace.weightRange = @"130-190";
    characterRace.strengthMod = [NSNumber numberWithInt:0];
    characterRace.constitutionMod = [NSNumber numberWithInt:2];
    characterRace.dexterityMod = [NSNumber numberWithInt:0];
    characterRace.intelligenceMod = [NSNumber numberWithInt:0];
    characterRace.wisdomMod = [NSNumber numberWithInt:0];
    characterRace.charismaMod = [NSNumber numberWithInt:2];
    characterRace.size = @"Medium";
    characterRace.speed = [NSNumber numberWithInt:6];
    characterRace.vision = @"Low Light";
    characterRace.languages = @"Common, Elven";
    characterRace.acrobaticsMod = [NSNumber numberWithInt:0];
    characterRace.arcanaMod = [NSNumber numberWithInt:0];
    characterRace.athleticsMod = [NSNumber numberWithInt:0];
    characterRace.bluffMod = [NSNumber numberWithInt:0];
    characterRace.diplomacyMod = [NSNumber numberWithInt:2];
    characterRace.dungeoneeringMod = [NSNumber numberWithInt:0];
    characterRace.enduranceMod = [NSNumber numberWithInt:0];
    characterRace.healMod = [NSNumber numberWithInt:0];
    characterRace.historyMod = [NSNumber numberWithInt:0];
    characterRace.insightMod = [NSNumber numberWithInt:2];
    characterRace.intimidateMod = [NSNumber numberWithInt:0];
    characterRace.natureMod = [NSNumber numberWithInt:0];
    characterRace.perceptionMod = [NSNumber numberWithInt:0];
    characterRace.religionMod = [NSNumber numberWithInt:0];
    characterRace.stealthMod = [NSNumber numberWithInt:0];
    characterRace.streetwiseMod = [NSNumber numberWithInt:0];
    characterRace.thieveryMod = [NSNumber numberWithInt:0];
    if (![context save:&error]) 
    {
        NSLog(@"Couldn't save: %@", [error localizedDescription]);
    }      
    
    characterRace = [NSEntityDescription insertNewObjectForEntityForName:@"CharacterRace" 
                                                  inManagedObjectContext:context];
    characterRace.name = @"Halfling";
    characterRace.heightRange = @"34-38";
    characterRace.weightRange = @"75-85";
    characterRace.strengthMod = [NSNumber numberWithInt:0];
    characterRace.constitutionMod = [NSNumber numberWithInt:0];
    characterRace.dexterityMod = [NSNumber numberWithInt:2];
    characterRace.intelligenceMod = [NSNumber numberWithInt:0];
    characterRace.wisdomMod = [NSNumber numberWithInt:0];
    characterRace.charismaMod = [NSNumber numberWithInt:2];
    characterRace.size = @"Small";
    characterRace.speed = [NSNumber numberWithInt:6];
    characterRace.vision = @"Normal";
    characterRace.languages = @"Common";
    characterRace.acrobaticsMod = [NSNumber numberWithInt:2];
    characterRace.arcanaMod = [NSNumber numberWithInt:0];
    characterRace.athleticsMod = [NSNumber numberWithInt:0];
    characterRace.bluffMod = [NSNumber numberWithInt:0];
    characterRace.diplomacyMod = [NSNumber numberWithInt:0];
    characterRace.dungeoneeringMod = [NSNumber numberWithInt:0];
    characterRace.enduranceMod = [NSNumber numberWithInt:0];
    characterRace.healMod = [NSNumber numberWithInt:0];
    characterRace.historyMod = [NSNumber numberWithInt:0];
    characterRace.insightMod = [NSNumber numberWithInt:0];
    characterRace.intimidateMod = [NSNumber numberWithInt:0];
    characterRace.natureMod = [NSNumber numberWithInt:0];
    characterRace.perceptionMod = [NSNumber numberWithInt:0];
    characterRace.religionMod = [NSNumber numberWithInt:0];
    characterRace.stealthMod = [NSNumber numberWithInt:0];
    characterRace.streetwiseMod = [NSNumber numberWithInt:0];
    characterRace.thieveryMod = [NSNumber numberWithInt:2];
    if (![context save:&error]) 
    {
        NSLog(@"Couldn't save: %@", [error localizedDescription]);
    }  
    
    characterRace = [NSEntityDescription insertNewObjectForEntityForName:@"CharacterRace" 
                                                  inManagedObjectContext:context];
    characterRace.name = @"Human";
    characterRace.heightRange = @"65-74";
    characterRace.weightRange = @"135-222";
    characterRace.strengthMod = [NSNumber numberWithInt:0];
    characterRace.constitutionMod = [NSNumber numberWithInt:0];
    characterRace.dexterityMod = [NSNumber numberWithInt:0];
    characterRace.intelligenceMod = [NSNumber numberWithInt:0];
    characterRace.wisdomMod = [NSNumber numberWithInt:0];
    characterRace.charismaMod = [NSNumber numberWithInt:0];
    characterRace.size = @"Medium";
    characterRace.speed = [NSNumber numberWithInt:6];
    characterRace.vision = @"Normal";
    characterRace.languages = @"Common";
    characterRace.acrobaticsMod = [NSNumber numberWithInt:0];
    characterRace.arcanaMod = [NSNumber numberWithInt:0];
    characterRace.athleticsMod = [NSNumber numberWithInt:0];
    characterRace.bluffMod = [NSNumber numberWithInt:0];
    characterRace.diplomacyMod = [NSNumber numberWithInt:0];
    characterRace.dungeoneeringMod = [NSNumber numberWithInt:0];
    characterRace.enduranceMod = [NSNumber numberWithInt:0];
    characterRace.healMod = [NSNumber numberWithInt:0];
    characterRace.historyMod = [NSNumber numberWithInt:0];
    characterRace.insightMod = [NSNumber numberWithInt:0];
    characterRace.intimidateMod = [NSNumber numberWithInt:0];
    characterRace.natureMod = [NSNumber numberWithInt:0];
    characterRace.perceptionMod = [NSNumber numberWithInt:0];
    characterRace.religionMod = [NSNumber numberWithInt:0];
    characterRace.stealthMod = [NSNumber numberWithInt:0];
    characterRace.streetwiseMod = [NSNumber numberWithInt:0];
    characterRace.thieveryMod = [NSNumber numberWithInt:0];
    if (![context save:&error]) 
    {
        NSLog(@"Couldn't save: %@", [error localizedDescription]);
    }  
    
    characterRace = [NSEntityDescription insertNewObjectForEntityForName:@"CharacterRace" 
                                                  inManagedObjectContext:context];
    characterRace.name = @"Tiefling";
    characterRace.heightRange = @"66-74";
    characterRace.weightRange = @"140-230";
    characterRace.strengthMod = [NSNumber numberWithInt:0];
    characterRace.constitutionMod = [NSNumber numberWithInt:0];
    characterRace.dexterityMod = [NSNumber numberWithInt:0];
    characterRace.intelligenceMod = [NSNumber numberWithInt:2];
    characterRace.wisdomMod = [NSNumber numberWithInt:0];
    characterRace.charismaMod = [NSNumber numberWithInt:2];
    characterRace.size = @"Medium";
    characterRace.speed = [NSNumber numberWithInt:6];
    characterRace.vision = @"Low-Light";
    characterRace.languages = @"Common";
    characterRace.acrobaticsMod = [NSNumber numberWithInt:0];
    characterRace.arcanaMod = [NSNumber numberWithInt:0];
    characterRace.athleticsMod = [NSNumber numberWithInt:0];
    characterRace.bluffMod = [NSNumber numberWithInt:2];
    characterRace.diplomacyMod = [NSNumber numberWithInt:0];
    characterRace.dungeoneeringMod = [NSNumber numberWithInt:0];
    characterRace.enduranceMod = [NSNumber numberWithInt:0];
    characterRace.healMod = [NSNumber numberWithInt:0];
    characterRace.historyMod = [NSNumber numberWithInt:0];
    characterRace.insightMod = [NSNumber numberWithInt:0];
    characterRace.intimidateMod = [NSNumber numberWithInt:0];
    characterRace.natureMod = [NSNumber numberWithInt:0];
    characterRace.perceptionMod = [NSNumber numberWithInt:0];
    characterRace.religionMod = [NSNumber numberWithInt:0];
    characterRace.stealthMod = [NSNumber numberWithInt:2];
    characterRace.streetwiseMod = [NSNumber numberWithInt:0];
    characterRace.thieveryMod = [NSNumber numberWithInt:0];
    if (![context save:&error]) 
    {
        NSLog(@"Couldn't save: %@", [error localizedDescription]);
    }  
    

}

@end
