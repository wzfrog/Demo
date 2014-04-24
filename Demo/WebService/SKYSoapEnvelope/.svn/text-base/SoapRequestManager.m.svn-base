//
//  SoapRequestManager.m
//  SrtIOSFramework
//
//  Created by  on 12-5-8.
//  Copyright (c) 2012年 Rico. All rights reserved.
//

#import "SoapRequestManager.h"

@implementation SoapRequestManager
@synthesize result = _result;

//singleton
static SoapRequestManager *sharedInstance = nil;

- (id)init
{
    self = [super init];
    if (self)
    {
        _queue = [[ASINetworkQueue alloc] init];
        
        [_queue setMaxConcurrentOperationCount:3];
        [_queue setShouldCancelAllRequestsOnFailure:NO];
        
        [_queue setDelegate:self];
        [_queue setRequestDidFailSelector:@selector(requestFailed:)];
        [_queue setRequestDidFinishSelector:@selector(requestFinished:)];
        [_queue setQueueDidFinishSelector:@selector(queueFinished:)];
            
        [_queue go];
        
        
        myConnections = [[NSMutableDictionary alloc] init];
    }

    return self;
}

#pragma mark - Singleton Method

+ (SoapRequestManager *)sharedManager
{
    @synchronized(self)
    {
        if (!sharedInstance)
        {
            sharedInstance = [[self alloc] init];
        }
    }
    
    return sharedInstance;
}

+ (id)allocWithZone: (NSZone *)zone
{
    @synchronized(self)
    {
        NSAssert(sharedInstance == nil, @"SoapRequestManager is singleton, please call sharedManager");
        
        if (!sharedInstance)
        {
            sharedInstance = [super allocWithZone: zone];
            
            return sharedInstance;
        }
    }
    
    return nil;
}


#pragma mark - requestManager Method

- (void)spawnConnectionWithSoapRPCRequest:(SoapRPCRequest *)request delegate: (id<SoapConnectDelegate>)delegate
{
    soapConnection = [[SoapConnection alloc] initWithXMLRPCRequest:request delegate:delegate manager:self];
    
    NSString *identifier = [soapConnection soapIdentifier];
    
    [myConnections setObject:soapConnection forKey: identifier];
}


- (void)spawnConnectionWithHttpRPCRequest:(HttpRPCRequest *)request delegate:(id<SoapConnectDelegate>)delegate
{
    soapConnection = [[SoapConnection alloc] initWithHttpRPCRequest:request delegate:delegate manager:self];
    
    NSString *identifier = [soapConnection httpIdentifier];
    
    [myConnections setObject:soapConnection forKey:identifier];
}


- (id)response
{
    return _result;
}

- (void)addOperator:(NSOperation*)asioperator
{
    if ([asioperator isKindOfClass:[ASIHTTPRequest class]])
    {
        [_queue addOperation:asioperator];
    }

}

- (NSArray *)activeConnectionIdentifiers
{
    return [myConnections allKeys];
}

- (int)numberOfActiveConnections
{
    return [myConnections count];
}

- (void)queueFinished:(ASINetworkQueue *)queue
{
    ZNLog(@"SoapRequestManager:Queue finished");
}


- (void)requestFinished:(ASIHTTPRequest *)request
{
    //... Handle success
    ZNLog(@"SoapRequestManager:Request finished");
    
    NSString* identifity = [[request userInfo] objectForKey:@"identifity"];
    
    ZNLog(@"identifity in manager:%@",identifity);
    
    [myConnections removeObjectForKey: identifity];

}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError* error = [request error];
    ZNLog(@"SoapRequestManager:Request failed with error:%@",[error localizedDescription]);
    
    NSString* identifity = [[request userInfo]objectForKey:@"identifity"];
    [myConnections removeObjectForKey: identifity];
}

#pragma mark - SoapConnection Method

- (SoapConnection *)connectionForIdentifier: (NSString *)identifier
{
     return [myConnections objectForKey: identifier];
}

- (void)closeConnectionForIdentifier: (NSString *)identifier
{
    SoapConnection *selectedConnection = [self connectionForIdentifier: identifier];
    
    if (selectedConnection)
    {
        [selectedConnection cancel];
        
        [myConnections removeObjectForKey: identifier];
    }
}

- (void)closeConnections
{
    if ([_queue operationCount]>0)
    {
        [_queue cancelAllOperations];
    }
}



- (void)dealloc
{
    if (_queue)
    {
        if ([_queue requestsCount] > 0)
        {
            [_queue cancelAllOperations];
        }
        
        [_queue release];
    }
    
    [myConnections release];
    [soapConnection release];
    
    [super dealloc];
}

@end
