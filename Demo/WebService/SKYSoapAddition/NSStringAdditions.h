#import <Foundation/Foundation.h>

@interface NSString (NSStringAdditions)

+ (NSString *)stringByGeneratingUUID;

#pragma mark -

- (NSString *)unescapedString;

- (NSString *)escapedString;

- (NSString *)md5HexDigest;

@end
