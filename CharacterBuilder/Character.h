//
//  Character.h
//  CharacterBuilder
//
//  Created by Scott Austin on 11/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CharacterClass, CharacterFeat, CharacterPower, CharacterRace;

@interface Character : NSManagedObject

@property (nonatomic, retain) NSString * adventuringCompany;
@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSString * alignment;
@property (nonatomic, retain) NSNumber * charisma;
@property (nonatomic, retain) NSNumber * constitution;
@property (nonatomic, retain) NSNumber * dexterity;
@property (nonatomic, retain) NSString * diety;
@property (nonatomic, retain) NSString * epicDestiny;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSNumber * height;
@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) NSNumber * intelligence;
@property (nonatomic, retain) NSNumber * level;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * paragonPath;
@property (nonatomic, retain) NSString * size;
@property (nonatomic, retain) NSNumber * strength;
@property (nonatomic, retain) NSNumber * totalXP;
@property (nonatomic, retain) NSNumber * weight;
@property (nonatomic, retain) NSNumber * wisdom;
@property (nonatomic, retain) NSNumber * armorClass;
@property (nonatomic, retain) NSNumber * reflex;
@property (nonatomic, retain) NSNumber * fortitude;
@property (nonatomic, retain) NSNumber * will;
@property (nonatomic, retain) CharacterClass *characterClass;
@property (nonatomic, retain) CharacterRace *characterRace;
@property (nonatomic, retain) NSSet *feats;
@property (nonatomic, retain) NSSet *powers;
@end

@interface Character (CoreDataGeneratedAccessors)

- (void)addFeatsObject:(CharacterFeat *)value;
- (void)removeFeatsObject:(CharacterFeat *)value;
- (void)addFeats:(NSSet *)values;
- (void)removeFeats:(NSSet *)values;

- (void)addPowersObject:(CharacterPower *)value;
- (void)removePowersObject:(CharacterPower *)value;
- (void)addPowers:(NSSet *)values;
- (void)removePowers:(NSSet *)values;

@end
