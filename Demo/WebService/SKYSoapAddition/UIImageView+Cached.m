//
//  UIImageViewCached.m
//  UIImageViewCached
//
//  Created by Jaanus Kase on 09.04.11.
//  Copyright 2011 Rico. All rights reserved.
//

#import "UIImageView+Cached.h"
#import "ASIHTTPRequest.h"
#import "ASIDownloadCache.h"

@implementation UIImageView (Cached)

- (void) loadImageFromUrl:(NSURL *)url
{    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        
        [request setDownloadCache:[ASIDownloadCache sharedCache]];
        [request setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
        [request setCachePolicy:ASIAskServerIfModifiedWhenStaleCachePolicy|ASIFallbackToCacheIfLoadFailsCachePolicy];
        [request startSynchronous];
        
        NSError *error = [request error];
        if (!error)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.image = [UIImage imageWithData:[request responseData]];
            });
        }
    });
}

@end
