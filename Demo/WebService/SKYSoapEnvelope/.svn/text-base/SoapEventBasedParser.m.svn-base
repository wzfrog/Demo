//
//  SoapEventBasedParser.m
//  SrtIOSFramework
//
//  Created by  on 12-5-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SoapEventBasedParser.h"

@interface SoapEventBasedParser (SoapEventBasedParserPrivate)

-(id)parseIntElement:(GDataXMLElement*)intElement;

@end

@implementation SoapEventBasedParser

- (id)initWithData:(NSData *)data
{
    if (!data)
    {
        return nil;
    }
    
    self = [super init];
    if (self)
    {
        _isFault = NO;
        
        NSError *error;
        
        
        _doc = [[GDataXMLDocument alloc] initWithData:data options:0 error:&error];

        
        if (_doc == nil)
        {
            return nil;
        }
        if (error)
        {
            _isFault = YES;
        }
    }
    
    return self;

}

#pragma mark -

- (id)parse
{
    if (_isFault)
    {
        return nil;
    }

    NSError *error;
    NSArray *xpathArray = [_doc nodesForXPath:@"/SOAP-ENV:Envelope/SOAP-ENV:Body/*" error:&error];

    GDataXMLElement *responseElement = [xpathArray objectAtIndex:0];
    
    if ([responseElement childCount] == 1)
    {
        GDataXMLElement *returnElement = [[responseElement children] objectAtIndex:0];
        
        GDataXMLNode *returnNode = [returnElement attributeForName:@"xsi:type"];
        
        if ([[returnNode stringValue] isEqualToString:@"xsd:int"])
        {
            return [self parseIntElement:returnElement];
        }
        
        else if([[returnNode stringValue] isEqualToString:@"xsd:string"])
        {
            return [self parseStringElement:returnElement];
        }
        
    }
    
    ZNLog(@"pause!");
    
    return nil;
}

#pragma mark -

- (BOOL)isFault
{
    return _isFault;
}


#pragma mark - private 
//int 类型
-(id)parseIntElement:(GDataXMLElement*)intElement
{
    NSString* result = [intElement stringValue];
    NSNumber* number = [NSNumber numberWithInt:[result intValue]];
    
    return number;
}

//string 类型，为JSON格式
- (id)parseStringElement:(GDataXMLElement *)stringElement
{
    NSString *result = [stringElement stringValue];
    return result;
}


-(void)dealloc
{
    [_doc release];
    [super dealloc];
}

@end
