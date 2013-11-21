//
//  GameObject.h
//  SimpleBox2dScroller
//
//  Created by min on 3/17/11.
//  Copyright 2011 Min Kwon. All rights reserved.
//

#import "cocos2d.h"
#import "Constants.h"

typedef enum {
    kGameObjectNone,
    kGameObjectPlayer,
    kGameObjectPlatform
} GameObjectType;

@interface GameObject : CCSprite {
    GameObjectType  type;
}

@property (nonatomic, readwrite) GameObjectType type;
@end
