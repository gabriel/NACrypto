//
//  NASecRandom.h
//
//  Created by Gabriel Handford on 1/16/14.
//  Copyright (c) 2014 Gabriel Handford. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NASecRandom : NSObject

/*!
 Generate random data.
 The source code of SecRandomCopyBytes() is located at
 http://opensource.apple.com/source/Security/Security-55179.11/sec/Security/SecFramework.c

 @param len Number of random bytes to generate
 @result NSData of length bytes, or nil if an error occurred
 */
+ (NSData *)randomData:(size_t)numBytes error:(NSError **)error;

/*!
 Generate random base64 string.
 */
+ (NSString *)randomBase64String:(size_t)length error:(NSError **)error;

@end
