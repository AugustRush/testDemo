////////////////////////////////////////////////////////////////////////////
//
// Copyright 2014 Realm Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
////////////////////////////////////////////////////////////////////////////

#import <Foundation/Foundation.h>
#import <Realm/RLMConstants.h>

@class RLMRealm;
@class RLMArray;
@class RLMObjectSchema;

/**
 
 In Realm you define your model classes by subclassing RLMObject and adding properties to be persisted.
 You then instantiate and use your custom subclasses instead of using the RLMObject class directly.
 
     // Dog.h
     @interface Dog : RLMObject
     @property NSString *name;
     @property BOOL      adopted;
     @end
 
     // Dog.m
     @implementation Dog
     @end //none needed
 
 ### Supported property types
 
 - `NSString`
 - `NSInteger`, `CGFloat`, `int`, `long`, `float`, and `double`
 - `BOOL` or `bool`
 - `NSDate`
 - `NSData`
 - RLMObject subclasses, so you can have many-to-one relationships.
 - `RLMArray<X>`, where X is an RLMObject subclass, so you can have many-to-many relationships.
 
 ### Attributes for Properties

 You can set which of these properties should be indexed, stored inline, unique, required
 as well as delete rules for the links by implementing the attributesForProperty: method.
 
 You can set properties to ignore (i.e. transient properties you do not want
 persisted to a Realm) by implementing ignoredProperties.
 
 You can set default values for properties by implementing defaultPropertyValues.
 
 ### Querying
 
 You can query an object directly via the class methods: allObjects, objectsWhere:, objectsOrderedBy:where: and objectForKeyedSubscript:
 These methods allow you to easily query a custom subclass for instances of this class in the
 default Realm. To search in a Realm other than the default Realm use the interface on an RLMRealm instance.
 
 ### Relationships
 
 See our [iOS guide](http://realm.io/docs/ios/latest) for more details.
 
 */


@interface RLMObject : NSObject

/**---------------------------------------------------------------------------------------
 *  @name Creating & Initializing Objects
 * ---------------------------------------------------------------------------------------
 */

/**
 Initialize a standalone RLMObject
 
 Initialize an unpersisted instance of this object.
 Call addObject: on an RLMRealm to add standalone object to a realm.
 
 @see [RLMRealm addObject:]:
 */
-(instancetype)init;


/**
 Initialize a standalone RLMObject with values from an NSArray or NSDictionary
 
 Initialize an unpersisted instance of this object.
 Call addObject: on an RLMRealm to add standalone object to a realm.
 
 @see [RLMRealm addObject:]:
 */
- (instancetype)initWithObject:(id)object;


/**
 Helper to return the class name for an RLMObject subclass.
 
 @return    The class name for the model class.
 */
+ (NSString *)className;

/**
 Create an RLMObject in the default Realm with a a given object.

 Creates an instance of this object and adds it to the default Realm populating
 the object with the given object.

 @param object  The object used to populate the object. This can be any key/value compliant
 object, or a JSON object such as those returned from the methods in NSJSONSerialization, or
 an NSArray with one object for each persisted property. An exception will be
 thrown if all required properties are not present or no default is provided.
 When passing in an NSArray, all properties must be present and valid.

 @see   defaultPropertyValues
 */
+(instancetype)createInDefaultRealmWithObject:(id)object;

/**
 Create an RLMObject in a Realm with a given object.
 
 Creates an instance of this object and adds it to the given Realm populating
 the object with the given object.
 
 @param realm   The Realm in which this object is persisted.
 @param object  The object used to populate the object. This can be any key/value compliant
                object, or a JSON object such as those returned from the methods in NSJSONSerialization, or
                an NSArray with one object for each persisted property. An exception will be
                thrown if all required properties are not present or no default is provided.
                When passing in an NSArray, all properties must be present and valid.
 
 @see   defaultPropertyValues
 */
+(instancetype)createInRealm:(RLMRealm *)realm withObject:(id)object;

/**
 Create an RLMObject within a Realm with a JSONString.
 
 Creates an instance of this object and adds it to the given Realm populating
 the object with the data in the given JSONString.
 
 @param realm       The Realm in which this object is persisted.
 @param JSONString  An NSString with valid JSON. An exception will be thrown if required properties are
 not present in the JSON for which defaults are not provided.
 
 @see   defaultPropertyValues
 */
// +(instancetype)createInRealm:(RLMRealm *)realm withJSONString:(NSString *)JSONString;

/**
 The Realm in which this object is persisted. Returns nil for standalone objects.
 */
