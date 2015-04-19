//
//  CustomStore.m
//  NSAtomicStoreExample
//
//  Created by August on 15/4/15.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "CustomStore.h"

@implementation CustomStore

#pragma mark - NSPersistentStore
- (NSString *)type {
    return [[self metadata] objectForKey:NSStoreTypeKey];
}
- (NSString *)identifier {
    return [[self metadata] objectForKey:NSStoreUUIDKey];
}
- (id)initWithPersistentStoreCoordinator:(NSPersistentStoreCoordinator *)coordinator configurationName:(NSString *)configurationName URL:(NSURL *)url options:(NSDictionary *)options {
    self = [super initWithPersistentStoreCoordinator:coordinator configurationName:configurationName URL:url options:options];
    NSDictionary *metadata = [CustomStore metadataForPersistentStoreWithURL:[self URL] error:nil];
    [self setMetadata:metadata];
    nodeCacheRef = [NSMutableDictionary dictionary];
    return self;
}
+ (NSDictionary *)metadataForPersistentStoreWithURL:(NSURL *)url error:(NSError **)error {
    // Determine the filename for the metadata file
    NSString *path = [[url relativePath] stringByAppendingString:@".plist"];
    // If the metadata file doesn't exist, create it if(![[NSFileManager defaultManager] fileExistsAtPath:path]) {
    // Create a dictionary and store the store type key (CustomStore) // and the UUID key
    NSMutableDictionary *metadata = [NSMutableDictionary dictionary];
    [metadata setValue:@"CustomStore" forKey:NSStoreTypeKey];
    [metadata setValue:[CustomStore makeUUID] forKey:NSStoreUUIDKey];
    // Write the metadata to the .plist file [CustomStore writeMetadata:metadata toURL:url];
    // Write an empty data file
    [@"" writeToURL:url atomically:YES encoding:[NSString defaultCStringEncoding] error:nil];
    NSLog(@"Created new store at %@", path);
    return [NSDictionary dictionaryWithContentsOfFile:path];
}
#pragma mark - NSAtomicStore
- (BOOL)load:(NSError **)error {
    return YES;
}
- (id)newReferenceObjectForManagedObject:(NSManagedObject *)managedObject {
    NSString *uuid = [CustomStore makeUUID];
    return uuid;
}
- (NSAtomicStoreCacheNode *)newCacheNodeForManagedObject:(NSManagedObject *)managedObject {
    NSManagedObjectID *oid = [managedObject objectID];
    id referenceID = [self referenceObjectForObjectID:oid];
    NSAtomicStoreCacheNode* node = [self nodeForReferenceObject:referenceID andObjectID:oid];
    [self updateCacheNode:node fromManagedObject:managedObject];
    return node;
}
- (BOOL)save:(NSError **)error {
    NSURL *url = [self URL];
    // First update the metadata
    [CustomStore writeMetadata:[self metadata] toURL:url];
    
    NSString* dataFile = @"";
    // Then write the actual data
    NSSet *nodes = [self cacheNodes];
    NSAtomicStoreCacheNode *node;
    NSEnumerator *enumerator = [nodes objectEnumerator];
    while ((node = [enumerator nextObject]) != nil) {
        // Get the object ID and reference ID for each node
        NSManagedObjectID *oid = [node objectID];
        id referenceID = [self referenceObjectForObjectID:oid];
        // Write the entity name and reference ID as the first two
        // values in the row
        NSEntityDescription *entity = [oid entity];
        dataFile = [dataFile stringByAppendingFormat:@"%@|%@", entity.name, referenceID];
        
        NSDictionary *attributes = [entity attributesByName];
        NSAttributeDescription *key = nil;
        NSEnumerator *enumerator = [attributes objectEnumerator];
        while ((key = [enumerator nextObject]) != nil) {
            NSString *value = [node valueForKey:key.name];
            if (value == nil)
                value = @"(null)";
            dataFile = [dataFile stringByAppendingFormat:@"|%@=%@", key.name, value];
        }
        
        
        // Write all the relationships
        NSDictionary *relationships = [entity relationshipsByName];
        NSRelationshipDescription *key = nil;
        NSEnumerator *enumerator = [relationships objectEnumerator];
    }
    
    return YES;
}

-(void)updateCacheNode:(NSAtomicStoreCacheNode *)node fromManagedObject:(NSManagedObject *)managedObject
{
    NSEntityDescription *entity = managedObject.entity;
    NSDictionary *attributes = [entity attributesByName];
    for (NSString *name in [attributes allKeys]) {
        // For each attribute, set the managed object's value into the node
        [node setValue:[managedObject valueForKey:name] forKey:name];
    }
    
    NSDictionary *relationships = [entity relationshipsByName];
    
    for (NSString *name in [relationships allKeys]) {
        id value = [managedObject valueForKey:name];
        // If this is a to-many relationship . . .
        if ([[relationships objectForKey:name] isToMany]) {
            NSSet *set = (NSSet *)value;
            NSMutableSet *data = [NSMutableSet set];
            for (NSManagedObject *managedObject in set) {
                // For each destination object in the relationship,
                // add the cache node to the set
                NSManagedObjectID *oid = [managedObject objectID];
                id referenceID = [self referenceObjectForObjectID:oid];
                NSAtomicStoreCacheNode* n = [self nodeForReferenceObject:referenceID
                                                             andObjectID:oid];
                [data addObject:n];
            }
            [node setValue:data forKey:name];
        }else{
            // This is a to-one relationship, so just get the single // destination node for the relationship
            NSManagedObject *managedObject = (NSManagedObject*)value; NSManagedObjectID *oid = [managedObject objectID];
            id referenceID = [self referenceObjectForObjectID:oid];
            NSAtomicStoreCacheNode* n = [self nodeForReferenceObject:referenceID andObjectID:oid];
            [node setValue:n forKey:name];
        }

    }
}

#pragma mark - private class methods

+ (NSString *)makeUUID {
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuidStringRef = CFUUIDCreateString(NULL, uuidRef); CFRelease(uuidRef);
    NSString* uuid = [NSString stringWithString:( __bridge NSString *)uuidStringRef]; CFRelease(uuidStringRef);
    return uuid;
}

+ (void)writeMetadata:(NSDictionary*)metadata toURL:(NSURL*)url {
    NSString *path = [[url relativePath] stringByAppendingString:@".plist"]; [metadata writeToFile:path atomically:YES];
}

-(NSAtomicStoreCacheNode *)nodeForReferenceObject:(id)refrence
                                      andObjectID:(NSManagedObjectID *)objectID
{
    NSAtomicStoreCacheNode *cacheNode = [nodeCacheRef objectForKey:refrence];
    if (cacheNode == nil) {
        cacheNode = [[NSAtomicStoreCacheNode alloc] initWithObjectID:objectID];
        [nodeCacheRef setObject:cacheNode forKey:refrence];
    }
    return cacheNode;
}

@end
