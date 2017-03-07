//
//  NASHA3Test.m
//  NACrypto
//
//  Created by Gabriel on 3/6/17.
//  Copyright © 2017 Gabriel Handford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>

@import NACrypto;

@interface NASHA3Test : XCTestCase
@end

@implementation NASHA3Test

- (void)test {
  NSData *data = [@"abc" dataUsingEncoding:NSUTF8StringEncoding];

  NSData *SHA3_384 = [NASHA3 SHA3ForData:data algorithm:NASHA3Algorithm_384];
  NSData *expected384 = [@"ec01498288516fc926459f58e2c6ad8df9b473cb0fc08c2596da7cf0e49be4b298d88cea927ac7f539f1edf228376d25" na_dataFromHexString];
  XCTAssertEqualObjects(SHA3_384, expected384);

  NSData *SHA3 = [NASHA3 SHA3ForData:data algorithm:NASHA3Algorithm_512];
  NSData *expected = [@"b751850b1a57168a5693cd924b6b096e08f621827444f70d884f5d0240d2712e10e116e9192af3c91a7ec57647e3934057340b4cf408d5a56592f8274eec53f0" na_dataFromHexString];
  XCTAssertEqualObjects(SHA3, expected);
}


@end
