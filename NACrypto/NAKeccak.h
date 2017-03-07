//
//  NAKeccak.h
//  NACrypto
//
//  Created by Gabriel on 6/23/14.
//  Copyright (c) 2014 Gabriel Handford. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NAKeccak : NSObject

+ (NSData *)SHA3ForData:(NSData *)data digestBitLength:(NSUInteger)digestBitLength;

+ (NSData *)SHA3ForDatas:(NSArray *)datas digestBitLength:(NSUInteger)digestBitLength;

@end
