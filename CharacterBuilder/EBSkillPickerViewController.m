//
//  EBSkillPickerViewController.m
//  CharacterBuilder
//
//  Created by Scott Austin on 11/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "EBSkillPickerViewController.h"

@implementation EBSkillPickerViewController
@synthesize acrobaticsSwitch;
@synthesize arcanaSwitch;
@synthesize athleticsSwitch;
@synthesize bluffSwitch;
@synthesize diplomacySwitch;
@synthesize dungeoneeringSwitch;
@synthesize enduranceSwitch;
@synthesize healSwitch;
@synthesize historySwitch;
@synthesize insightSwitch;
@synthesize intimidateSwitch;
@synthesize natureSwitch;
@synthesize perceptionSwitch;
@synthesize religionSwitch;
@synthesize stealthSwitch;
@synthesize streetwiseSwitch;
@synthesize thieverySwitch;
@synthesize skillsRemainingTextField;
@synthesize currentCharacter;
@synthesize abilities;
@synthesize classAbilities;

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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    abilities = [NSArray arrayWithObjects:
                 self.acrobaticsSwitch,
                 self.arcanaSwitch,
                 self.athleticsSwitch,
                 self.bluffSwitch,
                 self.diplomacySwitch,
                 self.dungeoneeringSwitch,
                 self.enduranceSwitch,
                 self.healSwitch,
                 self.historySwitch,
                 self.insightSwitch,
                 self.intimidateSwitch,
                 self.natureSwitch,
                 self.perceptionSwitch,
                 self.religionSwitch,
                 self.stealthSwitch,
                 self.streetwiseSwitch,
                 self.thieverySwitch, 
                 nil];
    /*
    for (UISwitch *abilitiesSwitch in abilities) 
    {
        ((UILabel *)[[[[[[abilitiesSwitch subviews] lastObject] subviews] objectAtIndex:2] subviews] objectAtIndex:0]).text = @"Trained";
        ((UILabel *)[[[[[[abilitiesSwitch subviews] lastObject] subviews] objectAtIndex:2] subviews] objectAtIndex:1]).text = @"Untrained";
    }
    */
    CharacterClass *charClass = currentCharacter.characterClass;
    classAbilities = [NSArray arrayWithObjects:
                               charClass.acrobaticsSkill,
                               charClass.arcanaSkill,
                               charClass.athleticsSkill,
                               charClass.bluffSkill,
                               charClass.diplomacySkill,
                               charClass.dungeoneeringSkill,
                               charClass.enduranceSkill,
                               charClass.healSkill,
                               charClass.historySkill,
                               charClass.insightSkill,
                               charClass.intimidateSkill,
                               charClass.natureSkill,
                               charClass.perceptionSkill,
                               charClass.religionSkill,
                               charClass.stealthSkill,
                               charClass.streetwiseSkill,
                               charClass.theiverySkill, 
                               nil];
    for (int i = 0; i < [abilities count]; i++) 
    {
        [self setSwitch:[abilities objectAtIndex:i] 
          usingModifier:[classAbilities objectAtIndex:i]];
    }
    
    for (int i = 0; i < [abilities count]; i++) 
    {
        if ([[classAbilities objectAtIndex:i] isEqualToNumber:[NSNumber numberWithInt:3]]) 
        {
            skillsRemainingTextField.text = [NSString stringWithFormat:@"%d", [skillsRemainingTextField.text intValue] + 1];
        }
        break;
    }
    
    self.skillsRemainingTextField.text = [currentCharacter.characterClass.firstLevelSkillCount description];
    if ([currentCharacter.characterRace.name isEqualToString:@"Human"]) 
    {
        self.skillsRemainingTextField.text = [NSString stringWithFormat:@"%d", [self.skillsRemainingTextField.text intValue] + 1];
    }
}

- (void)setSwitch:(UISwitch *)abilitiesSwitch 
    usingModifier:(NSNumber *)switchValue
{
    switch ([switchValue intValue]) 
    {
        case 1:
            [abilitiesSwitch setUserInteractionEnabled:YES];
            ((UILabel *)[self.view viewWithTag:[abilitiesSwitch tag]+100]).textColor = [UIColor blackColor];
            [abilitiesSwitch setOn:NO];
            break;
        case 2:
            [abilitiesSwitch setUserInteractionEnabled:NO];
            ((UILabel *)[self.view viewWithTag:[abilitiesSwitch tag]+100]).textColor = [UIColor blackColor];            
            [abilitiesSwitch setOn:YES];
            break;
        case 3:
            [abilitiesSwitch setUserInteractionEnabled:YES];
            ((UILabel *)[self.view viewWithTag:[abilitiesSwitch tag]+100]).textColor = [UIColor blackColor];            
            [abilitiesSwitch setOn:NO];
            break;
        default:
            [abilitiesSwitch setOn:NO];
            [abilitiesSwitch setUserInteractionEnabled:NO];
            ((UILabel *)[self.view viewWithTag:[abilitiesSwitch tag]+100]).textColor = [UIColor grayColor];            
            break;
    }
}

- (IBAction)switchWasFlipped:(id)sender
{
    if ([skillsRemainingTextField.text intValue] > 0 ||
        ![((UISwitch*)sender) isOn])
    {
        if ([((NSNumber *)[classAbilities objectAtIndex:[sender tag]]) isEqualToNumber:[NSNumber numberWithInt:3]]) 
        {
            int i = 0;
            for (NSNumber *ability in classAbilities) 
            {
                if ([ability isEqualToNumber:[NSNumber numberWithInt:3]]) 
                {
                    [((UISwitch *)[[self view] viewWithTag:i+1]) setUserInteractionEnabled:NO];
                    ((UILabel *)[[self view] viewWithTag:i+100]).textColor = [UIColor grayColor];
                }
                i++;
            }
        }
        if ([((UISwitch *)sender) isOn]) 
        {
            skillsRemainingTextField.text = [NSString stringWithFormat:@"%d", [skillsRemainingTextField.text intValue] - 1];
        }
        else
        {
            skillsRemainingTextField.text = [NSString stringWithFormat:@"%d", [skillsRemainingTextField.text intValue] + 1];            
        }
    }
    else
    {
        [((UISwitch *)sender) setOn:NO];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Low Points!" 
                                                        message:@"In order to train in another skill, you must untrain one of your trained skills." 
                                                       delegate:nil 
                                              cancelButtonTitle:@"Ok" 
                                              otherButtonTitles:nil];
        [alert show];
    }
}    

- (void)viewDidUnload
{
    [self setAcrobaticsSwitch:nil];
    [self setArcanaSwitch:nil];
    [self setAthleticsSwitch:nil];
    [self setBluffSwitch:nil];
    [self setDiplomacySwitch:nil];
    [self setDungeoneeringSwitch:nil];
    [self setEnduranceSwitch:nil];
    [self setHealSwitch:nil];
    [self setHistorySwitch:nil];
    [self setInsightSwitch:nil];
    [self setIntimidateSwitch:nil];
    [self setNatureSwitch:nil];
    [self setPerceptionSwitch:nil];
    [self setReligionSwitch:nil];
    [self setStealthSwitch:nil];
    [self setStreetwiseSwitch:nil];
    [self setThieverySwitch:nil];
    [self setSkillsRemainingTextField:nil];
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
