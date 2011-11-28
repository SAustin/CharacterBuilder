//
//  CharacterRace.h
//  CharacterBuilder
//
//  Created by Scott Austin on 11/19/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CharacterRace : NSManagedObject

@property (nonatomic, retain) NSNumber * acrobaticsMod;
@property (nonatomic, retain) NSNumber * arcanaMod;
@property (nonatomic, retain) NSNumber * athleticsMod;
@property (nonatomic, retain) NSNumber * bluffMod;
@property (nonatomic, retain) NSNumber * charismaMod;
@property (nonatomic, retain) NSNumber * constitutionMod;
@property (nonatomic, retain) NSNumber * dexterityMod;
@property (nonatomic, retain) NSNumber * diplomacyMod;
@property (nonatomic, retain) NSNumber * dungeoneeringMod;
@property (nonatomic, retain) NSNumber * enduranceMod;
@property (nonatomic, retain) NSNumber * healMod;
@property (nonatomic, retain) NSString * heightRange;
@property (nonatomic, retain) NSNumber * historyMod;
@property (nonatomic, retain) NSNumber * insightMod;
@property (nonatomic, retain) NSNumber * intelligenceMod;
@property (nonatomic, retain) NSNumber * intimidateMod;
@property (nonatomic, retain) NSString * languages;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * natureMod;
@property (nonatomic, retain) NSNumber * perceptionMod;
@property (nonatomic, retain) NSNumber * religionMod;
@property (nonatomic, retain) NSString * size;
@property (nonatomic, retain) NSNumber * speed;
@property (nonatomic, retain) NSNumber * stealthMod;
@property (nonatomic, retain) NSNumber * streetwiseMod;
@property (nonatomic, retain) NSNumber * strengthMod;
@property (nonatomic, retain) NSNumber * thieveryMod;
@property (nonatomic, retain) NSString * vision;
@property (nonatomic, retain) NSString * weightRange;
@property (nonatomic, retain) NSNumber * wisdomMod;

@end
