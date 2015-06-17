//
//  NATwoFish.h
//  NACrypto
//
//  Created by Gabriel on 6/20/14.
//  Copyright (c) 2014 Gabriel Handford. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NATwoFish : NSObject

- (NSData *)encrypt:(NSData *)data nonce:(NSData *)nonce key:(NSData *)key error:(NSError **)error;

- (NSData *)decrypt:(NSData *)data nonce:(NSData *)nonce key:(NSData *)key error:(NSError **)error;

@end
