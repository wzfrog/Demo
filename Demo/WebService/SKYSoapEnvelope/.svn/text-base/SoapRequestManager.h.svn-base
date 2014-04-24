//
//  SoapRequestManager.h
//  SrtIOSFramework
//
//  Created by  on 12-5-8.
//  Copyright (c) 2012年 Rico. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASINetworkQueue.h"
#import "SoapRPCRequest.h"
#import "HttpRPCRequest.h"
#import "SoapConnection.h"

@interface SoapRequestManager : NSObject
{
    ASINetworkQueue *_queue;
    NSMutableDictionary *myConnections;
    SoapConnection *soapConnection;
}

@property(nonatomic,retain) id result;

#pragma mark - singleton Method

+ (SoapRequestManager *)sharedManager;


#pragma mark - requestManager Method

- (void)spawnConnectionWithSoapRPCRequest:(SoapRPCRequest *)request delegate:(id<SoapConnectDelegate>)delegate;

- (void)spawnConnectionWithHttpRPCRequest:(HttpRPCRequest *)request delegate:(id<SoapConnectDelegate>)delegate;

- (void)addOperator:(NSOperation*)asioperator;

- (NSArray *)activeConnectionIdentifiers;

- (int)numberOfActiveConnections;

- (id)response;

#pragma mark - SoapConnection Method

- (SoapConnection *)connectionForIdentifier: (NSString *)identifier;

- (void)closeConnectionForIdentifier: (NSString *)identifier;

- (void)closeConnections;

@end
