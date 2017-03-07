//
//  sha3.h
//  NACrypto
//
//  Created by Gabriel on 3/6/17.
//  Copyright © 2017 Gabriel Handford. All rights reserved.
//

#ifndef sha3_h
#define sha3_h

/* The following state definition should normally be in a separate
 * header file
 */

/* 'Words' here refers to uint64_t */
#define SHA3_KECCAK_SPONGE_WORDS \
(((1600)/8/*bits to byte*/)/sizeof(uint64_t))
typedef struct sha3_context_ {
  uint64_t saved;             /* the portion of the input message that we
                               * didn't consume yet */
  union {                     /* Keccak's state */
    uint64_t s[SHA3_KECCAK_SPONGE_WORDS];
    uint8_t sb[SHA3_KECCAK_SPONGE_WORDS * 8];
  };
  unsigned byteIndex;         /* 0..7--the next byte after the set one
                               * (starts from 0; 0--none are buffered) */
  unsigned wordIndex;         /* 0..24--the next word to integrate input
                               * (starts from 0) */
  unsigned capacityWords;     /* the double size of the hash output in
                               * words (e.g. 16 for Keccak 512) */
} sha3_context;

#ifndef SHA3_ROTL64
#define SHA3_ROTL64(x, y) \
(((x) << (y)) | ((x) >> ((sizeof(uint64_t)*8) - (y))))
#endif

void
sha3_Init256(void *priv);

void
sha3_Init384(void *priv);

void
sha3_Init512(void *priv);

void
sha3_Update(void *priv, void const *bufIn, size_t len);

void const *
sha3_Finalize(void *priv);

#endif /* sha3_h */
