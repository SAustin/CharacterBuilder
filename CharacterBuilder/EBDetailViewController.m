//
//  EBDetailViewController.m
//  CharacterBuilder
//
//  Created by Scott Austin on 11/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "EBDetailViewController.h"

@interface EBDetailViewController () 
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation EBDetailViewController
@synthesize characterNameTextField = _characterNameTextField;
@synthesize characterClassTextField = _characterClassTextField;
@synthesize characterLevelTextField = _characterLevelTextField;
@synthesize characterXPTextField = _characterXPTextField;
@synthesize characterRaceTextField = _characterRaceTextField;
@synthesize characterSizeTextField = _characterSizeTextField;
@synthesize characterAgeTextField = _characterAgeTextField;
@synthesize characterGenderTextField = _characterGenderTextField;
@synthesize characterHeightTextField = _characterHeightTextField;
@synthesize characterWeightTextField = _characterWeightTextField;
@synthesize characterAlignmentTextField = _characterAlignmentTextField;
@synthesize characterDietyTextField = _characterDietyTextField;
@synthesize characterParagonTextField = _characterParagonTextField;
@synthesize characterEpicDestinyTextField = _characterEpicDestinyTextField;
@synthesize characterAdventuringCompanyTextField = _characterAdventuringCompanyTextField;
@synthesize characterImageTextField = _characterImageTextField;
@synthesize saveCharacterButton = _saveCharacterButton;
@synthesize nextButton = _nextButton;
@synthesize currentCharacter;
@synthesize delegate;
@synthesize popoverSegue;
@synthesize heightButton = _heightButton;
@synthesize weightButton = _weightButton;
@synthesize instructionOne = _instructionOne;
@synthesize instructionTwo = _instructionTwo;
@synthesize instructionThree = _instructionThree;
@synthesize instructionFour = _instructionFour;
@synthesize instructionFive = _instructionFive;
@synthesize instructionSix = _instructionSix;
@synthesize pointType;

@synthesize masterPopoverController = _masterPopoverController;

- (IBAction)saveButtonWasPressed:(id)sender
{
    
}

#pragma mark - EBClassDetailViewController Delegate Methods
- (NSManagedObjectContext *)managedObjectContext
{
    return [delegate managedObjectContext];
}
#pragma mark - Managing the detail item

