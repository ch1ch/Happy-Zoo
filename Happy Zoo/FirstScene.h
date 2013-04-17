//
//  FirstScene.h
//  ScenesAndLayers
//


#import <Foundation/Foundation.h>
#import "cocos2d.h"





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
    CCSprite* mainHome;
    CCSprite* mainBall;
    CCSprite* mainQuestion;
    CCSprite* mainarrleft;
    CCSprite* mainarrright;
   

}

+(FirstScene*) sharedLayer;

+(id) scene;
-(void) gomenu1;
-(void) gomenu2;

//extern int gamestarscore;



@property (readonly) ListLayer* listLayer;

@end
