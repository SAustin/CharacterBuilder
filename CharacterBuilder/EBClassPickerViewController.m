//
//  EBClassPickerViewController.m
//  CharacterBuilder
//
//  Created by Scott Austin on 11/22/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "EBClassPickerViewController.h"

@implementation EBClassPickerViewController
@synthesize pickerType;
@synthesize pickerValues;
@synthesize picker;
@synthesize currentRace;
@synthesize minValue;
@synthesize maxValue;
@synthesize delegate;

- (IBAction)chooseButtonWasPressed:(id)sender
{
    [delegate userDidSelectValue:[pickerValues objectAtIndex:[picker selectedRowInComponent:0]]];
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
}

- (void)prepPicker
{
    pickerValues = [[NSMutableArray alloc] init];

    if ([self.pickerType isEqualToString:@"gender"]) 
    {
        [pickerValues addObject:@"Male"];
        [pickerValues addObject:@"Female"];
    }
    else if ([self.pickerType isEqualToString:@"alignment"])
    {
        [pickerValues addObject:@"Good"];
        [pickerValues addObject:@"Lawful Good"];
        [pickerValues addObject:@"Unaligned"];
        [pickerValues addObject:@"Evil"];
        [pickerValues addObject:@"Chaotic Evil"];
    }
    else if ([self.pickerType isEqualToString:@"diety"])
    {
        
    }
    else
    {
        NSScanner *heightScanner;
        if ([self.pickerType isEqualToString:@"height"]) 
        {
            heightScanner = [NSScanner scannerWithString:currentRace.heightRange];
        }
        else if ([self.pickerType isEqualToString:@"weight"])
        {
            heightScanner = [NSScanner scannerWithString:currentRace.weightRange];
        }
        
        NSString *valueString = nil;
        int location = 0;
        location = [heightScanner scanUpToString:@"-" intoString:&valueString];
        
        minValue = [valueString intValue];
        [heightScanner scanCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:@"-"] intoString:NULL];
        [heightScanner scanUpToString:@"-" intoString:&valueString];
        maxValue = [valueString intValue];
        
        if ([self.pickerType isEqualToString:@"height"]) 
        {
            for (int i = minValue; i <= maxValue; i++) 
            {
                int foot = floor(i/12);
                int inches = i % 12;
                NSString *heightString = [NSString stringWithFormat:@"%d \' %d \"", foot, inches];
                [pickerValues addObject:heightString];
            }
        }
        if ([self.pickerType isEqualToString:@"weight"]) 
        {
            for (int i = minValue; i <= maxValue; i++) 
            {
                [pickerValues addObject:[NSString stringWithFormat:@"%d lbs", i]];
            }
        }    

    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

#pragma mark - UIPickerView Data Source Methods
- (NSInteger)pickerView:(UIPickerView *)pickerView 
numberOfRowsInComponent:(NSInteger)component
{
    return [pickerValues count];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

#pragma mark - UIPickerView Delegate Methods

- (NSString *)pickerView:(UIPickerView *)pickerView 
             titleForRow:(NSInteger)row 
            forComponent:(NSInteger)component
{
    return [pickerValues objectAtIndex:row];
}
@end
