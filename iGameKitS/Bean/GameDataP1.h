//
//  GameDataP1.h
//  iHealthS
//
//  Created by Apple on 2019/4/1.
//  Copyright © 2019 whitelok.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@protocol DATA
@end

@interface DATA : JSONModel
@property NSString *id;
@property NSString *title;
@property NSString *image;
@property NSString *content;

@end

@implementation DATA
@end

@interface GameDataP1 : JSONModel
@property NSString *status;
@property NSString *msg;
@property NSArray<DATA> *data;

@end

@implementation GameDataP1
@end
