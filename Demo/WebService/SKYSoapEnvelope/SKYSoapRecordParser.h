//
//  SoapRecord.h
//  SkyIOSDemo
//
//  Created by George on 12/5/13.
//  Copyright (c) 2013 Zoro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SKYSoapConfig.h"

@interface SKYSoapRecordParser : NSObject

#pragma mark - Singleton
+ (SKYSoapRecordParser *)sharedRecordParser;

- (NSMutableArray *)recordParser:(id)object withSoapType:(enum RequestService)type;

@end
