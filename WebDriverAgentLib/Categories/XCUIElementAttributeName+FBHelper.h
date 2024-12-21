//
//  XCUIElementAttributeName+FBHelper.h
//  WebDriverAgent
//
//  Created by vinay kumar on 21/12/24.
//  Copyright © 2024 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FBXCodeCompatibility.h"

NS_ASSUME_NONNULL_BEGIN

@interface XCUIElementAttributeName_FBHelper : NSObject
+ (NSUInteger) elementType:(NSDictionary<XCUIElementAttributeName, id> *)dictionaryRepresentation;
+ (nullable NSString *) rawIdentifier:(NSDictionary<XCUIElementAttributeName, id> *)dictionaryRepresentation;
+ (nullable NSString *) name:(NSDictionary<XCUIElementAttributeName, id> *)dictionaryRepresentation;
+ (NSString *) value:(NSDictionary<XCUIElementAttributeName, id> *)dictionaryRepresentation;
+ (nullable NSString *) label:(NSDictionary<XCUIElementAttributeName, id> *)dictionaryRepresentation;
+ (NSDictionary *) rect:(NSDictionary<XCUIElementAttributeName, id> *)dictionaryRepresentation;
+ (BOOL) isEnabled:(NSDictionary<XCUIElementAttributeName, id> *)dictionaryRepresentation;
+ (BOOL) isFocused:(NSDictionary<XCUIElementAttributeName, id> *)dictionaryRepresentation;
@end

NS_ASSUME_NONNULL_END
