//
//  SoapEventBasedParser.h
//  SrtIOSFramework
//
//  Created by  on 12-5-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GDataXMLNode.h"

@interface SoapEventBasedParser : NSObject
{
    GDataXMLDocument *_doc;
    
    Boolean _isFault;
}

- (id)initWithData: (NSData *)data;

#pragma mark -

- (id)parse;

#pragma mark -

- (BOOL)isFault;

@end
