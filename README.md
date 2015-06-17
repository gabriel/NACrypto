NACrypto
=========

You should be using [NAChloride](https://github.com/gabriel/NAChloride) (libsodium/NaCl) instead. This is for advanced crypto only.

The following use Apple's CommonCrypto framework:

* HMAC: *SHA1*, *SHA2*
* Digest: *SHA2*
* AES (256-CTR)

The following are implemented from included reference C libraries:

* HMAC: *SHA3/Keccak*
* Digest: *SHA3/Keccak*
* TwoFish (CTR)

# Podfile

```ruby
pod "NACrypto"
```

# HMAC (SHA1, SHA2, SHA3)

```objc
NSData *mac1 = [NAHMAC HMACForKey:key data:data algorithm:NAHMACAlgorithmSHA2_512];
NSData *mac2 = [NAHMAC HMACForKey:key data:data algorithm:NAHMACAlgorithmSHA3_512];
```

# AES (256-CTR)

```objc
// Nonce should be 16 bytes
// Key should be 32 bytes
NAAES *AES = [[NAAES alloc] initWithAlgorithm:NAAESAlgorithm256CTR];
NSData *encrypted = [AES encrypt:message nonce:nonce key:key error:&error];
```

# TwoFish (CTR)

```objc
// Nonce should be 16 bytes
// Key should be 32 bytes
NATwoFish *twoFish = [[NATwoFish alloc] init];
NSData *encrypted = [twoFish encrypt:message nonce:nonce key:key error:&error];
```

# Digest (SHA2, SHA3)

```objc
NSData *digest1 = [NADigest digestForData:data algorithm:NADigestAlgorithmSHA2_256];
NSData *digest2 = [NADigest digestForData:data algorithm:NADigestAlgorithmSHA3_512];

// Directly use SHA3
NSData *sha = [NASHA3 SHA3ForData:data digestBitLength:512];
```

# Keychain Utils

```objc
NSData *key = [NASecRandom randomData:32 error:&error];
[NAKeychain addSymmetricKey:key applicationLabel:@"NACrypto" tag:nil label:nil];
NSData *keyOut = [NAKeychain symmetricKeyWithApplicationLabel:@"NACrypto"];
```

# NSData Utils
```objc
NSData *data = [@"deadbeef" na_dataFromHexString];
[data na_hexString]; // @"deadbeef";
```
