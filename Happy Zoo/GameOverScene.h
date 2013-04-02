//
//  GameOverScene.h
//  test1
//
//  Created by f on 10/28/12.
//
//
#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameOverLayer : CCLayer{
    CCLabelTTF *_label;
}
@property (nonatomic,retain)CCLabelTTF *label;

@end

@interface GameOverScene : CCScene{
    GameOverLayer *_layer;
}

@property (nonatomic,retain)GameOverLayer *layer;
@end