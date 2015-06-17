//
//  NACrypto
//
//  Created by Gabriel on 1/16/14.
//  Copyright (c) 2015 Gabriel Handford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>

@import NACrypto;

@interface NAKeychainTest : XCTestCase
@end

@implementation NAKeychainTest

- (void)_testSymmetricKey {
  NSData *keyExisting = [NAKeychain symmetricKeyWithApplicationLabel:@"NACrypto"];
  XCTAssertNil(keyExisting);
  
  NSData *key = [NASecRandom randomData:32 error:nil];
  XCTAssertTrue([NAKeychain addSymmetricKey:key applicationLabel:@"NACrypto" tag:nil label:nil]);
  
  NSData *keyOut = [NAKeychain symmetricKeyWithApplicationLabel:@"NACrypto"];
  XCTAssertEqualObjects(key, keyOut);
}

@end
