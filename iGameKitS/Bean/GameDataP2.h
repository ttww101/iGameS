//
//  GameDataP2.h
//  iHealthS
//
//  Created by Apple on 2019/4/1.
//  Copyright © 2019 whitelok.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@protocol P2DATA
@end

@interface P2DATA : JSONModel
@property NSString *id;
@property NSString *title;
@property NSArray *image;
@property NSArray *content;

@end

@implementation P2DATA
@end

@interface GameDataP2 : JSONModel
@property NSString *status;
@property NSString *msg;
@property NSArray<P2DATA> *data;

@end

@implementation GameDataP2
@end
