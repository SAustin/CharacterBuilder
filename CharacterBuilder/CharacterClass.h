//
//  CharacterClass.h
//  CharacterBuilder
//
//  Created by Scott Austin on 11/19/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CharacterClass : NSManagedObject

@property (nonatomic, retain) NSString * armorProf;
@property (nonatomic, retain) NSNumber * baseHitPoints;
@property (nonatomic, retain) NSNumber * healingSurgesPerDay;
@property (nonatomic, retain) NSString * healingSurgModifier;
@property (nonatomic, retain) NSNumber * hitPointsPerLevel;
@property (nonatomic, retain) NSString * implement;
@property (nonatomic, retain) NSString * keyStrengths;
@property (nonatomic, retain) NSString * meleeProf;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * powerSource;
@property (nonatomic, retain) NSString * powerSourceDescription;
@property (nonatomic, retain) NSString * rangedProf;
@property (nonatomic, retain) NSString * role;
@property (nonatomic, retain) NSString * roleDescription;
@property (nonatomic, retain) NSNumber * firstLevelSkillCount;
@property (nonatomic, retain) NSString * weaponProf;
@property (nonatomic, retain) NSNumber * armorClassBonus;
@property (nonatomic, retain) NSNumber * fortitudeBonus;
@property (nonatomic, retain) NSNumber * reflexBonus;
@property (nonatomic, retain) NSNumber * willBonus;
@property (nonatomic, retain) NSString * hitPointModifier;
@property (nonatomic, retain) NSNumber * acrobaticsSkill;
@property (nonatomic, retain) NSNumber * arcanaSkill;
@property (nonatomic, retain) NSNumber * athleticsSkill;
@property (nonatomic, retain) NSNumber * bluffSkill;
@property (nonatomic, retain) NSNumber * diplomacySkill;
@property (nonatomic, retain) NSNumber * dungeoneeringSkill;
@property (nonatomic, retain) NSNumber * enduranceSkill;
@property (nonatomic, retain) NSNumber * healSkill;
@property (nonatomic, retain) NSNumber * historySkill;
@property (nonatomic, retain) NSNumber * insightSkill;
@property (nonatomic, retain) NSNumber * intimidateSkill;
@property (nonatomic, retain) NSNumber * natureSkill;
@property (nonatomic, retain) NSNumber * perceptionSkill;
@property (nonatomic, retain) NSNumber * religionSkill;
@property (nonatomic, retain) NSNumber * stealthSkill;
@property (nonatomic, retain) NSNumber * streetwiseSkill;
@property (nonatomic, retain) NSNumber * theiverySkill;

@end
