//
//  NASHA3.m
//  NACrypto
//
//  Created by Gabriel on 3/6/17.
//  Copyright © 2017 Gabriel Handford. All rights reserved.
//

#import "NASHA3.h"
#import "sha3.h"
#import "NAKeccak.h"

@implementation NASHA3

+ (NSData *)SHA3ForData:(NSData *)data algorithm:(NASHA3Algorithm)algorithm {
  return [self SHA3ForDatas:@[data] algorithm:algorithm];
}

+ (NSData *)SHA3ForDatas:(NSArray *)datas algorithm:(NASHA3Algorithm)algorithm {
  sha3_context c;
  const uint8_t *hash;
  NSUInteger length;

  switch (algorithm) {
    case NASHA3Algorithm_256:
      sha3_Init256(&c);
      length = 32;
      break;
    case NASHA3Algorithm_384:
      sha3_Init384(&c);
      length = 48;
      break;
    case NASHA3Algorithm_512:
      sha3_Init512(&c);
      length = 64;
      break;

    case NASHA3Algorithm_Keccak_256:
      return [NAKeccak SHA3ForDatas:datas digestBitLength:256];
    case NASHA3Algorithm_Keccak_384:
      return [NAKeccak SHA3ForDatas:datas digestBitLength:384];
    case NASHA3Algorithm_Keccak_512:
      return [NAKeccak SHA3ForDatas:datas digestBitLength:512];
  }

  for (NSData *data in datas) {
    sha3_Update(&c, [data bytes], [data length]);
  }
  hash = sha3_Finalize(&c);
  return [NSData dataWithBytes:hash length:length];
}

@end