- (void)configureView
{
    // Update the user interface for the detail item.
    [self.characterNameTextField setDelegate:self];
    [self.characterLevelTextField setDelegate:self];
    [self.characterXPTextField setDelegate:self];
    [self.characterAgeTextField setDelegate:self];
    [self.characterAdventuringCompanyTextField setDelegate:self];
    [self.characterClassTextField setUserInteractionEnabled:NO];
    [self.characterRaceTextField setUserInteractionEnabled:NO];
    [self.characterSizeTextField setUserInteractionEnabled:NO];
    [self.characterSizeTextField setHidden:YES];
    [self.characterHeightTextField setHidden:YES];
    [self.characterHeightTextField setUserInteractionEnabled:NO];
    [self.characterWeightTextField setHidden:YES];
    [self.characterWeightTextField setUserInteractionEnabled:NO];
    [self.characterAlignmentTextField setUserInteractionEnabled:NO];
    [self.characterDietyTextField setUserInteractionEnabled:NO];
    [self.characterDietyTextField setHidden:YES];
    [self.characterParagonTextField setUserInteractionEnabled:NO];
    [self.characterEpicDestinyTextField setUserInteractionEnabled:NO];
    [self setCharacterImageTextField:nil];
    
    [self.instructionTwo setTextColor:[UIColor grayColor]];
    [self.instructionThree setTextColor:[UIColor grayColor]];
    [self.instructionFour setTextColor:[UIColor grayColor]];
    [self.instructionFive setTextColor:[UIColor grayColor]];
    [self.instructionSix setTextColor:[UIColor grayColor]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"modalCharacterClass"]) 
    {
        EBClassDetailViewController *classDetail = (EBClassDetailViewController *)[segue destinationViewController];
        classDetail.delegate = self;
    }
    else if ([segue.identifier isEqualToString:@"modalCharacterRace"])
    {
        EBRaceDetailViewController *raceDetail = (EBRaceDetailViewController *)[segue destinationViewController];
        raceDetail.delegate = self;
    }
    else if ([segue.identifier isEqualToString:@"heightPicker"])
    {
        self.popoverSegue = (UIStoryboardPopoverSegue *)segue;
        EBClassPickerViewController *pickerView = (EBClassPickerViewController *)[segue destinationViewController];
        pickerView.delegate = self;
        pickerView.pickerType = @"height";
        pickerView.currentRace = currentCharacter.characterRace;
        [pickerView prepPicker];
    }
    else if ([segue.identifier isEqualToString:@"weightPicker"])
    {
        self.popoverSegue = (UIStoryboardPopoverSegue *)segue;
        EBClassPickerViewController *pickerView = (EBClassPickerViewController *)[segue destinationViewController];
        pickerView.delegate = self;
        pickerView.pickerType = @"weight";
        pickerView.currentRace = currentCharacter.characterRace;
        [pickerView prepPicker];
    }
    else if ([segue.identifier isEqualToString:@"genderPicker"])
    {
        self.popoverSegue = (UIStoryboardPopoverSegue *)segue;
        EBClassPickerViewController *pickerView = (EBClassPickerViewController *)[segue destinationViewController];
        pickerView.delegate = self;
        pickerView.pickerType = @"gender";
        pickerView.currentRace = currentCharacter.characterRace;
        [pickerView prepPicker];
    }
    else if ([segue.identifier isEqualToString:@"alignmentPicker"])
    {
        self.popoverSegue = (UIStoryboardPopoverSegue *)segue;
        EBClassPickerViewController *pickerView = (EBClassPickerViewController *)[segue destinationViewController];
        pickerView.delegate = self;
        pickerView.pickerType = @"alignment";
        pickerView.currentRace = currentCharacter.characterRace;
        [pickerView prepPicker];   
    }    
    else if([segue.identifier isEqualToString:@"modalAbilities"])
    {
        EBAbilitiesViewController *abilityView = [segue destinationViewController];
        abilityView.currentCharacter = currentCharacter;
        if ([currentCharacter.strength intValue] == 0) 
        {
            [abilityView setThePointType:self.pointType];
        }
    }
}

- (IBAction)abilitiesButtonWasPressed:(id)sender
{
    if (currentCharacter.characterRace == nil || 
        currentCharacter.characterClass == nil) 
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unfinished Character" 
                                                        message:@"Please choose a class and race!"
                                                       delegate:self 
                                              cancelButtonTitle:@"Cancel" 
                                              otherButtonTitles:@"Standard", @"Custom", @"Rolled", nil];
        [alert show];
    }
    else if ([currentCharacter.strength intValue] == 0) 
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Points Type" 
                                                        message:@"Which method would you like to use to assign ability points?"
                                                       delegate:self 
                                              cancelButtonTitle:@"Cancel" 
                                              otherButtonTitles:@"Standard", @"Custom", @"Rolled", nil];
        [alert show];

    }
    else
    {
        self.pointType = @"none";
        [self performSegueWithIdentifier:@"modalAbilities" sender:self];
    }
}

- (void)alertView:(UIAlertView *)alertView 
clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) 
    {
        case 0:
            break;
        case 1:
            self.pointType = @"standard";
            break;
        case 2:
            self.pointType = @"custom";
            break;
        case 3:
            self.pointType = @"rolled";
            break;
        default:
            break;
    }
    
    [self performSegueWithIdentifier:@"modalAbilities" sender:self];
}


