//
//  CharacterFeat.h
//  CharacterBuilder
//
//  Created by Scott Austin on 11/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Character;

@interface CharacterFeat : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * tier;
@property (nonatomic, retain) NSString * racePrereq;
@property (nonatomic, retain) NSString * classPrereq;
@property (nonatomic, retain) NSString * classFeaturePrereq;
@property (nonatomic, retain) NSString * dietyPrereq;
@property (nonatomic, retain) NSString * powerPrereq;
@property (nonatomic, retain) NSString * armorPrereq;
@property (nonatomic, retain) NSString * equippedPrereq;
@property (nonatomic, retain) NSNumber * strengthPrereq;
@property (nonatomic, retain) NSNumber * constitutionPrereq;
@property (nonatomic, retain) NSNumber * dexterityPrereq;
@property (nonatomic, retain) NSNumber * intelligencePrereq;
@property (nonatomic, retain) NSNumber * wisdomPrereq;
@property (nonatomic, retain) NSNumber * charismaPrereq;
@property (nonatomic, retain) NSNumber * armorClassBenefit;
@property (nonatomic, retain) NSNumber * fortitudeBenefit;
@property (nonatomic, retain) NSNumber * reflexBenefit;
@property (nonatomic, retain) NSNumber * willBenefit;
@property (nonatomic, retain) NSString * powerBenefit;
@property (nonatomic, retain) NSString * benefitText;
@property (nonatomic, retain) NSString * specialText;
@property (nonatomic, retain) NSNumber * arcanaBenefit;
@property (nonatomic, retain) NSNumber * athleticsBenefit;
@property (nonatomic, retain) NSNumber * acrobaticsBenefit;
@property (nonatomic, retain) NSNumber * bluffBenefit;
@property (nonatomic, retain) NSNumber * diplomacyBenefit;
@property (nonatomic, retain) NSNumber * dungeoneeringBenefit;
@property (nonatomic, retain) NSNumber * enduranceBenefit;
@property (nonatomic, retain) NSNumber * healBenefit;
@property (nonatomic, retain) NSNumber * historyBenefit;
@property (nonatomic, retain) NSNumber * insightBenefit;
@property (nonatomic, retain) NSNumber * intimidateBenefit;
@property (nonatomic, retain) NSNumber * natureBenefit;
@property (nonatomic, retain) NSNumber * perceptionBenefit;
@property (nonatomic, retain) NSNumber * religionBenefit;
@property (nonatomic, retain) NSNumber * stealthBenefit;
@property (nonatomic, retain) NSNumber * streetwiseBenefit;
@property (nonatomic, retain) NSNumber * theiveryBenefit;
@property (nonatomic, retain) NSNumber * proficencyBenefit;
@property (nonatomic, retain) Character *character;

@end