@property (nonatomic, readonly) RLMRealm *realm;

/**
 The ObjectSchema which lists the persisted properties for this object.
 */
@property (nonatomic, readonly) RLMObjectSchema *objectSchema;


/**---------------------------------------------------------------------------------------
 *  @name Customizing your Objects
 * ---------------------------------------------------------------------------------------
 */

/**
 Implement to set custom attributes for each property.
 
 @param propertyName    Name of property for which attributes have been requested.
 @return                Bitmask of property attributes for the given property.
 */
+ (RLMPropertyAttributes)attributesForProperty:(NSString *)propertyName;

/**
 Implement to indicate the default values to be used for each property.
 
 @return    NSDictionary mapping property names to their default values.
 */
+ (NSDictionary *)defaultPropertyValues;

/**
 Implement to return an array of property names to ignore. These properties will not be persisted
 and are treated as transient.
 
 @return    NSArray of property names to ignore.
 */
+ (NSArray *)ignoredProperties;


/**---------------------------------------------------------------------------------------
 *  @name Getting & Querying Objects from the Default Realm
 *  ---------------------------------------------------------------------------------------
 */

/**
 Get all objects of this type from the default Realm.
 
 @return    An RLMArray of all objects of this type in the default Realm.
 */
+ (RLMArray *)allObjects;

/**
 Get objects matching the given predicate for this type from the default Realm.
 
 @param predicateFormat The predicate format string which can accept variable arguments.
 
 @return    An RLMArray of objects of the subclass type in the default Realm that match the given predicate
 */
+ (RLMArray *)objectsWhere:(NSString *)predicateFormat, ...;


/**
 Get objects matching the given predicate for this type from the default Realm.

 @param predicate   The predicate to filter the objects.

 @return    An RLMArray of objects of the subclass type in the default Realm that match the given predicate
 */
+ (RLMArray *)objectsWithPredicate:(NSPredicate *)predicate;


/**---------------------------------------------------------------------------------------
 *  @name Querying Specific Realms
 *  ---------------------------------------------------------------------------------------
 */

/**
 Get all objects of this type from the specified Realm.

 @param realm   The Realm instance to query.

 @return        An RLMArray of all objects of this type in the specified Realm.
 */
+ (RLMArray *)allObjectsInRealm:(RLMRealm *)realm;

/**
 Get objects matching the given predicate for this type from the specified Realm.

 @param predicateFormat The predicate format string which can accept variable arguments.
 @param realm           The Realm instance to query.

 @return    An RLMArray of objects of the subclass type in the specified Realm that match the given predicate
 */
+ (RLMArray *)objectsInRealm:(RLMRealm *)realm where:(NSString *)predicateFormat, ...;

/**
 Get objects matching the given predicate for this type from the specified Realm.

 @param predicate   The predicate to filter the objects.
 @param realm       The Realm instance to query.

 @return    An RLMArray of objects of the subclass type in the specified Realm that match the given predicate
 */
+ (RLMArray *)objectsInRealm:(RLMRealm *)realm withPredicate:(NSPredicate *)predicate;


#pragma mark -

//---------------------------------------------------------------------------------------
// @name Dynamic Accessors
//---------------------------------------------------------------------------------------
//
// Properties on RLMObjects can be accessed and set using keyed subscripting.
// ie. rlmObject[@"propertyName"] = object;
//     id object = rlmObject[@"propertyName"];
//

-(id)objectForKeyedSubscript:(NSString *)key;
-(void)setObject:(id)obj forKeyedSubscript:(NSString *)key;

#pragma mark -

/**---------------------------------------------------------------------------------------
 *  @name Serializing Objects to JSON
 *  ---------------------------------------------------------------------------------------
 */
/**
 Returns this object represented as a JSON string.
 
 @return    JSON string representation of this object.
 */
- (NSString *)JSONString;

@end

//---------------------------------------------------------------------------------------
// @name RLMArray Property Declaration
//---------------------------------------------------------------------------------------
//
// Properties on RLMObjects of type RLMArray must have an associated type. A type is associated
// with an RLMArray property by defining a protocol for the object type which the RLMArray will
// hold. To define an protocol for an object you can use the macro RLM_ARRAY_TYPE:
//
// ie. RLM_ARRAY_TYPE(ObjectType)
//
//     @property RLMArray<ObjectType> *arrayOfObjectTypes;
//
#define RLM_ARRAY_TYPE(RLM_OBJECT_SUBCLASS)\
@protocol RLM_OBJECT_SUBCLASS <NSObject>   \
@end
