//
//  Session.h
//  SrtIOSFramework
//
//  Created by  on 12-5-7.
//  Copyright (c) 2012年 Rico. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Session : NSObject

@property (nonatomic, retain) NSString* aSession;

+ (Session*)sharedSession;

@end
