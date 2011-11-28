//
//  EBAbilitiesViewController.h
//  CharacterBuilder
//
//  Created by Scott Austin on 11/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Character.h"
#import "EBSkillPickerViewController.h"

@interface EBAbilitiesViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *strengthLessButton;
@property (strong, nonatomic) IBOutlet UITextField *strengthTextField;
@property (strong, nonatomic) IBOutlet UIButton *strengthMoreButton;
@property (strong, nonatomic) IBOutlet UIButton *constitutionLessButton;
@property (strong, nonatomic) IBOutlet UITextField *constitutionTextField;
@property (strong, nonatomic) IBOutlet UIButton *constitutionMoreButton;
@property (strong, nonatomic) IBOutlet UIButton *dexterityLessButton;
@property (strong, nonatomic) IBOutlet UITextField *dexterityTextField;
@property (strong, nonatomic) IBOutlet UIButton *dexterityMoreButton;
@property (strong, nonatomic) IBOutlet UIButton *intelligenceLessButton;
@property (strong, nonatomic) IBOutlet UITextField *intelligenceTextField;
@property (strong, nonatomic) IBOutlet UIButton *intelligenceMoreButton;
@property (strong, nonatomic) IBOutlet UIButton *wisdomLessButton;
@property (strong, nonatomic) IBOutlet UITextField *wisdomTextField;
@property (strong, nonatomic) IBOutlet UIButton *wisdomMoreButton;
@property (strong, nonatomic) IBOutlet UIButton *charismaLessButton;
@property (strong, nonatomic) IBOutlet UITextField *charismaTextField;
@property (strong, nonatomic) IBOutlet UIButton *charismaMoreButton;
@property (strong, nonatomic) IBOutlet UIButton *rollButton;
@property (strong, nonatomic) IBOutlet UIButton *acceptButton;
@property (strong, nonatomic) IBOutlet UITextField *pointsAvailableTextField;
@property (strong, nonatomic) NSString *strengthHolder;
@property (strong, nonatomic) NSString *constitutionHolder;
@property (strong, nonatomic) NSString *dexterityHolder;
@property (strong, nonatomic) NSString *intelligenceHolder;
@property (strong, nonatomic) NSString *charismaHolder;
@property (strong, nonatomic) NSString *wisdomHolder;
@property (strong, nonatomic) NSString *pointsAvailableHolder;

@property (strong, nonatomic) NSString *pointType;
@property (strong, nonatomic) NSArray *standardValues;
@property (nonatomic) int standardValueIndex;
@property (strong, nonatomic) Character *currentCharacter;

- (IBAction)acceptButtonWasPressed:(id)sender;
- (IBAction)reRollWasPressed:(id)sender;
- (IBAction)raiseValueWasPressed:(id)sender;
- (IBAction)lowerValueWasPressed:(id)sender;
- (void)setThePointType:(NSString *)thePointType;
- (int)abilityRoll;
- (int)roll:(int)count
          d:(int)sides;

@end