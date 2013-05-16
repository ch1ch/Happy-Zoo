//
//  GameScene.h
//  test1
//
//  Created by f on 10/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SimpleAudioEngine.h"
typedef enum
{
	LayerTagGameLayer,
	LayerTagUILayer,
} MultiLayerSceneTags;

extern int gamestarscore;
extern int game1level;
extern int game1thing;
extern int gamescene;

@interface GameScenepie : CCLayer {
    CCSprite* Pipeline;
     CCSprite* Pipetap;
     CCSprite* Pipeweitch;
    CCSprite* tank_fish;
    CCSprite* tank_fishde;
    CCSprite * background;
    CCSprite * selSprite;
    CCSprite *game1treasure;
    CCSprite *game1treasures;
    NSMutableArray * movableSprites;
  int array1[20];
    int array2[20];
    int numberp;
    int gamesc;
    int waitstar;
    CCMenu *menu1;
    CCMenu *menu2;
    CCMenu *menu3;
    CCMenu *menu4;
    CCMenu *menu5;
    CCMenu *menu7;
    CCSprite * backgroundmenu;
    CCLabelTTF *label1;
    CCAnimation *pAnim;
    CCAnimation *pAnimfishde;
    int gameover;
    int gametime;
    BOOL isPlaying;


    BOOL _moving;// Add after the HelloWorld interface


}

@property (nonatomic,retain)CCLabelTTF *label1;

+(void) simulateLongLoadingTime;
-(void) Callfish;
+(id) scene;
-(void) back;
-(void) gamingmenu;
-(void) gomenu1;
-(void) gomenu2;

@end
