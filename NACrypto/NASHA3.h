//
//  NASHA3.h
//  NACrypto
//
//  Created by Gabriel on 3/6/17.
//  Copyright © 2017 Gabriel Handford. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM (NSUInteger, NASHA3Algorithm) {
  NASHA3Algorithm_256 = 2,
  NASHA3Algorithm_384 = 3,
  NASHA3Algorithm_512 = 4,

  NASHA3Algorithm_Keccak_256 = 10,
  NASHA3Algorithm_Keccak_384 = 11,
  NASHA3Algorithm_Keccak_512 = 12,
};

@interface NASHA3 : NSObject

+ (NSData *)SHA3ForData:(NSData *)data algorithm:(NASHA3Algorithm)algorithm;

+ (NSData *)SHA3ForDatas:(NSArray *)datas algorithm:(NASHA3Algorithm)algorithm;

@end
