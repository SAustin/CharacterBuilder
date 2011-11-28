//
//  EBClassPickerViewController.h
//  CharacterBuilder
//
//  Created by Scott Austin on 11/22/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CharacterRace.h"

@protocol EBClassPickerViewControllerDelegate;

@interface EBClassPickerViewController : UIViewController
    <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) NSString *pickerType;
@property (nonatomic, strong) NSMutableArray *pickerValues;
@property (nonatomic, strong) IBOutlet UIPickerView *picker;
@property (nonatomic, strong) CharacterRace *currentRace;
@property (nonatomic) int minValue;
@property (nonatomic) int maxValue;
@property (nonatomic, unsafe_unretained) id<EBClassPickerViewControllerDelegate> delegate;
           
- (void)prepPicker;
- (IBAction)chooseButtonWasPressed:(id)sender;

@end

@protocol EBClassPickerViewControllerDelegate <NSObject>

- (void)userDidSelectValue:(NSString *)value;

@end
