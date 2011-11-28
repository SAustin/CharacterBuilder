//
//  EBAbilitiesViewController.m
//  CharacterBuilder
//
//  Created by Scott Austin on 11/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "EBAbilitiesViewController.h"

@implementation EBAbilitiesViewController
@synthesize strengthLessButton;
@synthesize strengthTextField;
@synthesize strengthMoreButton;
@synthesize constitutionLessButton;
@synthesize constitutionTextField;
@synthesize constitutionMoreButton;
@synthesize dexterityLessButton;
@synthesize dexterityTextField;
@synthesize dexterityMoreButton;
@synthesize intelligenceLessButton;
@synthesize intelligenceTextField;
@synthesize intelligenceMoreButton;
@synthesize wisdomLessButton;
@synthesize wisdomTextField;
@synthesize wisdomMoreButton;
@synthesize charismaLessButton;
@synthesize charismaTextField;
@synthesize charismaMoreButton;
@synthesize rollButton;
@synthesize acceptButton;
@synthesize pointsAvailableTextField;
@synthesize pointType;
@synthesize strengthHolder;
@synthesize constitutionHolder;
@synthesize dexterityHolder;
@synthesize charismaHolder;
@synthesize intelligenceHolder;
@synthesize wisdomHolder;
@synthesize pointsAvailableHolder;
@synthesize standardValues;
@synthesize standardValueIndex;
@synthesize currentCharacter;

-(IBAction)acceptButtonWasPressed:(id)sender
{
    [currentCharacter setStrength:[NSNumber numberWithInt:[strengthTextField.text intValue]]];
    [currentCharacter setConstitution:[NSNumber numberWithInt:[constitutionTextField.text intValue]]];
    [currentCharacter setDexterity:[NSNumber numberWithInt:[dexterityTextField.text intValue]]];
    [currentCharacter setIntelligence:[NSNumber numberWithInt:[intelligenceTextField.text intValue]]];
    [currentCharacter setWisdom:[NSNumber numberWithInt:[wisdomTextField.text intValue]]];
    [currentCharacter setCharisma:[NSNumber numberWithInt:[charismaTextField.text intValue]]];
}

- (void)setThePointType:(NSString *)thePointType
{
    if ([thePointType isEqualToString:@"standard"]) 
    {
        self.pointType = thePointType;
        strengthHolder = [NSString stringWithString:@"0"];
        constitutionHolder = [NSString stringWithString:@"0"];
        dexterityHolder = [NSString stringWithString:@"0"];
        intelligenceHolder = [NSString stringWithString:@"0"];
        wisdomHolder = [NSString stringWithString:@"0"];
        charismaHolder = [NSString stringWithString:@"0"];        
    }
    else if ([thePointType isEqualToString:@"rolled"])
    {
        self.pointType = thePointType;
        strengthHolder = [NSString stringWithFormat:@"%d",[self abilityRoll]];
        constitutionHolder = [NSString stringWithFormat:@"%d", [self abilityRoll]];
        dexterityHolder = [NSString stringWithFormat:@"%d", [self abilityRoll]];
        intelligenceHolder = [NSString stringWithFormat:@"%d", [self abilityRoll]];
        wisdomHolder = [NSString stringWithFormat:@"%d", [self abilityRoll]];
        charismaHolder = [NSString stringWithFormat:@"%d", [self abilityRoll]];
        [self.rollButton setHidden:NO];
    }
    else if ([thePointType isEqualToString:@"custom"])
    {
        self.pointType = thePointType;
        pointsAvailableHolder = @"22";
        strengthHolder = [NSString stringWithString:@"8"];
        constitutionHolder = [NSString stringWithString:@"10"];
        dexterityHolder = [NSString stringWithString:@"10"];
        intelligenceHolder = [NSString stringWithString:@"10"];
        wisdomHolder = [NSString stringWithString:@"10"];
        charismaHolder = [NSString stringWithString:@"10"];        
    }
}

- (IBAction)reRollWasPressed:(id)sender
{
    strengthTextField.text = [NSString stringWithFormat:@"%d",[self abilityRoll]];
    constitutionTextField.text = [NSString stringWithFormat:@"%d", [self abilityRoll]];
    dexterityTextField.text = [NSString stringWithFormat:@"%d", [self abilityRoll]];
    intelligenceTextField.text = [NSString stringWithFormat:@"%d", [self abilityRoll]];
    wisdomTextField.text = [NSString stringWithFormat:@"%d", [self abilityRoll]];
    charismaTextField.text = [NSString stringWithFormat:@"%d", [self abilityRoll]];    
}

- (IBAction)raiseValueWasPressed:(id)sender
{
    if ([self.pointType isEqualToString:@"custom"]) 
    {
        int currentLevel = [((UITextField *)[self.view viewWithTag:[sender tag] + 10]).text intValue];
        int balance = [pointsAvailableTextField.text intValue];
        
        int cost;
        switch (currentLevel) 
        {
            case 8:
                cost = 1;
                break;
            case 9:
                cost = 1;
                break;
            case 10:
                cost = 1;
                break;
            case 11:
                cost = 1;
                break;
            case 12:
                cost = 1;
                break;
            case 13:
                cost = 2;
                break;
            case 14:
                cost = 2;
                break;
            case 15:
                cost = 2;
                break;
            case 16:
                cost = 3;
                break;
            case 17:
                cost = 4;
                break;
            default:
                break;
        }
        
        if (cost > balance) 
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Low Balance!" 
                                                            message:[NSString stringWithFormat:@"You need %d points available to increase this ability.", cost-balance]  
                                                           delegate:nil 
                                                  cancelButtonTitle:@"Ok" 
                                                  otherButtonTitles:nil];
            [alert show];
        }
        else
        {
            pointsAvailableTextField.text = [NSString stringWithFormat:@"%d", balance-cost];
            ((UITextField *)[self.view viewWithTag:[sender tag] + 10]).text = [NSString stringWithFormat:@"%d", ++currentLevel];
        }
    }
    else if ([self.pointType isEqualToString:@"standard"])
    {
        if ([((UITextField *)[self.view viewWithTag:[sender tag] + 10]).text isEqualToString:@"0"]) 
        {
            ((UITextField *)[self.view viewWithTag:[sender tag] + 10]).text = [standardValues objectAtIndex:standardValueIndex++];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Already Assigned!" 
                                                            message:@"You have already assigned a score to this ability. You may remove this score, or choose another ability." 
                                                           delegate:nil 
                                                  cancelButtonTitle:@"Ok" 
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }
}

