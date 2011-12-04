//
//  EBAppDelegate.m
//  CharacterBuilder
//
//  Created by Scott Austin on 11/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "EBAppDelegate.h"

#import "EBMasterViewController.h"

@implementation EBAppDelegate

@synthesize window = _window;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
    UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
    splitViewController.delegate = (id)navigationController.topViewController;

    UINavigationController *masterNavigationController = [splitViewController.viewControllers objectAtIndex:0];
    EBMasterViewController *controller = (EBMasterViewController *)masterNavigationController.topViewController;
    controller.managedObjectContext = self.managedObjectContext;
    
    [self prepareDatabase];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil)
    {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil)
    {
        return __managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CharacterBuilder" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return __managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil)
    {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CharacterBuilder.sqlite"];
    
    [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];    
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:[storeURL description]]) 
    {
        NSString *defaultStorePath = [[NSBundle mainBundle] pathForResource:@"CharacterBuilder" ofType:@"sqlite"];
        if (defaultStorePath) 
        {
            [fileManager copyItemAtPath:defaultStorePath toPath:[storeURL description] error:NULL];
        }
    }
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return __persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

/*
 * This is only needed to create the database!
 */
- (void)prepareDatabase
{
    CSVParser *parser = [CSVParser alloc];
    NSError *error;
    NSString *featFile = [[NSBundle mainBundle] pathForResource:@"feats" ofType:@"csv"];

    [parser openFile:featFile];
    NSArray *feats = [parser parseFile];
    [parser closeFile];
    
    CharacterFeat *feat = [[CharacterFeat alloc] init];
    
    for (NSArray *featRecord in feats) 
    {
        feat = [NSEntityDescription insertNewObjectForEntityForName:@"CharacterFeat"
                                             inManagedObjectContext:[self managedObjectContext]];
        [feat setName:[featRecord objectAtIndex:0]];
        [feat setTier:[featRecord objectAtIndex:1]];
        [feat setRacePrereq:[featRecord objectAtIndex:2]];
        [feat setClassPrereq:[featRecord objectAtIndex:3]];
        [feat setDietyPrereq:[featRecord objectAtIndex:4]];
        [feat setPowerPrereq:[featRecord objectAtIndex:5]];
        [feat setArmorPrereq:[featRecord objectAtIndex:6]];
        [feat setEquippedPrereq:[featRecord objectAtIndex:7]];
        [feat setStrengthPrereq:[NSNumber numberWithInt:[[featRecord objectAtIndex:8] intValue]]];
        [feat setConstitutionPrereq:[NSNumber numberWithInt:[[featRecord objectAtIndex:9] intValue]]];
        [feat setDexterityPrereq:[NSNumber numberWithInt:[[featRecord objectAtIndex:10] intValue]]];
        [feat setIntelligencePrereq:[NSNumber numberWithInt:[[featRecord objectAtIndex:11] intValue]]];
        [feat setWisdomPrereq:[NSNumber numberWithInt:[[featRecord objectAtIndex:12] intValue]]];
        [feat setCharismaPrereq:[NSNumber numberWithInt:[[featRecord objectAtIndex:13] intValue]]];
        [feat setArmorClassBenefit:[NSNumber numberWithInt:[[featRecord objectAtIndex:14] intValue]]];
        [feat setFortitudeBenefit:[NSNumber numberWithInt:[[featRecord objectAtIndex:15] intValue]]];
        [feat setReflexBenefit:[NSNumber numberWithInt:[[featRecord objectAtIndex:16] intValue]]];
        [feat setWillBenefit:[NSNumber numberWithInt:[[featRecord objectAtIndex:17] intValue]]];
        [feat setPowerBenefit:[featRecord objectAtIndex:18]];
        [feat setBenefitText:[featRecord objectAtIndex:19]];
        [feat setSpecialText:[featRecord objectAtIndex:20]];
        [feat setAcrobaticsBenefit:[NSNumber numberWithInt:[[featRecord objectAtIndex:21] intValue]]];
        [feat setArcanaBenefit:[NSNumber numberWithInt:[[featRecord objectAtIndex:22] intValue]]];
        [feat setAthleticsBenefit:[NSNumber numberWithInt:[[featRecord objectAtIndex:23] intValue]]];
        [feat setAthleticsBenefit:[NSNumber numberWithInt:[[featRecord objectAtIndex:24] intValue]]];
        [feat setBluffBenefit:[NSNumber numberWithInt:[[featRecord objectAtIndex:25] intValue]]];
        [feat setDiplomacyBenefit:[NSNumber numberWithInt:[[featRecord objectAtIndex:26] intValue]]];
        [feat setDungeoneeringBenefit:[NSNumber numberWithInt:[[featRecord objectAtIndex:27] intValue]]];
        [feat setEnduranceBenefit:[NSNumber numberWithInt:[[featRecord objectAtIndex:28] intValue]]];
        [feat setHealBenefit:[NSNumber numberWithInt:[[featRecord objectAtIndex:29] intValue]]];
        [feat setHistoryBenefit:[NSNumber numberWithInt:[[featRecord objectAtIndex:30] intValue]]];
        [feat setInsightBenefit:[NSNumber numberWithInt:[[featRecord objectAtIndex:31] intValue]]];
        [feat setIntimidateBenefit:[NSNumber numberWithInt:[[featRecord objectAtIndex:32] intValue]]];
        [feat setNatureBenefit:[NSNumber numberWithInt:[[featRecord objectAtIndex:33] intValue]]];
        [feat setPerceptionBenefit:[NSNumber numberWithInt:[[featRecord objectAtIndex:34] intValue]]];
        [feat setReligionBenefit:[NSNumber numberWithInt:[[featRecord objectAtIndex:35] intValue]]];
        [feat setStealthBenefit:[NSNumber numberWithInt:[[featRecord objectAtIndex:36] intValue]]];
        [feat setStreetwiseBenefit:[NSNumber numberWithInt:[[featRecord objectAtIndex:37] intValue]]];
        [feat setTheiveryBenefit:[NSNumber numberWithInt:[[featRecord objectAtIndex:38] intValue]]];
        [feat setProficencyBenefit:[featRecord objectAtIndex:39]];
        
        [[self managedObjectContext] save:&error];
    }
    
    NSString *powerFile = [[NSBundle mainBundle] pathForResource:@"powers" 
                                                          ofType:@"csv"];
    [parser openFile:powerFile];
    NSArray *powers = [parser parseFile];
    [parser closeFile];
    
    CharacterPower *power = [CharacterPower alloc];
    for (NSArray *powerRecord in powers) 
    {
        power = [NSEntityDescription insertNewObjectForEntityForName:@"CharacterPower" 
                                              inManagedObjectContext:[self managedObjectContext]];
        
        [power setName:[powerRecord objectAtIndex:0]];
        [power setCharacterClass:[powerRecord objectAtIndex:1]];
        [power setPowerType:[powerRecord objectAtIndex:2]];
        [power setLevel:[powerRecord objectAtIndex:3]];
        [power setFlavorText:[powerRecord objectAtIndex:4]];
        [power setPowerSource:[powerRecord objectAtIndex:5]];
        [power setPowerUsage:[powerRecord objectAtIndex:6]];
        [power setImplement:[NSNumber numberWithInt:[[powerRecord objectAtIndex:7] intValue]]];
        [power setWeapon:[NSNumber numberWithInt:[[powerRecord objectAtIndex:8] intValue]]];
        [power setAcidDamage:[NSNumber numberWithInt:[[powerRecord objectAtIndex:9] intValue]]];
        [power setColdDamage:[NSNumber numberWithInt:[[powerRecord objectAtIndex:10] intValue]]];
        [power setFireDamage:[NSNumber numberWithInt:[[powerRecord objectAtIndex:11] intValue]]];
        [power setForceDamage:[NSNumber numberWithInt:[[powerRecord objectAtIndex:12] intValue]]];
        [power setLighteningDamage:[NSNumber numberWithInt:[[powerRecord objectAtIndex:13] intValue]]];
        [power setNecroticDamage:[NSNumber numberWithInt:[[powerRecord objectAtIndex:14] intValue]]];
        [power setPoisonDamage:[NSNumber numberWithInt:[[powerRecord objectAtIndex:15] intValue]]];
        [power setPsychicDamage:[NSNumber numberWithInt:[[powerRecord objectAtIndex:16] intValue]]];
        [power setRadiantDamage:[NSNumber numberWithInt:[[powerRecord objectAtIndex:17] intValue]]];
        [power setThunderDamage:[NSNumber numberWithInt:[[powerRecord objectAtIndex:18] intValue]]];
        [power setCharmEffect:[NSNumber numberWithInt:[[powerRecord objectAtIndex:19] intValue]]];
        [power setConjurationEffect:[NSNumber numberWithInt:[[powerRecord objectAtIndex:20] intValue]]];
        [power setFearEffect:[NSNumber numberWithInt:[[powerRecord objectAtIndex:21] intValue]]];
        [power setHealingEffect:[NSNumber numberWithInt:[[powerRecord objectAtIndex:22] intValue]]];
        [power setIllusionEffect:[NSNumber numberWithInt:[[powerRecord objectAtIndex:23] intValue]]];
        [power setPoisonEffect:[NSNumber numberWithInt:[[powerRecord objectAtIndex:24] intValue]]];
        [power setPolymorphEffect:[NSNumber numberWithInt:[[powerRecord objectAtIndex:25] intValue]]];
        [power setReliableEffect:[NSNumber numberWithInt:[[powerRecord objectAtIndex:26] intValue]]];
        [power setSleepEffect:[NSNumber numberWithInt:[[powerRecord objectAtIndex:27] intValue]]];
        [power setStanceEffect:[NSNumber numberWithInt:[[powerRecord objectAtIndex:28] intValue]]];
        [power setTeleportationEffect:[NSNumber numberWithInt:[[powerRecord objectAtIndex:29] intValue]]];
        [power setZoneEffect:[NSNumber numberWithInt:[[powerRecord objectAtIndex:30] intValue]]];
        [power setPowerAccessories:[powerRecord objectAtIndex:31]];
        [power setActionType:[powerRecord objectAtIndex:32]];
        [power setAttackType:[powerRecord objectAtIndex:33]];
        [power setRange:[powerRecord objectAtIndex:34]];
        [power setTrigger:[powerRecord objectAtIndex:35]];
        [power setPrerequesite:[powerRecord objectAtIndex:36]];
        [power setRequirement:[powerRecord objectAtIndex:37]];
        [power setTarget:[powerRecord objectAtIndex:38]];
        [power setAttackFrom:[powerRecord objectAtIndex:39]];
        [power setAttackAgainst:[powerRecord objectAtIndex:40]];
        [power setAttackCount:[NSNumber numberWithInt:[[powerRecord objectAtIndex:41] intValue]]];
        [power setSecondaryTarget:[powerRecord objectAtIndex:42]];
        [power setSecondaryAttackFrom:[powerRecord objectAtIndex:43]];
        [power setSecondaryAttackAgainst:[powerRecord objectAtIndex:44]];
        [power setSecondaryHit:[powerRecord objectAtIndex:45]];
        [power setEffect:[powerRecord objectAtIndex:46]];
        [power setSustain:[powerRecord objectAtIndex:47]];
        [power setSustainMinor:[powerRecord objectAtIndex:48]];
        [power setHit:[powerRecord objectAtIndex:49]];
        [power setMiss:[powerRecord objectAtIndex:50]];
        [power setSpecial:[powerRecord objectAtIndex:51]];
        [power setWeaponAttackMod:[powerRecord objectAtIndex:52]];
        [power setWeaponHitMod:[powerRecord objectAtIndex:53]];
        
        [[self managedObjectContext] save:&error];
    }
    
    NSString *raceFile = [[NSBundle mainBundle] pathForResource:@"races" ofType:@"csv"];
    [parser openFile:raceFile];
    NSArray *races = [parser parseFile];
    [parser closeFile];
    
    CharacterRace *race = [CharacterRace alloc];
    
    for (NSArray *raceRecord in races) 
    {
        race = [NSEntityDescription insertNewObjectForEntityForName:@"CharacterRace" 
                                             inManagedObjectContext:[self managedObjectContext]];
        [race setName:[raceRecord objectAtIndex:0]];
        [race setHeightRange:[raceRecord objectAtIndex:1]];
        [race setWeightRange:[raceRecord objectAtIndex:2]];
        [race setStrengthMod:[NSNumber numberWithInt:[[raceRecord objectAtIndex:3] intValue]]];
        [race setConstitutionMod:[NSNumber numberWithInt:[[raceRecord objectAtIndex:4] intValue]]];
        [race setDexterityMod:[NSNumber numberWithInt:[[raceRecord objectAtIndex:5] intValue]]];
        [race setIntelligenceMod:[NSNumber numberWithInt:[[raceRecord objectAtIndex:6] intValue]]];
        [race setWisdomMod:[NSNumber numberWithInt:[[raceRecord objectAtIndex:7] intValue]]];
        [race setCharismaMod:[NSNumber numberWithInt:[[raceRecord objectAtIndex:8] intValue]]];
        [race setSize:[raceRecord objectAtIndex:9]];
        [race setSpeed:[NSNumber numberWithInt:[[raceRecord objectAtIndex:10] intValue]]];
        [race setVision:[raceRecord objectAtIndex:11]];
        [race setLanguages:[raceRecord objectAtIndex:12]];
        [race setAcrobaticsMod:[NSNumber numberWithInt:[[raceRecord objectAtIndex:13] intValue]]];
        [race setArcanaMod:[NSNumber numberWithInt:[[raceRecord objectAtIndex:14] intValue]]];
        [race setAthleticsMod:[NSNumber numberWithInt:[[raceRecord objectAtIndex:15] intValue]]];
        [race setBluffMod:[NSNumber numberWithInt:[[raceRecord objectAtIndex:16] intValue]]];
        [race setDiplomacyMod:[NSNumber numberWithInt:[[raceRecord objectAtIndex:17] intValue]]];
        [race setDungeoneeringMod:[NSNumber numberWithInt:[[raceRecord objectAtIndex:18] intValue]]];
        [race setEnduranceMod:[NSNumber numberWithInt:[[raceRecord objectAtIndex:19] intValue]]];
        [race setHealMod:[NSNumber numberWithInt:[[raceRecord objectAtIndex:20] intValue]]];
        [race setHistoryMod:[NSNumber numberWithInt:[[raceRecord objectAtIndex:21] intValue]]];
        [race setInsightMod:[NSNumber numberWithInt:[[raceRecord objectAtIndex:22] intValue]]];
        [race setIntimidateMod:[NSNumber numberWithInt:[[raceRecord objectAtIndex:23] intValue]]];
        [race setNatureMod:[NSNumber numberWithInt:[[raceRecord objectAtIndex:24] intValue]]];
        [race setPerceptionMod:[NSNumber numberWithInt:[[raceRecord objectAtIndex:25] intValue]]];
        [race setReligionMod:[NSNumber numberWithInt:[[raceRecord objectAtIndex:26] intValue]]];
        [race setStealthMod:[NSNumber numberWithInt:[[raceRecord objectAtIndex:27] intValue]]];
        [race setStreetwiseMod:[NSNumber numberWithInt:[[raceRecord objectAtIndex:28] intValue]]];
        [race setThieveryMod:[NSNumber numberWithInt:[[raceRecord objectAtIndex:29] intValue]]];
        
        [[self managedObjectContext] save:&error];
    }
    
    NSString *classFile = [[NSBundle mainBundle] pathForResource:@"classes" ofType:@"csv"];
    
    [parser openFile:classFile];
    NSArray *classes = [parser parseFile];
    [parser closeFile];
    
    CharacterClass *charClass = [CharacterClass alloc];
    
    for (NSArray *classRecord in classes) 
    {
        charClass = [NSEntityDescription insertNewObjectForEntityForName:@"CharacterClass" 
                                                  inManagedObjectContext:[self managedObjectContext]];
        [charClass setName:[classRecord objectAtIndex:0]];
        [charClass setRole:[classRecord objectAtIndex:1]];
        [charClass setRoleDescription:[classRecord objectAtIndex:2]];
        [charClass setPowerSource:[classRecord objectAtIndex:3]];
        [charClass setPowerSourceDescription:[classRecord objectAtIndex:4]];
        [charClass setKeyStrengths:[classRecord objectAtIndex:5]];
        [charClass setArmorProf:[classRecord objectAtIndex:6]];
        [charClass setMeleeProf:[classRecord objectAtIndex:7]];
        [charClass setRangedProf:[classRecord objectAtIndex:8]];
        [charClass setWeaponProf:[classRecord objectAtIndex:9]];
        [charClass setImplement:[classRecord objectAtIndex:10]];
        [charClass setArmorClassBonus:[NSNumber numberWithInt:[[classRecord objectAtIndex:11] intValue]]];
        [charClass setFortitudeBonus:[NSNumber numberWithInt:[[classRecord objectAtIndex:12] intValue]]];
        [charClass setReflexBonus:[NSNumber numberWithInt:[[classRecord objectAtIndex:13] intValue]]];
        [charClass setWillBonus:[NSNumber numberWithInt:[[classRecord objectAtIndex:14] intValue]]];
        [charClass setBaseHitPoints:[NSNumber numberWithInt:[[classRecord objectAtIndex:15] intValue]]];
        [charClass setHitPointModifier:[classRecord objectAtIndex:16]];
        [charClass setHitPointsPerLevel:[NSNumber numberWithInt:[[classRecord objectAtIndex:17] intValue]]];
        [charClass setHealingSurgesPerDay:[NSNumber numberWithInt:[[classRecord objectAtIndex:18] intValue]]];
        [charClass setHealingSurgModifier:[classRecord objectAtIndex:19]];
        [charClass setFirstLevelSkillCount:[NSNumber numberWithInt:[[classRecord objectAtIndex:20] intValue]]];
        [charClass setAcrobaticsSkill:[NSNumber numberWithInt:[[classRecord objectAtIndex:21] intValue]]];
        [charClass setArcanaSkill:[NSNumber numberWithInt:[[classRecord objectAtIndex:22] intValue]]];
        [charClass setAthleticsSkill:[NSNumber numberWithInt:[[classRecord objectAtIndex:23] intValue]]];
        [charClass setBluffSkill:[NSNumber numberWithInt:[[classRecord objectAtIndex:24] intValue]]];
        [charClass setDiplomacySkill:[NSNumber numberWithInt:[[classRecord objectAtIndex:25] intValue]]];
        [charClass setDungeoneeringSkill:[NSNumber numberWithInt:[[classRecord objectAtIndex:26] intValue]]];
        [charClass setEnduranceSkill:[NSNumber numberWithInt:[[classRecord objectAtIndex:27] intValue]]];
        [charClass setHealSkill:[NSNumber numberWithInt:[[classRecord objectAtIndex:28] intValue]]];
        [charClass setHistorySkill:[NSNumber numberWithInt:[[classRecord objectAtIndex:29] intValue]]];
        [charClass setInsightSkill:[NSNumber numberWithInt:[[classRecord objectAtIndex:30] intValue]]];
        [charClass setIntimidateSkill:[NSNumber numberWithInt:[[classRecord objectAtIndex:31] intValue]]];
        [charClass setNatureSkill:[NSNumber numberWithInt:[[classRecord objectAtIndex:32] intValue]]];
        [charClass setPerceptionSkill:[NSNumber numberWithInt:[[classRecord objectAtIndex:33] intValue]]];
        [charClass setReligionSkill:[NSNumber numberWithInt:[[classRecord objectAtIndex:34] intValue]]];
        [charClass setStealthSkill:[NSNumber numberWithInt:[[classRecord objectAtIndex:35] intValue]]];
        [charClass setStreetwiseSkill:[NSNumber numberWithInt:[[classRecord objectAtIndex:36] intValue]]];
        [charClass setTheiverySkill:[NSNumber numberWithInt:[[classRecord objectAtIndex:37] intValue]]];
        
        [[self managedObjectContext] save:&error];
    }
}

@end
