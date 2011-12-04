//
//  CharacterPower.h
//  CharacterBuilder
//
//  Created by Scott Austin on 11/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Character;

@interface CharacterPower : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * characterClass;
@property (nonatomic, retain) NSString * powerType;
@property (nonatomic, retain) NSString * level;
@property (nonatomic, retain) NSString * flavorText;
@property (nonatomic, retain) NSString * powerSource;
@property (nonatomic, retain) NSString * powerUsage;
@property (nonatomic, retain) NSNumber * implement;
@property (nonatomic, retain) NSNumber * weapon;
@property (nonatomic, retain) NSNumber * acidDamage;
@property (nonatomic, retain) NSNumber * coldDamage;
@property (nonatomic, retain) NSNumber * fireDamage;
@property (nonatomic, retain) NSNumber * forceDamage;
@property (nonatomic, retain) NSNumber * lighteningDamage;
@property (nonatomic, retain) NSNumber * necroticDamage;
@property (nonatomic, retain) NSNumber * poisonDamage;
@property (nonatomic, retain) NSNumber * psychicDamage;
@property (nonatomic, retain) NSNumber * radiantDamage;
@property (nonatomic, retain) NSNumber * thunderDamage;
@property (nonatomic, retain) NSNumber * charmEffect;
@property (nonatomic, retain) NSNumber * conjurationEffect;
@property (nonatomic, retain) NSNumber * fearEffect;
@property (nonatomic, retain) NSNumber * healingEffect;
@property (nonatomic, retain) NSNumber * illusionEffect;
@property (nonatomic, retain) NSNumber * poisonEffect;
@property (nonatomic, retain) NSNumber * polymorphEffect;
@property (nonatomic, retain) NSNumber * reliableEffect;
@property (nonatomic, retain) NSNumber * sleepEffect;
@property (nonatomic, retain) NSNumber * stanceEffect;
@property (nonatomic, retain) NSNumber * teleportationEffect;
@property (nonatomic, retain) NSNumber * zoneEffect;
@property (nonatomic, retain) NSString * powerAccessories;
@property (nonatomic, retain) NSString * actionType;
@property (nonatomic, retain) NSString * attackType;
@property (nonatomic, retain) NSString * range;
@property (nonatomic, retain) NSString * trigger;
@property (nonatomic, retain) NSString * prerequesite;
@property (nonatomic, retain) NSString * requirement;
@property (nonatomic, retain) NSString * target;
@property (nonatomic, retain) NSString * attackFrom;
@property (nonatomic, retain) NSString * attackAgainst;
@property (nonatomic, retain) NSNumber * attackCount;
@property (nonatomic, retain) NSString * secondaryTarget;
@property (nonatomic, retain) NSString * secondaryAttackFrom;
@property (nonatomic, retain) NSString * secondaryAttackAgainst;
@property (nonatomic, retain) NSString * secondaryHit;
@property (nonatomic, retain) NSString * effect;
@property (nonatomic, retain) NSString * sustain;
@property (nonatomic, retain) NSString * sustainMinor;
@property (nonatomic, retain) NSString * hit;
@property (nonatomic, retain) NSString * miss;
@property (nonatomic, retain) NSString * special;
@property (nonatomic, retain) NSString * weaponHitMod;
@property (nonatomic, retain) NSString * weaponAttackMod;
@property (nonatomic, retain) Character *character;

@end
