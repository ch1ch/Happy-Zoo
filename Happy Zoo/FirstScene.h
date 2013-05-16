//
//  FirstScene.h
//  ScenesAndLayers
//


#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SimpleAudioEngine.h"


@class ListLayer;

typedef enum
{
	LayerTagGameLayer1,
	LayerTagUILayer1,
} MultiLayerSceneTags1;



@interface FirstScene : CCLayer 
{
    CCSprite * background;
    CCSprite * backgroundsky;
    CCSprite* mainSound;
    CCSprite* mainFlower;
    CCSprite* mainCloud;
    CCSprite* mainCenter;
    CCSprite *mainFlower2;
    CCSprite *mainFlower3;

    CCSprite* mainHome;
    CCSprite* mainBall;

    CCSprite* mainarrleft;
    CCSprite* mainarrright;
    CCSprite *mainCrites;
    int game1levels;
    BOOL isTouchflower2;
    BOOL isTouchflower3;
  
}


+(FirstScene*) sharedLayer;

+(id) scene;
-(void) gomenu1;
-(void) gomenu2;
+(int) retulevel1;


@property (readwrite)int game11level;
@property (readonly) ListLayer* listLayer;

@end
