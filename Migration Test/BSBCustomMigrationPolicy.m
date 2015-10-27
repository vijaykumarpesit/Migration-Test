//
//  BSBCustomMigrationPolicy.m
//  Migration Test
//
//  Created by Vijay on 27/10/15.
//  Copyright © 2015 Vijay. All rights reserved.
//

#import "BSBCustomMigrationPolicy.h"

@implementation BSBCustomMigrationPolicy

- (BOOL)createDestinationInstancesForSourceInstance:(NSManagedObject *)sourceInstance
                                      entityMapping:(NSEntityMapping *)mapping
                                            manager:(NSMigrationManager *)manager
                                              error:(NSError **)error {
    // Create a new object for the model context
    NSManagedObject *destinationInstance =
    [NSEntityDescription insertNewObjectForEntityForName:[mapping destinationEntityName]
                                  inManagedObjectContext:[manager destinationContext]];
    
    [self migrateTimestampFromSourceInstance:sourceInstance toDayInDestinationInstance:destinationInstance];
    
    // Migrate the remaining attributes
    NSSet *sourceAttributeNames = [NSSet setWithArray:[[sourceInstance.entity attributesByName] allKeys]];
    
    for (NSString *attributeName in sourceAttributeNames) {
        [destinationInstance setValue:[sourceInstance valueForKey:attributeName] forKey:attributeName];
    }
        

    // Couple the source with destination
    [manager associateSourceInstance:sourceInstance withDestinationInstance:destinationInstance forEntityMapping:mapping];
    
    return YES;
}

- (void)migrateTimestampFromSourceInstance:(NSManagedObject *)sourceInstance
              toDayInDestinationInstance:(NSManagedObject *)destinationInstance {
    
    NSDate *timestamp = [sourceInstance valueForKey:@"timeStamp"];
    NSDate *dateAfterStrippingDayAndTimeComponents = [self dateAfterStrippingDayAndTimeComponentsFromDate:timestamp];
    [destinationInstance setValue:dateAfterStrippingDayAndTimeComponents forKey:@"dayFromTimeStamp"];
}

- (NSDate *)dateAfterStrippingDayAndTimeComponentsFromDate:(NSDate *)date {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay
                                          fromDate:date];
    return [calendar dateFromComponents:comps];
}


@end
