//
//  SoapSerialize.m
//  SrtIOSFramework
//
//  Created by  on 12-4-23.
//  Copyright (c) 2012年 Rico. All rights reserved.
//

#import "SoapSerialize.h"
#import "NSData+Base64.h"

#import "GDataXMLNode.h"
#import "Session.h"

@interface SoapSerialize()

@property (nonatomic, retain, readwrite) NSString* method;
@property (nonatomic, retain, readwrite) NSString* nameSpace;
@property (nonatomic, retain, readwrite) NSArray* params;

- (GDataXMLElement *)valueTag: (NSString *)tag value: (NSString *)value;

- (GDataXMLElement *)encodeObject: (id)object withTag:(NSString*)paramTag;

- (GDataXMLElement *)encodeBoolean: (CFBooleanRef)boolean withTag:(NSString*)paramTag;

- (GDataXMLElement *)encodeNumber: (NSNumber *)number withTag:(NSString*)paramTag;

- (GDataXMLElement *)encodeString: (NSString *)string withTag:(NSString*)paramTag;

- (GDataXMLElement *)encodeDate: (NSDate *)date withTag:(NSString*)paramTag;

- (GDataXMLElement *)encodeData: (NSData *)data withTag:(NSString*)paramTag;

@end

@implementation SoapSerialize
@synthesize method = _method;
@synthesize nameSpace = _nameSpace;
@synthesize params = _params;

- (id)init
{
    self = [super init];
    if (self)
    {
        self.method = [NSString string];
        self.params = [NSArray array];
        self.nameSpace = [NSString string];
    }
    
    return self;
}

#pragma mark - iSerialize Method
- (NSString*)serialize
{
    GDataXMLElement *envelope = [GDataXMLElement elementWithName:@"SOAP-ENV:Envelope"];  
    
    GDataXMLNode *soapNS = [GDataXMLNode namespaceWithName:@"SOAP-ENV" stringValue:@"http://schemas.xmlsoap.org/soap/envelope/"];
    
    GDataXMLNode *xsiNS = [GDataXMLNode namespaceWithName:@"xsi" stringValue:@"http://www.w3.org/2001/XMLSchema-instance"];
    
    GDataXMLNode *xsdNS = [GDataXMLNode namespaceWithName:@"xsd" stringValue:@"http://www.w3.org/2001/XMLSchema"];  
    
    NSArray *namespaces = [NSArray arrayWithObjects:xsiNS, xsdNS, soapNS, nil];
    
    [envelope setNamespaces:namespaces];  
    
    GDataXMLElement *header = [GDataXMLElement elementWithName:@"SOAP-ENV:Header"];
        
    GDataXMLElement *sessionTag = [GDataXMLElement elementWithName:@"sys_session" stringValue:[Session sharedSession].aSession];
        
    [header addChild:sessionTag];
    [envelope addChild:header];
    
    //SOAP Body  
    GDataXMLElement *body = [GDataXMLElement elementWithName:@"SOAP-ENV:Body"];  
    
    GDataXMLNode *methodNode = [GDataXMLNode namespaceWithName:@"" stringValue:_nameSpace]; 
    
    GDataXMLElement *methodBody = [GDataXMLElement elementWithName:_method];
    
    [methodBody setNamespaces:[NSArray arrayWithObject:methodNode]];
    
    //SOAP Value  
    if (_params)
    {
        NSEnumerator *enumerator = [_params objectEnumerator];
        id parameter = nil;
        
        int i = 0;
        while ((parameter = [enumerator nextObject]))
        {
            [methodBody addChild:[self encodeObject: parameter withTag:[NSString stringWithFormat:@"arg%d",i]]];
            i++;
        }
    }
    
    [body addChild:methodBody];
    [envelope addChild:body];  
    
    //SOAP Document  
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithRootElement:envelope];
    
    [doc setCharacterEncoding:@"utf-8"];
    
    NSString* encodeString = [NSString stringWithCString:(const char *)[[doc XMLData] bytes] encoding:NSUTF8StringEncoding];
    
    [doc release];
    
    return encodeString;
}


- (void)setMethod: (NSString *)method inNameSpace:(NSString*)methodNS withParameters: (NSArray *)parameters
{
    self.method = method;
    self.nameSpace = methodNS;
    self.params = parameters;
}


#pragma mark - private method

- (GDataXMLElement *)valueTag: (NSString *)tag value: (NSString *)value
{
    GDataXMLElement *elenment = [GDataXMLElement elementWithName:@"tag" stringValue:value];
    return elenment;
}

- (GDataXMLElement *)encodeObject: (id)object withTag:(NSString*)paramTag
{
    if (!object)
    {
        return nil;
    }
    
    if (((CFBooleanRef)object == kCFBooleanTrue) || ((CFBooleanRef)object == kCFBooleanFalse))
    {
        return [self encodeBoolean: (CFBooleanRef)object withTag:paramTag];
    }
    else if ([object isKindOfClass: [NSNumber class]])
    {
        return [self encodeNumber: object withTag:paramTag];
    }
    else if ([object isKindOfClass: [NSString class]])
    {
        return [self encodeString: object withTag:paramTag];
    }
    else if ([object isKindOfClass: [NSDate class]])
    {
        return [self encodeDate: object withTag:paramTag];
    }
    else if ([object isKindOfClass: [NSData class]])
    {
        return [self encodeData: object withTag:paramTag];
    }
    else
    {
        return nil;
    }
}

- (GDataXMLElement *)encodeBoolean: (CFBooleanRef)boolean withTag:(NSString*)paramTag
{
    if (boolean == kCFBooleanTrue)
    {
        return [GDataXMLElement elementWithName:paramTag stringValue:@"1"];
    }
    else
    {
        return [GDataXMLElement elementWithName:paramTag stringValue:@"0"];
    }
}

- (GDataXMLElement *)encodeNumber: (NSNumber *)number withTag:(NSString*)paramTag
{
    return [GDataXMLElement elementWithName:paramTag stringValue:[number stringValue]];
}

- (GDataXMLElement *)encodeString: (NSString *)string withTag:(NSString*)paramTag
{
    return [GDataXMLElement elementWithName:paramTag stringValue:string];
}

- (GDataXMLElement *)encodeDate: (NSDate *)date withTag:(NSString*)paramTag
{
    unsigned components = kCFCalendarUnitYear | kCFCalendarUnitMonth | kCFCalendarUnitDay | kCFCalendarUnitHour | kCFCalendarUnitMinute | kCFCalendarUnitSecond;
    
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components: components fromDate: date];
    
    NSString *buffer = [NSString stringWithFormat: @"%.4d%.2d%.2dT%.2d:%.2d:%.2d", [dateComponents year], [dateComponents month], [dateComponents day], [dateComponents hour], [dateComponents minute], [dateComponents second], nil];
    
    return [GDataXMLElement elementWithName:paramTag stringValue:buffer];
}

- (GDataXMLElement *)encodeData: (NSData *)data withTag:(NSString*)paramTag
{
    return [GDataXMLElement elementWithName:paramTag stringValue:[data base64EncodedString]];
}

-(void)dealloc
{
    [super dealloc];
    [_method release];
    [_nameSpace release];
    [_params release];
}

@end