- (void)userDidSelectValue:(NSString *)value
{
    [((UIPopoverController *)[popoverSegue popoverController]) dismissPopoverAnimated:YES];
    if ([popoverSegue.identifier isEqualToString:@"heightPicker"]) 
    {
        self.characterHeightTextField.text = value;
        NSScanner *heightScanner = [NSScanner scannerWithString:value];
        NSString *footString = nil;
        int location = [heightScanner scanUpToString:@"'" intoString:&footString];
        NSString *inchString = [value substringFromIndex:location];
        self.currentCharacter.height = [NSNumber numberWithInt:[footString intValue]*12 + [inchString intValue]];
    }
    else if ([popoverSegue.identifier isEqualToString:@"weightPicker"]) 
    {
        self.characterWeightTextField.text = value;
        NSScanner *weightScanner = [NSScanner scannerWithString:value];
        NSString *weightString = nil;
        [weightScanner scanUpToString:@"lbs" 
                           intoString:&weightString];
        self.currentCharacter.weight = [NSNumber numberWithInt:[weightString intValue]];
    }
    else if ([popoverSegue.identifier isEqualToString:@"genderPicker"])
    {
        self.characterGenderTextField.text = value;
        self.currentCharacter.gender = value;
    }
    else if ([popoverSegue.identifier isEqualToString:@"alignmentPicker"])
    {
        self.characterAlignmentTextField.text = value;
        self.currentCharacter.alignment = value;
        [self.characterDietyTextField setHidden:NO];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    currentCharacter = [NSEntityDescription insertNewObjectForEntityForName:@"Character" 
                                                     inManagedObjectContext:[delegate managedObjectContext]];
    [self.heightButton setUserInteractionEnabled:NO];
    [self.weightButton setUserInteractionEnabled:NO];
}

- (void)viewDidUnload
{
    [self setCharacterNameTextField:nil];
    [self setCharacterClassTextField:nil];
    [self setCharacterLevelTextField:nil];
    [self setCharacterXPTextField:nil];
    [self setCharacterRaceTextField:nil];
    [self setCharacterSizeTextField:nil];
    [self setCharacterAgeTextField:nil];
    [self setCharacterGenderTextField:nil];
    [self setCharacterHeightTextField:nil];
    [self setCharacterWeightTextField:nil];
    [self setCharacterAlignmentTextField:nil];
    [self setCharacterDietyTextField:nil];
    [self setCharacterParagonTextField:nil];
    [self setCharacterEpicDestinyTextField:nil];
    [self setCharacterAdventuringCompanyTextField:nil];
    [self setCharacterImageTextField:nil];
    [self setSaveCharacterButton:nil];
    [self setNextButton:nil];
    [self setHeightButton:nil];
    [self setWeightButton:nil];
    [self setInstructionOne:nil];
    [self setInstructionTwo:nil];
    [self setInstructionThree:nil];
    [self setInstructionFour:nil];
    [self setInstructionFive:nil];
    [self setInstructionSix:nil];
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

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

#pragma mark - EBClassDetailViewController Delegate Methods

- (void)userDidChooseClass:(CharacterClass *)characterClass
{
    [self dismissModalViewControllerAnimated:YES];
    [currentCharacter setCharacterClass:characterClass];
    currentCharacter.characterClass = characterClass;
    self.characterClassTextField.text = characterClass.name;
}

#pragma mark - EBRaceDetailViewControllerDelegateMethods

- (void)userDidChooseRace:(CharacterRace *)charRace
{
    [self dismissModalViewControllerAnimated:YES];
    [currentCharacter setCharacterRace:charRace];
    self.characterRaceTextField.text = charRace.name;
    self.characterSizeTextField.text = charRace.size;
    [self.characterHeightTextField setHidden:NO];
    [self.characterWeightTextField setHidden:NO];
    [self.characterSizeTextField setHidden:NO];
    [self.heightButton setUserInteractionEnabled:YES];
    [self.weightButton setUserInteractionEnabled:YES];
}

#pragma mark - UITextField Delegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}
@end

