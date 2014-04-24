#import "NSStringAdditions.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (NSStringAdditions)

+ (NSString *)stringByGeneratingUUID
{
    CFUUIDRef UUIDReference = CFUUIDCreate(nil);
    CFStringRef temporaryUUIDString = CFUUIDCreateString(nil, UUIDReference);
    
    CFRelease(UUIDReference);
    
    return [NSMakeCollectable(temporaryUUIDString) autorelease];
}

#pragma mark -

- (NSString *)unescapedString
{
    NSMutableString *string = [NSMutableString stringWithString: self];
    
    [string replaceOccurrencesOfString: @"&amp;"  withString: @"&" options: NSLiteralSearch range: NSMakeRange(0, [string length])];
    [string replaceOccurrencesOfString: @"&quot;" withString: @"\"" options: NSLiteralSearch range: NSMakeRange(0, [string length])];
    [string replaceOccurrencesOfString: @"&#x27;" withString: @"'" options: NSLiteralSearch range: NSMakeRange(0, [string length])];
    [string replaceOccurrencesOfString: @"&#x39;" withString: @"'" options: NSLiteralSearch range: NSMakeRange(0, [string length])];
    [string replaceOccurrencesOfString: @"&#x92;" withString: @"'" options: NSLiteralSearch range: NSMakeRange(0, [string length])];
    [string replaceOccurrencesOfString: @"&#x96;" withString: @"'" options: NSLiteralSearch range: NSMakeRange(0, [string length])];
    [string replaceOccurrencesOfString: @"&gt;" withString: @">" options: NSLiteralSearch range: NSMakeRange(0, [string length])];
    [string replaceOccurrencesOfString: @"&lt;" withString: @"<" options: NSLiteralSearch range: NSMakeRange(0, [string length])];
    
    return [NSString stringWithString: string];
}

- (NSString *)escapedString
{
    NSMutableString *string = [NSMutableString stringWithString: self];
    
    [string replaceOccurrencesOfString: @"&"  withString: @"&amp;" options: NSLiteralSearch range: NSMakeRange(0, [string length])];
    [string replaceOccurrencesOfString: @"\"" withString: @"&quot;" options: NSLiteralSearch range: NSMakeRange(0, [string length])];
    [string replaceOccurrencesOfString: @"'"  withString: @"&#x27;" options: NSLiteralSearch range: NSMakeRange(0, [string length])];
    [string replaceOccurrencesOfString: @">"  withString: @"&gt;" options: NSLiteralSearch range: NSMakeRange(0, [string length])];
    [string replaceOccurrencesOfString: @"<"  withString: @"&lt;" options: NSLiteralSearch range: NSMakeRange(0, [string length])];
    
    return [NSString stringWithString: string];
}

- (NSString *)md5HexDigest
{
    const char *original_str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}

@end
