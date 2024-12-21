//
//  XCUIElementAttributeName+FBHelper.m
//  WebDriverAgent
//
//  Created by vinay kumar on 21/12/24.
//  Copyright © 2024 Facebook. All rights reserved.
//

#import "XCUIElementAttributeName+FBHelper.h"

#define BROKEN_RECT CGRectMake(-1, -1, 0, 0)

@implementation XCUIElementAttributeName_FBHelper

+ (NSUInteger)elementType:(NSDictionary<XCUIElementAttributeName,id> *)dictionaryRepresentation {
  return [dictionaryRepresentation[XCUIElementAttributeNameElementType] unsignedIntegerValue];
}

+ (nullable NSString *)rawIdentifier:(nonnull NSDictionary *)dictionaryRepresentation {
  id rawIdentifier = dictionaryRepresentation[XCUIElementAttributeNameIdentifier];
  return [rawIdentifier isEqual:@""] ? nil : rawIdentifier;
}

+ (nullable NSString *)name:(nonnull NSDictionary *)dictionaryRepresentation {
  NSString *identifier = [self.class rawIdentifier:dictionaryRepresentation];
  if (nil != identifier && identifier.length != 0) {
    return identifier;
  }
  NSString *label = dictionaryRepresentation[XCUIElementAttributeNameLabel];
  return FBTransferEmptyStringToNil(label);
}

+ (nonnull NSString *)value:(nonnull NSDictionary *)dictionaryRepresentation {
  id value = dictionaryRepresentation[XCUIElementAttributeNameValue];
    NSUInteger elementType = [dictionaryRepresentation[XCUIElementAttributeNameElementType] unsignedIntegerValue]; // Cast once

    switch (elementType) {
      case XCUIElementTypeStaticText: {
        id label = dictionaryRepresentation[XCUIElementAttributeNameLabel];
        value = FBFirstNonEmptyValue(value, label);
        break;
      }
      case XCUIElementTypeButton: {
        NSNumber *isSelected = dictionaryRepresentation[XCUIElementAttributeNameSelected];
        value = FBFirstNonEmptyValue(value, isSelected);
        break;
      }
      case XCUIElementTypeSwitch: {
        value = @([value boolValue]);
        break;
      }
      case XCUIElementTypeTextView:
      case XCUIElementTypeTextField:
      case XCUIElementTypeSecureTextField: {
        NSString *placeholderValue = dictionaryRepresentation[XCUIElementAttributeNamePlaceholderValue];
        value = FBFirstNonEmptyValue(value, placeholderValue);
        break;
      }
      default:
        break;
    }

    value = FBTransferEmptyStringToNil(value);
    if (value) {
      value = [NSString stringWithFormat:@"%@", value];
    }
    return value;
}

+ (nullable NSString *)label:(NSDictionary<XCUIElementAttributeName,id> *)dictionaryRepresentation {
  NSString *label = dictionaryRepresentation[XCUIElementAttributeNameLabel];
  NSUInteger elementType = [dictionaryRepresentation[XCUIElementAttributeNameElementType] unsignedIntegerValue]; // Cast once
  if (elementType == XCUIElementTypeTextField || elementType == XCUIElementTypeSecureTextField) {
    return  label;
  }
  return FBTransferEmptyStringToNil(label);
}

+ (NSDictionary *)rect:(NSDictionary<XCUIElementAttributeName, id> *)dictionaryRepresentation {
  NSDictionary *frameValue = dictionaryRepresentation[XCUIElementAttributeNameFrame];
  if (![frameValue isKindOfClass:[NSDictionary class]]) {
    return @{};
  }
  
  NSNumber *xValue = frameValue[@"X"];
  NSNumber *yValue = frameValue[@"Y"];
  NSNumber *widthValue = frameValue[@"Width"];
  NSNumber *heightValue = frameValue[@"Height"];
  
  // Check if all values exist in the dictionary
  if (!xValue || !yValue || !widthValue || !heightValue) {
    // If any required value is missing, return a CGRectZero
    return @{};
  }
  
  // Create a CGRect from the values
  CGRect frame = CGRectMake([xValue doubleValue], [yValue doubleValue], [widthValue doubleValue], [heightValue doubleValue]);
  
  // Validate and handle broken frame dimensions
  if (isinf(frame.size.width) || isinf(frame.size.height) ||
      isinf(frame.origin.x) || isinf(frame.origin.y)) {
    frame = CGRectIntegral(BROKEN_RECT); // Replace with a valid rectangle
  } else {
    frame = CGRectIntegral(frame); // Ensure frame values are integers
  }
  
  return @{
    @"x": @(CGRectGetMinX(frame)),
    @"y": @(CGRectGetMinY(frame)),
    @"width": @(CGRectGetWidth(frame)),
    @"height": @(CGRectGetHeight(frame)),
  };
}

+ (BOOL)isEnabled:(NSDictionary<XCUIElementAttributeName,id> *)dictionaryRepresentation {
  return dictionaryRepresentation[XCUIElementAttributeNameEnabled];
}

+ (BOOL)isFocused:(NSDictionary<XCUIElementAttributeName,id> *)dictionaryRepresentation {
  return dictionaryRepresentation[XCUIElementAttributeNameHasFocus];
}


@end
