//
//  SoapSerialize.h
//  SrtIOSFramework
//
//  Created by  on 12-4-23.
//  Copyright (c) 2012年 Rico. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iSerialize.h"



@interface SoapSerialize : NSObject <iSerialize>

@property (nonatomic, retain, readonly) NSString* method;
@property (nonatomic, retain, readonly) NSString* nameSpace;
@property (nonatomic, retain, readonly) NSArray*  params;


@end