- (IBAction)lowerValueWasPressed:(id)sender
{
    if ([self.pointType isEqualToString:@"custom"]) 
    {
        int currentLevel = [((UITextField *)[self.view viewWithTag:[sender tag] + 10]).text intValue];
        if (currentLevel == 8) 
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Low Ability!" 
                                                            message:@"You cannot lower an ability below 8 points." 
                                                           delegate:nil 
                                                  cancelButtonTitle:@"Ok" 
                                                  otherButtonTitles:nil];
            [alert show];
        }
        else
        {
            int balance = [pointsAvailableTextField.text intValue];
            
            int cost;
            switch (currentLevel) 
            {
                case 9:
                    cost = 1;
                    break;
                case 10:
                    cost = 1;
                    break;
                case 11:
                    cost = 1;
                    break;
                case 12:
                    cost = 1;
                    break;
                case 13:
                    cost = 1;
                    break;
                case 14:
                    cost = 2;
                    break;
                case 15:
                    cost = 2;
                    break;
                case 16:
                    cost = 2;
                    break;
                case 17:
                    cost = 3;
                    break;
                case 18:
                    cost = 4;
                    break;
                default:
                    break;
            }
            
            
            pointsAvailableTextField.text = [NSString stringWithFormat:@"%d", balance+cost];
            ((UITextField *)[self.view viewWithTag:[sender tag] + 10]).text = [NSString stringWithFormat:@"%d", --currentLevel];
            
        }        
    }  
    else if ([self.pointType isEqualToString:@"standard"])
    {
        if (![((UITextField *)[self.view viewWithTag:[sender tag] + 10]).text isEqualToString:@"0"]) 
        {
            ((UITextField *)[self.view viewWithTag:[sender tag] + 10]).text = @"0";
            standardValueIndex--;
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Not Assigned!" 
                                                            message:@"You have not assigned a score to this ability. You may remove this score, or choose another ability." 
                                                           delegate:nil 
                                                  cancelButtonTitle:@"Ok" 
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }

}

- (int)abilityRoll
{
    int rolls[] = {[self roll:1 d:6], 
                   [self roll:1 d:6], 
                   [self roll:1 d:6], 
                   [self roll:1 d:6]};
    int total = 0;
    int minValue = rolls[0];
    
    for (int i = 0; i < 4; i++) 
    {
        if (rolls[i] < minValue) 
        {
            minValue = rolls[i];
        }
        
        total += rolls[i];
    }
    total -= minValue;
    
    return total;
}

- (int)roll:(int)count
          d:(int)sides

{
    int total = 0;
    for (int i = 0; i < count; i++) 
    {
        total += arc4random() % sides + 1;
    }
    return total;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"pushSkills"]) 
    {
        EBSkillPickerViewController *skillPicker = (EBSkillPickerViewController *)[segue destinationViewController];
        skillPicker.currentCharacter = self.currentCharacter;
        
    }
}


/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


- (void)viewDidLoad
{
    [super viewDidLoad];
    if (pointsAvailableHolder != nil) 
    {
        self.pointsAvailableTextField.text = pointsAvailableHolder;
    }
    if (strengthHolder != nil) 
    {
        self.strengthTextField.text = strengthHolder;
        self.constitutionTextField.text = constitutionHolder;
        self.dexterityTextField.text = dexterityHolder;
        self.intelligenceTextField.text = intelligenceHolder;
        self.charismaTextField.text = charismaHolder;
        self.wisdomTextField.text = wisdomHolder;        
    }
    if ([self.pointType isEqualToString:@"rolled"]) 
    {
        [self.rollButton setHidden:NO];
    }
    else if ([self.pointType isEqualToString:@"standard"])
    {
        [self.rollButton setHidden:YES];
    }
    else
    {
        [self.rollButton setHidden:YES];
    }
    
    self.standardValues = [NSArray arrayWithObjects:@"16",@"14",@"13",@"12",@"11",@"10", nil];
        
}


- (void)viewDidUnload
{
    [self setStrengthLessButton:nil];
    [self setStrengthTextField:nil];
    [self setStrengthMoreButton:nil];
    [self setConstitutionLessButton:nil];
    [self setConstitutionTextField:nil];
    [self setConstitutionMoreButton:nil];
    [self setDexterityLessButton:nil];
    [self setDexterityTextField:nil];
    [self setDexterityMoreButton:nil];
    [self setIntelligenceLessButton:nil];
    [self setIntelligenceTextField:nil];
    [self setIntelligenceMoreButton:nil];
    [self setWisdomLessButton:nil];
    [self setWisdomTextField:nil];
    [self setWisdomMoreButton:nil];
    [self setCharismaLessButton:nil];
    [self setCharismaTextField:nil];
    [self setCharismaMoreButton:nil];
    [self setRollButton:nil];
    [self setAcceptButton:nil];
    [self setPointsAvailableTextField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
