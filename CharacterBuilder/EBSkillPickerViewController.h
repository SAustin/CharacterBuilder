//
//  EBSkillPickerViewController.h
//  CharacterBuilder
//
//  Created by Scott Austin on 11/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Character.h"
#import "CharacterClass.h"
#import "CharacterRace.h"

@interface EBSkillPickerViewController : UIViewController
@property (strong, nonatomic) IBOutlet UISwitch *acrobaticsSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *arcanaSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *athleticsSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *bluffSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *diplomacySwitch;
@property (strong, nonatomic) IBOutlet UISwitch *dungeoneeringSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *enduranceSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *healSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *historySwitch;
@property (strong, nonatomic) IBOutlet UISwitch *insightSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *intimidateSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *natureSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *perceptionSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *religionSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *stealthSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *streetwiseSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *thieverySwitch;
@property (strong, nonatomic) IBOutlet UITextField *skillsRemainingTextField;
@property (strong, nonatomic) NSArray *abilities;
@property (strong, nonatomic) NSArray *classAbilities;
@property (strong, nonatomic) Character *currentCharacter;


- (void)setSwitch:(UISwitch *)abilitiesSwitch
    usingModifier:(NSNumber *)switchValue;

- (IBAction)switchWasFlipped:(id)sender;

@end
