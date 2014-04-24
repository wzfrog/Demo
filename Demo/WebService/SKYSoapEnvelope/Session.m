//
//  Session.m
//  SrtIOSFramework
//
//  Created by  on 12-5-7.
//  Copyright (c) 2012年 Rico. All rights reserved.
//

#import "Session.h"

@implementation Session

@synthesize aSession = _aSession;

static Session* _sharedSession = nil;

+ (Session*)sharedSession
{
    @synchronized([Session class])
    {
        if (!_sharedSession)
        {
            _sharedSession = [[self alloc] init];
        }
        return _sharedSession;
    }
    
    return nil;
}


#pragma mark -

+ (id)allocWithZone: (NSZone *)zone
{
    @synchronized(self)
    {
        NSAssert(_sharedSession == nil, @"Attempted to allocate a second instance of a singleton - Session.");
        if (!_sharedSession)
        {
            _sharedSession = [super allocWithZone: zone];
            
            return _sharedSession;
        }
    }
    
    return nil;
}


- (id)init
{
    self = [super init];  
    if (self != nil)
    {
        // initialize stuff here 
        self.aSession = [NSString string];
    }  
    
    return self;  
}

-(void)dealloc
{
    [_sharedSession release];
    [super dealloc];
}

@end
