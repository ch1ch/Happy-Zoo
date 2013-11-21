//
//  GameOverScene.h
//  test1
//
//  Created by f on 10/28/12.
//
//
#import <Foundation/Foundation.h>
#import "cocos2d.h"

extern int game1level;
extern int game1thing;
extern int gamescene;

@interface GameOverScene : CCScene{
    CCLabelTTF *label1;
    CCSpriteBatchNode *gamesprite;

}
+(id) scene;

@end