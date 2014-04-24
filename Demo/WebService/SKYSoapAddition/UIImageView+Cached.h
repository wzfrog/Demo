//
//  UIImageViewCached.h
//  UIImageViewCached
//
//  Created by Jaanus Kase on 09.04.11.
//  Copyright 2011 Rico. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Cached)

// Call this method to load an image from network. The load fails back to local cache if network is not available
// or the image does not need to be refreshed, as determined by response headers.
- (void)loadImageFromUrl:(NSURL *)url;

@end
