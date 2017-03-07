//
//  NAHMAC.m
//  NACL
//
//  Created by Gabriel Handford on 1/16/14.
//  Copyright (c) 2014 Gabriel Handford. All rights reserved.
//

#import "NAHMAC.h"

#include <CommonCrypto/CommonHMAC.h>
#import "NANSData+Utils.h"
#import "NANSString+Utils.h"
#import "NASHA3.h"

@implementation NAHMAC

- (instancetype)initWithAlgorithm:(NAHMACAlgorithm)algorithm {
  if ((self = [super init])) {
    _algorithm = algorithm;
  }
  return self;
}

- (NSData *)HMACForKey:(NSData *)key data:(NSData *)data {
  return [NAHMAC HMACForKey:key data:data algorithm:_algorithm];
}

+ (NSData *)HMACForKey:(NSData *)key data:(NSData *)data algorithm:(NAHMACAlgorithm)algorithm {
  NSParameterAssert(key);
  
  switch (algorithm) {
    case NAHMACAlgorithmSHA1:
    case NAHMACAlgorithmSHA2_224:
    case NAHMACAlgorithmSHA2_256:
    case NAHMACAlgorithmSHA2_384:
    case NAHMACAlgorithmSHA2_512:
      return [self _HMACSHAForKey:key data:data algorithm:algorithm];

    case NAHMACAlgorithmKeccak_256:
    case NAHMACAlgorithmKeccak_384:
    case NAHMACAlgorithmKeccak_512:
    case NAHMACAlgorithmSHA3F_256:
    case NAHMACAlgorithmSHA3F_384:
    case NAHMACAlgorithmSHA3F_512:
      return [self _HMACSHA3ForKey:key data:data algorithm:algorithm];


  }
}

+ (NSData *)_HMACSHAForKey:(NSData *)key data:(NSData *)data algorithm:(NAHMACAlgorithm)algorithm {
  CCHmacAlgorithm ccAlgorithm;
  NSUInteger dataLength;
  switch (algorithm) {
    case NAHMACAlgorithmSHA1: ccAlgorithm = kCCHmacAlgSHA1; dataLength = CC_SHA1_DIGEST_LENGTH; break;
    case NAHMACAlgorithmSHA2_224: ccAlgorithm = kCCHmacAlgSHA224; dataLength = CC_SHA224_DIGEST_LENGTH; break;
    case NAHMACAlgorithmSHA2_256: ccAlgorithm = kCCHmacAlgSHA256; dataLength = CC_SHA256_DIGEST_LENGTH; break;
    case NAHMACAlgorithmSHA2_384: ccAlgorithm = kCCHmacAlgSHA384; dataLength = CC_SHA384_DIGEST_LENGTH; break;
    case NAHMACAlgorithmSHA2_512: ccAlgorithm = kCCHmacAlgSHA512; dataLength = CC_SHA512_DIGEST_LENGTH; break;
    default:
      NSAssert(NO, @"Unsupported algorithm");
      return nil;
  }
  
  CCHmacContext ctx;
  CCHmacInit(&ctx, ccAlgorithm, [key bytes], [key length]);
  
  CCHmacUpdate(&ctx, [data bytes], [data length]);
  
  NSMutableData *macOut = [NSMutableData dataWithLength:dataLength];
  CCHmacFinal(&ctx, [macOut mutableBytes]);
  return macOut;
}

+ (NSData *)_HMACSHA3ForKey:(NSData *)key data:(NSData *)data algorithm:(NAHMACAlgorithm)algorithm {
  NSUInteger blockLength = 72;
  NSUInteger keyLength = [key length];
  
  NASHA3Algorithm sha3Algorithm;
  switch (algorithm) {
    case NAHMACAlgorithmSHA3F_256: sha3Algorithm = NASHA3Algorithm_256; break;
    case NAHMACAlgorithmSHA3F_384: sha3Algorithm = NASHA3Algorithm_384; break;
    case NAHMACAlgorithmSHA3F_512: sha3Algorithm = NASHA3Algorithm_512; break;
    case NAHMACAlgorithmKeccak_256: sha3Algorithm = NASHA3Algorithm_Keccak_256; break;
    case NAHMACAlgorithmKeccak_384: sha3Algorithm = NASHA3Algorithm_Keccak_384; break;
    case NAHMACAlgorithmKeccak_512: sha3Algorithm = NASHA3Algorithm_Keccak_512; break;
      
    default:
      NSAssert(NO, @"Unsupported algorithm");
      return nil;
  }
  
  //
  // Used this as a reference:
  // http://www.opensource.apple.com/source/CommonCrypto/CommonCrypto-55010/Source/API/CommonHMAC.c
  //
  
  uint8_t *keyP;
  
  if (keyLength > blockLength) {
    key = [NASHA3 SHA3ForData:key algorithm:sha3Algorithm];
    keyLength = [key length];
  }
  
  NSMutableData *keyIn = [NSMutableData dataWithLength:blockLength];
  uint8_t *k_ipad = [keyIn mutableBytes];
  NSMutableData *keyOut = [NSMutableData dataWithLength:blockLength];
  uint8_t *k_opad = [keyOut mutableBytes];
  
  keyP = (uint8_t *)[key bytes];
  /* Copy the key into k_ipad and k_opad while doing the XOR. */
  for (uint32_t byte = 0; byte < keyLength; byte++) {
    k_ipad[byte] = keyP[byte] ^ 0x36;
    k_opad[byte] = keyP[byte] ^ 0x5c;
  }
  /* Fill the remainder of k_ipad and k_opad with 0 XORed with the appropriate value. */
  if (keyLength < blockLength) {
    memset(k_ipad + keyLength, 0x36, blockLength - keyLength);
    memset(k_opad + keyLength, 0x5c, blockLength - keyLength);
  }
  
  NSData *macOut = [NASHA3 SHA3ForDatas:@[keyIn, data] algorithm:sha3Algorithm];
  
  /* Perform outer digest */
  return [NASHA3 SHA3ForDatas:@[keyOut, macOut] algorithm:sha3Algorithm];
}

@end
