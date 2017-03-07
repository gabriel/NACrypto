//
//  NACrypto
//
//  Created by Gabriel on 1/16/14.
//  Copyright (c) 2015 Gabriel Handford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>

@import NACrypto;

@interface NAKeccakTest : XCTestCase
@end

@implementation NAKeccakTest

- (void)test {
  NSData *data = [@"abc" dataUsingEncoding:NSUTF8StringEncoding];
 
  NSData *SHA3_384 = [NAKeccak SHA3ForData:data digestBitLength:384];
  NSData *expected384 = [@"f7df1165f033337be098e7d288ad6a2f74409d7a60b49c36642218de161b1f99f8c681e4afaf31a34db29fb763e3c28e" na_dataFromHexString];
  XCTAssertEqualObjects(SHA3_384, expected384);
  
  NSData *SHA3 = [NAKeccak SHA3ForData:data digestBitLength:512];
  NSData *expected = [@"18587dc2ea106b9a1563e32b3312421ca164c7f1f07bc922a9c83d77cea3a1e5d0c69910739025372dc14ac9642629379540c17e2a65b19d77aa511a9d00bb96" na_dataFromHexString];
  XCTAssertEqualObjects(SHA3, expected);
}


@end
