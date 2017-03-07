//
//  NAHMAC.h
//  NACL
//
//  Created by Gabriel Handford on 1/16/14.
//  Copyright (c) 2014 Gabriel Handford. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM (NSUInteger, NAHMACAlgorithm) {
  NAHMACAlgorithmSHA1,
  NAHMACAlgorithmSHA2_224,
  NAHMACAlgorithmSHA2_256,
  NAHMACAlgorithmSHA2_384,
  NAHMACAlgorithmSHA2_512,

  // Keccak
  NAHMACAlgorithmKeccak_256,
  NAHMACAlgorithmKeccak_384,
  NAHMACAlgorithmKeccak_512,

  // SHA3 (finalized)
  NAHMACAlgorithmSHA3F_256,
  NAHMACAlgorithmSHA3F_384,
  NAHMACAlgorithmSHA3F_512,
};

@interface NAHMAC : NSObject

@property NAHMACAlgorithm algorithm;

- (instancetype)initWithAlgorithm:(NAHMACAlgorithm)algorithm;

- (NSData *)HMACForKey:(NSData *)key data:(NSData *)data;

+ (NSData *)HMACForKey:(NSData *)key data:(NSData *)data algorithm:(NAHMACAlgorithm)algorithm;

@end
