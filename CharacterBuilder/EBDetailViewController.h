//
//  EBDetailViewController.h
//  CharacterBuilder
//
//  Created by Scott Austin on 11/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Character.h"
#import "CharacterClass.h"
#import "CharacterRace.h"
#import "EBAppDelegate.h"
#import "EBClassDetailViewController.h"
#import "EBRaceDetailViewController.h"
#import "EBClassPickerViewController.h"
#import "EBAbilitiesViewController.h"

@protocol EBDetailViewControllerDelegate;

@interface EBDetailViewController : UIViewController 
    <UISplitViewControllerDelegate,EBClassDetailViewControllerDelegate, EBRaceDetailViewControllerDelegate,
     UITextFieldDelegate, UIAlertViewDelegate,
     EBClassPickerViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UITextField *characterNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *characterClassTextField;
@property (strong, nonatomic) IBOutlet UITextField *characterLevelTextField;
@property (strong, nonatomic) IBOutlet UITextField *characterXPTextField;
@property (strong, nonatomic) IBOutlet UITextField *characterRaceTextField;
@property (strong, nonatomic) IBOutlet UITextField *characterSizeTextField;
@property (strong, nonatomic) IBOutlet UITextField *characterAgeTextField;
@property (strong, nonatomic) IBOutlet UITextField *characterGenderTextField;
@property (strong, nonatomic) IBOutlet UITextField *characterHeightTextField;
@property (strong, nonatomic) IBOutlet UITextField *characterWeightTextField;
@property (strong, nonatomic) IBOutlet UITextField *characterAlignmentTextField;
@property (strong, nonatomic) IBOutlet UITextField *characterDietyTextField;
@property (strong, nonatomic) IBOutlet UITextField *characterParagonTextField;
@property (strong, nonatomic) IBOutlet UITextField *characterEpicDestinyTextField;
@property (strong, nonatomic) IBOutlet UITextField *characterAdventuringCompanyTextField;
@property (strong, nonatomic) IBOutlet UIImageView *characterImageTextField;

@property (strong, nonatomic) IBOutlet UIButton *saveCharacterButton;
@property (strong, nonatomic) IBOutlet UIButton *nextButton;

@property (strong, nonatomic) Character *currentCharacter;
@property (unsafe_unretained, nonatomic) id<EBDetailViewControllerDelegate> delegate;
@property (strong, nonatomic) UIStoryboardPopoverSegue *popoverSegue;
@property (strong, nonatomic) IBOutlet UIButton *heightButton;
@property (strong, nonatomic) IBOutlet UIButton *weightButton;

@property (strong, nonatomic) IBOutlet UILabel *instructionOne;
@property (strong, nonatomic) IBOutlet UILabel *instructionTwo;
@property (strong, nonatomic) IBOutlet UILabel *instructionThree;
@property (strong, nonatomic) IBOutlet UILabel *instructionFour;
@property (strong, nonatomic) IBOutlet UILabel *instructionFive;
@property (strong, nonatomic) IBOutlet UILabel *instructionSix;

@property (strong, nonatomic) NSString *pointType;

- (IBAction)saveButtonWasPressed:(id)sender;
- (IBAction)abilitiesButtonWasPressed:(id)sender;

@end

@protocol EBDetailViewControllerDelegate <NSObject>

- (NSManagedObjectContext *)managedObjectContext;

@end
