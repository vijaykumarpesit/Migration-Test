//
//  BSBCoreDataManager.m
//  Migration Test
//
//  Created by Vijay on 27/10/15.
//  Copyright © 2015 Vijay. All rights reserved.
//

#import "BSBCoreDataManager.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"


@implementation BSBCoreDataManager

+ (BOOL)isLightweightMigrationRequired {
    
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[appDelegate managedObjectModel]];
    NSManagedObjectModel *destinationModel = [psc managedObjectModel];
    
    //Check configuration compatability
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Migration_Test.sqlite"];
    NSError *storeError = nil;
    NSDictionary *storeMetadata = [NSPersistentStoreCoordinator metadataForPersistentStoreOfType:NSSQLiteStoreType URL:storeURL options:nil error:&storeError];
    if (storeMetadata == nil) {
        if ([storeError code] == NSFileReadNoSuchFileError) {
            NSLog(@"Store does not exists");
            return NO;
        } else {
        }
    }
    
    BOOL storeCompatible = [destinationModel
                                   isConfiguration:nil
                                   compatibleWithStoreMetadata:storeMetadata];

    
    return !storeCompatible;
}

+ (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.vijay.migrationTest.Migration_Test" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}



@end
