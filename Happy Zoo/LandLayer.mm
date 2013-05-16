//
//  LandLayer.m
//  Happy Zoo
//
//  Created by f on 4/11/13.
//
//

#import "LandLayer.h"
#import "LoadingScene.h"
#import "GB2ShapeCache.h"

#define PTM_RATIO 32.0

@implementation LandLayer


-(id)init
{
    if ((self =[super init]))
    {
        [[CCDirector sharedDirector] resume];

        // ListLayerPosition= self.position;
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        self.anchorPoint = ccp(screenSize.width*0.5 ,screenSize.height*0.5);

        allland = [[NSMutableArray alloc] init];
        
        [[GB2ShapeCache sharedShapeCache] addShapesWithFile:@"pig-run.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"pig_land_car.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"pig_land_car2.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"pig_land_car3.plist"];
         [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"pig_thing1.plist"];
        
        
        [self setupPhysicsWorld];
        
        
        
        
        // Create edges around the entire screen
        b2BodyDef groundBodyDef;
        groundBodyDef.position.Set(0,0);
        b2Body *groundBody = _world->CreateBody(&groundBodyDef);
        b2EdgeShape groundBox;
        
        
        //bottom
        groundBox.Set(b2Vec2(0,screenSize.height*(-1)/PTM_RATIO), b2Vec2(screenSize.width*15/PTM_RATIO,screenSize.height*(-1)/PTM_RATIO));
        groundBody->CreateFixture(&groundBox,0);
        
        // top
        groundBox.Set(b2Vec2(0,screenSize.height*2/PTM_RATIO), b2Vec2(screenSize.width/PTM_RATIO,screenSize.height*2/PTM_RATIO));
        groundBody->CreateFixture(&groundBox,0);
        
        // left
        groundBox.Set(b2Vec2(0,screenSize.height*2/PTM_RATIO), b2Vec2(0,screenSize.height*(-1)/PTM_RATIO));
        groundBody->CreateFixture(&groundBox,0);
        
        
        
        [self drawmonster];
        [self drawpig];
        [self drawland1];
        [self drawland2];
        [self drawmons1];
        [self drawland6];
        [self drawmons2];
        [self drawland7];
        [self drawmons7_1];
        [self drawland10];
        [self drawland4];
        [self drawmons3];
        [self drawland3];
        [self drawland8_1];
        [self drawland8_2];
        [self drawland6_2];
        [self drawmons4];
        [self drawland5];
        //[self drawmons5];
        [self drawland9];
        [self drawland3_2];
        [self drawmons6];
        [self drawland11];[self drawland12];[self drawland13];
        [self drawland6_3];
        [self drawland14];
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
 
        //隐藏物品
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"gameoverthings.plist"];
        game3treasure=[CCSprite spriteWithSpriteFrameName:@"treasure03.png"];
        [game3treasure setPosition:ccp(screenSize.width*6.11,screenSize.height*(-0.82))];
        [self addChild:game3treasure z:9 tag:501];

    }

    // Create contact listener
    _contactListener =new MyContactListener();
    _world->SetContactListener(_contactListener);
    
    
        //[self schedule:@selector(update:) interval:0.1f];
    
    [self schedule:@selector(tick:)interval:0.1f];
    [self schedule:@selector(GameOvertest:) interval:0.1f];
      
    
    return self;

    }

-(void) setupPhysicsWorld {
    
    
    b2Vec2 gravity = b2Vec2(0.0f, -9.0f);
    _world = new b2World(gravity);
    
    /*

    _debugDraw = new GLESDebugDraw(PTM_RATIO);
    _world->SetDebugDraw(_debugDraw);
    uint32 flags = 0;
    flags += b2Draw::   e_shapeBit;
    _debugDraw->SetFlags(flags);

    */
    
    _contactListener =new MyContactListener();
    _world->SetContactListener(_contactListener);
}


- (void)tick:(ccTime) dt {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    gametime++;
    if (gametime==20) {
        [[SimpleAudioEngine sharedEngine]playEffect:@"didibenben.mp3"];
    }

    if (gametime==100) {
        [[SimpleAudioEngine sharedEngine]playEffect:@"didibenben.mp3"];
    }
    if (gametime==230) {
        [[SimpleAudioEngine sharedEngine]playEffect:@"didibenben.mp3"];
    }
    NSLog(@"time~%d",gametime);

    if (game3thing==1|game3thing==2) {
        
        game3treasure.visible=NO;
    }
    /*
        
        game3thing=2;
        
        game3treasures=[CCSprite spriteWithSpriteFrameName:@"Game-treasure3.png"];
        [game3treasures setPosition:ccp(screenSize.width*5.7,screenSize.height*(-0.85))];
        [self addChild:game3treasures z:35];
        
    }
    if (game3thing==2) {
        CGPoint temp=game3treasures.position;
        temp.x=temp.x-3;
        temp.y=temp.y-3;
        game3treasures.position=temp;
    }
    */
    //世界物体位置更新
    _world->Step(dt, 8, 3);
    for(b2Body *b = _world->GetBodyList(); b; b=b->GetNext())
    {
        if (b->GetUserData() != NULL)
        {
            CCSprite *ballData = (CCSprite *)b->GetUserData();
            
            if (ballData.tag!=109)
            {
               if (ballData.tag ==101)
               {
                    ballData.position =CGPointMake(b->GetPosition().x*PTM_RATIO, b->GetPosition().y*PTM_RATIO);
               }
               else
               {
                    ballData.position = ccp(b->GetPosition().x * PTM_RATIO,
                                        b->GetPosition().y * PTM_RATIO);
                }
                ballData.rotation =-1* CC_RADIANS_TO_DEGREES(b->GetAngle());
            }
            else if(ballData.tag==301){
                b->SetTransform(b2Vec2(monster1.position.x/PTM_RATIO,monster1.position.y/PTM_RATIO), 0);
            }else
            {
                b->SetTransform(b2Vec2(land9.position.x/PTM_RATIO,land9.position.y/PTM_RATIO), 0);
        }
        //获得汽车速度，保证最低速度
        if (ballData.tag==100)
        {
            //NSLog(@"sudu%f",b->GetLinearVelocity().x);
            if (self.position.x<screenSize.width*(-1.0))
            {
                if (self.position.x>screenSize.width*(-2.5))
                {
                   // NSLog(@"111111");
                    if (b->GetLinearVelocity().x<5)
                    {
                        b2Vec2 tempvel=b->GetLinearVelocity();
                        tempvel.x=5;
                        b->SetLinearVelocity(tempvel);
                    }
                    if (b->GetLinearVelocity().x>8)
                    {
                        b2Vec2 tempvel=b->GetLinearVelocity();
                        tempvel.x=8;
                        b->SetLinearVelocity(tempvel);
                    }
                }else
                {
                    // NSLog(@"2222222");
                    if (b->GetLinearVelocity().x<7)
                    {
                        b2Vec2 tempvel=b->GetLinearVelocity();
                        tempvel.x=7;
                        b->SetLinearVelocity(tempvel);
                    }
                    if (b->GetLinearVelocity().x>10)
                    {
                        b2Vec2 tempvel=b->GetLinearVelocity();
                        tempvel.x=10;
                        b->SetLinearVelocity(tempvel);
                    }

                }
            }
            float angletemp=b->GetAngle();
            if (angletemp>0.5) {
                
                b->SetTransform(b->GetPosition(), 0.5);
                }
            if (angletemp<-0.5) {
                
                b->SetTransform(b->GetPosition(), -0.5);
            }

        }

    }
  
    }
    //获取初始位置
    if (oldpigpostion.x==0) {
        oldpigpostion.x=pig.position.x;
        oldpigpostion.y=pig.position.y;
        firsttime=1;
    }
    
    newpigpostion.x=pig.position.x;
    newpigpostion.y=pig.position.y;
    
    //屏幕根据猪位置变化，移动
    CGPoint newpos1;
    
    if (self.position.x<screenSize.width*(-0.5)) {
        newpos1 = ccp(self.position.x-newpigpostion.x+oldpigpostion.x,755);
    }else{
        newpos1 = ccp(self.position.x-newpigpostion.x+oldpigpostion.x+5, self.position.y-newpigpostion.y+oldpigpostion.y-5);

    }
          
    oldpigpostion=newpigpostion;
    
    

       [self setPosition:newpos1];
    //那个上下移动的特殊板块
    if (pos9.y==0) {
        pos9=land9.position;
    }
    
    if (self.position.x<screenSize.width*(-9.6)) {
        [self runobsMoveSequencey:land9];
    }
    
    //确认是否车和板块接触，防止二段跳
    pigjumping=1;
    std::vector<b2Body *>toDestroy;
    std::vector<MyContact>::iterator pos;
    for(pos = _contactListener->_contacts.begin(); pos != _contactListener->_contacts.end(); ++pos)
    {
        MyContact contact = *pos;
        
        // Get the box2d bodies for each object
        b2Body *bodyA = contact.fixtureA->GetBody();
        b2Body *bodyB = contact.fixtureB->GetBody();
        
        
        if (bodyA->GetUserData() != NULL && bodyB->GetUserData() != NULL)
        {
            CCSprite *spriteA = (CCSprite *) bodyA->GetUserData();
            CCSprite *spriteB = (CCSprite *) bodyB->GetUserData();
            //NSLog(@"%d  and   %d   zhuangjila~~",spriteA.tag,spriteB.tag);
            if(spriteA.tag==100 ||spriteB.tag==100)
            {
                //NSLog(@"%d  and   %d   zhuangjila~~",spriteA.tag,spriteB.tag);
                pigjumping=0;
                    
            }else{
                pigjumping=1;
            }
            //刺猬判定
            if (spriteA.tag==371||spriteB.tag==371) {
                [self Gameovers];
            }
            //坑判定
            if (spriteA.tag==387||spriteB.tag==387) {
                [self Gameovers];
            }
            //狗
            if (spriteA.tag==305||spriteB.tag==305) {
                [self Gameovers];
            }
            //刺判定
            if (spriteA.tag==306||spriteB.tag==306) {
                [self Gameovers];
            }
        }
    }
    
    //刺猬移动
    CGPoint montemp=monster1.position;
    if (montemp.x>screenSize.width*2.3)
    {
        montemp.x-=10;
    //    NSLog(@"---%f",montemp.x);
    }else if(montemp.x<screenSize.width*2.0)
    {
        montemp.x+=10;
    //    NSLog(@"++++++%f",montemp.x);
    }else{
        [self runobsMoveSequencex:monster1];
   //     NSLog(@"====%f",montemp.x);
    }
    //monster1.position=montemp;
    

  
}
-(void) simulateLongLoadingTime
{
	// Simulating a long loading time by doing some useless calculation a large number of times.
	double a = 122, b = 243;
	for (unsigned int i = 0; i < 300000000; i++)
	{
		a = a / b;
	}
}


-(void)GameOvertest:(ccTime) dt {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
   // NSLog(@"pig~ pos x=%f,y=%f.",pig.position.x,pig.position.y);
    //NSLog(@"self~ pos x=%f,y=%f.",self.position.x,self.position.y);

    if (pig.position.y<-720) {
        [self Gameovers];
    }
    
    if (self.position.x<screenSize.width*(-14.4)) {
              NSLog(@" you win!");
        //[self simulateLongLoadingTime];
        [self Gameovers];
        
    }
  
}

-(void)drawgameover{
    CGSize screenSize = [[CCDirector sharedDirector] winSize];

    label1 = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"You Win! "] fontName:@"Marker Felt" fontSize:64];
    label1.position =  ccp(screenSize.width*15.1 ,screenSize.height*(-0.5) );
    [label1 setString:[NSString stringWithFormat:@"Game Win!"]];
    //[self addChild: label1];
    [[CCDirector sharedDirector] pause];
}





-(void) draw
{
    glDisable(GL_TEXTURE_2D);
    
    
    _world->DrawDebugData();
    
    glEnable(GL_TEXTURE_2D);
    
}


-(void)drawmonster{
    //起始鸭子
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    CCSpriteBatchNode *decorate1=[CCSprite spriteWithSpriteFrameName:@"pigrun-decorate1.png"];
    [decorate1 setPosition:ccp(screenSize.width*0.13,screenSize.height*0.75)];
    [self addChild:decorate1 z:12 tag:200];
    
    //天上花
    CCSpriteBatchNode *decorate2=[CCSprite spriteWithSpriteFrameName:@"pigrun-decorate2.png"];
    [decorate2 setPosition:ccp(screenSize.width*2.4,screenSize.height*(-0.3))];
    [self addChild:decorate2 z:12 tag:200];
    
    CCSpriteBatchNode *decorate3=[CCSprite spriteWithSpriteFrameName:@"pigrun-decorate3.png"];
    [decorate3 setPosition:ccp(screenSize.width*2.4,screenSize.height*(-0.3))];
    [self addChild:decorate3 z:13 tag:200];
    
    CCSpriteBatchNode *decorate4=[CCSprite spriteWithSpriteFrameName:@"pigrun-decorate3.png"];
    [decorate4 setPosition:ccp(screenSize.width*2.57,screenSize.height*(-0.45))];
    [self addChild:decorate4 z:13 tag:200];
    
    CCSpriteBatchNode *decorate3_1=[CCSprite spriteWithSpriteFrameName:@"pigrun-decorate3.png"];
    [decorate3_1 setPosition:ccp(screenSize.width*2.28,screenSize.height*(-0.45))];
    [self addChild:decorate3_1 z:13 tag:200];
    
    //red flower
    CCSpriteBatchNode *decorate4_1=[CCSprite spriteWithSpriteFrameName:@"pigrun-decorate4.png"];
    [decorate4_1 setPosition:ccp(screenSize.width*2.6,screenSize.height*(-0.79))];
    [self addChild:decorate4_1 z:9 tag:200];
    
    
    //天上花
    CCSpriteBatchNode *decorate200=[CCSprite spriteWithSpriteFrameName:@"pigrun-decorate2.png"];
    [decorate200 setPosition:ccp(screenSize.width*4.0,screenSize.height*(-0.3))];
    [self addChild:decorate200 z:12 tag:200];
    
    CCSpriteBatchNode *decorate300=[CCSprite spriteWithSpriteFrameName:@"pigrun-decorate3.png"];
    [decorate300 setPosition:ccp(screenSize.width*4.0,screenSize.height*(-0.3))];
    [self addChild:decorate300 z:13 tag:200];
    
    CCSpriteBatchNode *decorate400=[CCSprite spriteWithSpriteFrameName:@"pigrun-decorate3.png"];
    [decorate400 setPosition:ccp(screenSize.width*4.17,screenSize.height*(-0.45))];
    [self addChild:decorate400 z:13 tag:200];
    
    CCSpriteBatchNode *decorate3_100=[CCSprite spriteWithSpriteFrameName:@"pigrun-decorate3.png"];
    [decorate3_100 setPosition:ccp(screenSize.width*3.98,screenSize.height*(-0.45))];
    [self addChild:decorate3_100 z:13 tag:200];
    
    
    
    //white flower
    CCSpriteBatchNode *decorate5=[CCSprite spriteWithSpriteFrameName:@"pigrun-decorate5.png"];
    [decorate5 setPosition:ccp(screenSize.width*6.33,screenSize.height*(-0.79))];
    [self addChild:decorate5 z:13 tag:200];
    CCSpriteBatchNode *decorate3_2=[CCSprite spriteWithSpriteFrameName:@"pigrun-decorate3.png"];
    [decorate3_2 setPosition:ccp(screenSize.width*6.30,screenSize.height*(-0.75))];
    [self addChild:decorate3_2 z:13 tag:200];
    CCSpriteBatchNode *decorate3_3=[CCSprite spriteWithSpriteFrameName:@"pigrun-decorate3.png"];
    [decorate3_3 setPosition:ccp(screenSize.width*6.39,screenSize.height*(-0.78))];
    [self addChild:decorate3_3 z:13 tag:200];
    
    
    //green
    CCSpriteBatchNode *decorate7=[CCSprite spriteWithSpriteFrameName:@"pigrun-decorate7.png"];
    [decorate7 setPosition:ccp(screenSize.width*7.47,screenSize.height*(-0.65))];
    [self addChild:decorate7 z:13 tag:200];
    
    CCSpriteBatchNode *decorate10=[CCSprite spriteWithSpriteFrameName:@"pigrun-decorate10.png"];
    [decorate10 setPosition:ccp(screenSize.width*7.99,screenSize.height*(-0.67))];
    [self addChild:decorate10 z:13 tag:200];
    
    
    //蚂蚁洞
    CCSpriteBatchNode* mayidong = [CCSprite spriteWithSpriteFrameName:@"pigrun-decorate14.png"];
    [mayidong setPosition:ccp(screenSize.width*8.67 ,screenSize.height*(-0.84))];
    [self addChild:mayidong z:12];
    CCAnimation *anpig_sun = [CCAnimation animation];
    for(unsigned int i = 14; i <23; i++)
    {
        NSString *naback = [NSString stringWithFormat:@"pigrun-decorate%d.png", i];
        [anpig_sun  addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:naback]];
    }
    [anpig_sun setDelayPerUnit:0.5f];
    id actsun =[CCRepeatForever actionWithAction: [CCSequence actions:[CCDelayTime actionWithDuration:0.5f], [CCAnimate  actionWithAnimation:anpig_sun], NULL]];
    [mayidong runAction:actsun];
    
    
    CCSpriteBatchNode *decorate8=[CCSprite spriteWithSpriteFrameName:@"pigrun-decorate8.png"];
    [decorate8 setPosition:ccp(screenSize.width*9.73,screenSize.height*(-0.81))];
    [self addChild:decorate8 z:13 tag:200];
    

    
    
    //结局
    CCSpriteBatchNode *decorate11=[CCSprite spriteWithSpriteFrameName:@"pigrun-decorate11.png"];
    [decorate11 setPosition:ccp(screenSize.width*15.12,screenSize.height*(-0.42))];
    [self addChild:decorate11 z:12 tag:200];
    
    CCSpriteBatchNode *decorate12=[CCSprite spriteWithSpriteFrameName:@"pigrun-decorate12.png"];
    [decorate12 setPosition:ccp(screenSize.width*15.22,screenSize.height*(-0.6))];
    [self addChild:decorate12 z:13 tag:200];

    
    
    
}




- (void)drawpig {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    
    //pig = [CCSprite spriteWithSpriteFrameName:@"pigrun-car01.png"];
    pig =[Player1 spriteWithSpriteFrameName:@"pigrun-car01.png"];
    [pig setPosition:ccp(screenSize.width*0.05,screenSize.height*0.67)];
    [self addChild:pig z:15 tag:100];
    
    
    
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_dynamicBody;
    bodyDef.position.Set(pig.position.x/PTM_RATIO, pig.position.y/PTM_RATIO);
    bodyDef.userData = pig;
    b2Body *body = _world->CreateBody(&bodyDef);
    pig.body = body;
    
    NSString *name = @"pigrun-car01";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [pig setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
    
    
    CCAnimation *ananmail1 = [CCAnimation animation];
    for(unsigned int i = 1; i < 8; i++)
    {
        NSString *naanmal1 = [NSString stringWithFormat:@"pigrun-car0%d.png", i];
        [ananmail1  addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:naanmal1]];
    }
    
    [ananmail1 setDelayPerUnit:0.3f];
    id actanmal1 =[CCRepeatForever actionWithAction: [CCSequence actions:[CCDelayTime actionWithDuration:0.1f], [CCAnimate  actionWithAnimation:ananmail1], NULL]];
    [pig  runAction:actanmal1];
    
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"pig_pig.plist"];
    pig_pig= [CCSprite spriteWithSpriteFrameName:@"pigrun-pig01.png"];
    [pig_pig setPosition:ccp(screenSize.width*0.1 ,screenSize.height*0.22)];
    [pig addChild:pig_pig z:0];
    CCAnimation *anibackgroup = [CCAnimation animation];
    for(unsigned int i = 1; i <3; i++)
    {
        NSString *naback = [NSString stringWithFormat:@"pigrun-pig0%d.png", i];
        [anibackgroup  addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:naback]];
    }
    [anibackgroup setDelayPerUnit:0.5f];
    id actback =[CCRepeatForever actionWithAction: [CCSequence actions:[CCDelayTime actionWithDuration:0.5f], [CCAnimate  actionWithAnimation:anibackgroup], NULL]];
    [pig_pig  runAction:actback];
    
    
}




- (void)drawland1 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    
    land1 = [CCSprite spriteWithSpriteFrameName:@"pigrun-land01.png"];
    [land1 setPosition:ccp(screenSize.width*(-0.02) ,screenSize.height*(-1.0))];
    [self addChild:land1 z:10 tag:101];
   
 
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_staticBody;
    bodyDef.position.Set(land1.position.x/PTM_RATIO, land1.position.y/PTM_RATIO);
    bodyDef.userData = land1;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"pigrun-land01";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [land1 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
 
}



- (void)drawland2 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    
    land2 = [CCSprite spriteWithSpriteFrameName:@"pigrun-land02.png"];
    [land2 setPosition:ccp(screenSize.width*1.92,screenSize.height*(-1.0))];
    [self addChild:land2 z:10 tag:102];

    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_staticBody;
    bodyDef.position.Set(land2.position.x/PTM_RATIO, land2.position.y/PTM_RATIO);
    bodyDef.userData = land2;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"pigrun-land02";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [land2 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
    
    
}

- (void)drawmons1 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];

    monster1 = [CCSprite spriteWithSpriteFrameName:@"pigrun-monster1.png"];
    [monster1 setPosition:ccp(screenSize.width*2.3,screenSize.height*(-0.83))];
    [self addChild:monster1 z:12 tag:371];
 
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_staticBody;
    bodyDef.position.Set(monster1.position.x/PTM_RATIO, monster1.position.y/PTM_RATIO);
    bodyDef.userData = monster1;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"pigrun-monster1";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [monster1 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];

    
}

- (void)drawland6 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    
    land6 = [CCSprite spriteWithSpriteFrameName:@"pigrun-land06.png"];
    [land6 setPosition:ccp(screenSize.width*3.05,screenSize.height*(-1.09))];
    [self addChild:land6 z:10 tag:106];
    
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_staticBody;
    bodyDef.position.Set(land6.position.x/PTM_RATIO, land6.position.y/PTM_RATIO);
    bodyDef.userData = land6;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"pigrun-land06";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [land6 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
    
    
}

- (void)drawmons2 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    monster2 = [CCSprite spriteWithSpriteFrameName:@"pigrun-monster2.png"];
    [monster2 setPosition:ccp(screenSize.width*3.35,screenSize.height*(-0.75))];
    [self addChild:monster2 z:12 tag:302];
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_staticBody;
    bodyDef.position.Set(monster2.position.x/PTM_RATIO, monster2.position.y/PTM_RATIO);
    bodyDef.userData = monster2;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"pigrun-monster2";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [monster2 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
    
}


- (void)drawland7 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];

    land7 = [CCSprite spriteWithSpriteFrameName:@"pigrun-land07.png"];
    [land7 setPosition:ccp(screenSize.width*4.3,screenSize.height*(-1.02))];
    [self addChild:land7 z:10 tag:107];

    b2BodyDef bodyDef;
    
    bodyDef.type = b2_staticBody;
    bodyDef.position.Set(land7.position.x/PTM_RATIO, land7.position.y/PTM_RATIO);
    bodyDef.userData = land7;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"pigrun-land07";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [land7 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
    
    
}


- (void)drawmons7_1 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
     monster7_1 = [CCSprite spriteWithFile:@"pigrun-monskeng.png"];
    [monster7_1 setPosition:ccp(screenSize.width*4.83,screenSize.height*(-0.96))];
    [self addChild:monster7_1 z:9 tag:387];
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_staticBody;
    bodyDef.position.Set(monster7_1.position.x/PTM_RATIO, monster7_1.position.y/PTM_RATIO);
    bodyDef.userData = monster7_1;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"pigrun-monskeng";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [monster7_1 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
    
}
- (void)drawland10 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    
    land10 = [CCSprite spriteWithSpriteFrameName:@"pigrun-land10.png"];
    [land10 setPosition:ccp(screenSize.width*5.16,screenSize.height*(-1.00))];
    [self addChild:land10 z:9 tag:110];
    
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_staticBody;
    bodyDef.position.Set(land10.position.x/PTM_RATIO, land10.position.y/PTM_RATIO);
    bodyDef.userData = land10;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"pigrun-land10";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [land10 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
    
    
}

- (void)drawland4 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    
    land4 = [CCSprite spriteWithSpriteFrameName:@"pigrun-land04.png"];
    [land4 setPosition:ccp(screenSize.width*5.69,screenSize.height*(-1.02))];
    [self addChild:land4 z:10 tag:104];
    
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_staticBody;
    bodyDef.position.Set(land4.position.x/PTM_RATIO, land4.position.y/PTM_RATIO);
    bodyDef.userData = land4;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"pigrun-land04";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [land4 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
  
}

- (void)drawmons3 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    monster3 = [CCSprite spriteWithSpriteFrameName:@"pigrun-monster3.png"];
    [monster3 setPosition:ccp(screenSize.width*5.9,screenSize.height*(-0.85))];
    [self addChild:monster3 z:12 tag:303];
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_staticBody;
    bodyDef.position.Set(monster3.position.x/PTM_RATIO, monster3.position.y/PTM_RATIO);
    bodyDef.userData = monster3;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"pigrun-monster3";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [monster3 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
    
}

- (void)drawland3 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    
    land3 = [CCSprite spriteWithSpriteFrameName:@"pigrun-land03.png"];
    [land3 setPosition:ccp(screenSize.width*6.8,screenSize.height*(-1.22))];
    [self addChild:land3 z:10 tag:103];
    
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_staticBody;
    bodyDef.position.Set(land3.position.x/PTM_RATIO, land3.position.y/PTM_RATIO);
    bodyDef.userData = land3;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"pigrun-land03";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [land3 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
    
    
}

- (void)drawland8_1 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    
    land8_1 = [CCSprite spriteWithSpriteFrameName:@"pigrun-land08.png"];
    [land8_1 setPosition:ccp(screenSize.width*7.9,screenSize.height*(-0.77))];
    [self addChild:land8_1 z:10 tag:108];
    
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_staticBody;
    bodyDef.position.Set(land8_1.position.x/PTM_RATIO, land8_1.position.y/PTM_RATIO);
    bodyDef.userData = land8_1;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"pigrun-land08";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [land8_1 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
}

- (void)drawland8_2 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    
    land8_2 = [CCSprite spriteWithSpriteFrameName:@"pigrun-land08.png"];
    [land8_2 setPosition:ccp(screenSize.width*8.1,screenSize.height*(-0.67))];
    [self addChild:land8_2 z:10 tag:108];
    
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_staticBody;
    bodyDef.position.Set(land8_2.position.x/PTM_RATIO, land8_2.position.y/PTM_RATIO);
    bodyDef.userData = land8_2;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"pigrun-land08";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [land8_2 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
}

- (void)drawland6_2 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
  
    land6_2 = [CCSprite spriteWithSpriteFrameName:@"pigrun-land17.png"];
    [land6_2 setPosition:ccp(screenSize.width*8.24,screenSize.height*(-1.1))];
    [self addChild:land6_2 z:10 tag:106];
  
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_staticBody;
    bodyDef.position.Set(land6_2.position.x/PTM_RATIO, land6_2.position.y/PTM_RATIO);
    bodyDef.userData = land6_2;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"pigrun-land17";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [land6_2 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
   
}

- (void)drawmons4 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    monster4 = [CCSprite spriteWithSpriteFrameName:@"pigrun-monster4.png"];
    [monster4 setPosition:ccp(screenSize.width*8.5,screenSize.height*(-0.6))];
    [self addChild:monster4 z:12 tag:303];
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_staticBody;
    bodyDef.position.Set(monster4.position.x/PTM_RATIO, monster4.position.y/PTM_RATIO);
    bodyDef.userData = monster4;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"pigrun-monster4";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [monster4 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
    
}


- (void)drawland5 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
   
    land5 = [CCSprite spriteWithSpriteFrameName:@"pigrun-land05.png"];
    [land5 setPosition:ccp(screenSize.width*9.52,screenSize.height*(-1.1))];
    [self addChild:land5 z:10 tag:105];
  
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_staticBody;
    bodyDef.position.Set(land5.position.x/PTM_RATIO, land5.position.y/PTM_RATIO);
    bodyDef.userData = land5;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"pigrun-land05";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [land5 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
 
}

- (void)drawmons5 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    monster5 = [CCSprite spriteWithSpriteFrameName:@"pigrun-monster5.png"];
    [monster5 setPosition:ccp(screenSize.width*9.93,screenSize.height*(-0.84))];
    [self addChild:monster5 z:12 tag:305];
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_staticBody;
    bodyDef.position.Set(monster5.position.x/PTM_RATIO, monster5.position.y/PTM_RATIO);
    bodyDef.userData = monster5;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"pigrun-monster5";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [monster5 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
    CCAnimation *anpig_windy = [CCAnimation animation];
    for(unsigned int i = 1; i <3; i++)
    {
        NSString *naback = [NSString stringWithFormat:@"pigrun-monster5-%d.png", i];
        [anpig_windy  addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:naback]];
    }
    [anpig_windy setDelayPerUnit:0.2f];
    id actwindy =[CCRepeatForever actionWithAction: [CCSequence actions:[CCDelayTime actionWithDuration:0.2f], [CCAnimate  actionWithAnimation:anpig_windy], NULL]];
    [monster5 runAction:actwindy];
    
    
}


- (void)drawland9 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    
    land9 = [CCSprite spriteWithSpriteFrameName:@"pigrun-land15.png"];
    //[land9 setPosition:ccp(screenSize.width*1.78,screenSize.height*(-0.6))];
    land9.position = CGPointMake(screenSize.width*10.7,screenSize.height*(-1.05));
    [self addChild:land9 z:10 tag:109];
    
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_staticBody;
    bodyDef.position.Set(land9.position.x/PTM_RATIO, land9.position.y/PTM_RATIO);
    bodyDef.userData = land9;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"pigrun-land15";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [land9 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
    CCSpriteBatchNode *decorate9=[CCSprite spriteWithSpriteFrameName:@"pigrun-decorate9.png"];
    [decorate9 setPosition:ccp(screenSize.width*0.3,screenSize.height*0.1)];
    [land9 addChild:decorate9 z:13 tag:200];
    
}

- (void)drawland3_2 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
  
    land3_2 = [CCSprite spriteWithSpriteFrameName:@"pigrun-land03.png"];
    [land3_2 setPosition:ccp(screenSize.width*11.35,screenSize.height*(-1.0))];
    [self addChild:land3_2 z:10 tag:103];
    
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_staticBody;
    bodyDef.position.Set(land3_2.position.x/PTM_RATIO, land3_2.position.y/PTM_RATIO);
    bodyDef.userData = land3_2;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"pigrun-land03";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [land3_2 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
  
}

- (void)drawmons6 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    monster6 = [CCSprite spriteWithSpriteFrameName:@"pigrun-monster6.png"];
    [monster6 setPosition:ccp(screenSize.width*12.05,screenSize.height*(-0.48))];
    [self addChild:monster6 z:12 tag:306];
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_staticBody;
    bodyDef.position.Set(monster6.position.x/PTM_RATIO, monster6.position.y/PTM_RATIO);
    bodyDef.userData = monster6;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"pigrun-monster6";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [monster6 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
    
}


- (void)drawland11 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    
    land11 = [CCSprite spriteWithSpriteFrameName:@"pigrun-land11.png"];
    
    land11.position = CGPointMake(screenSize.width*12.36,screenSize.height*(-1.1));
    [self addChild:land11 z:10 tag:111];
    
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_staticBody;
    bodyDef.position.Set(land11.position.x/PTM_RATIO, land11.position.y/PTM_RATIO);
    bodyDef.userData = land11;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"pigrun-land11";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [land11 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
    
    
}

- (void)drawland12 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    
    land12 = [CCSprite spriteWithSpriteFrameName:@"pigrun-land12.png"];
    
    land12.position = CGPointMake(screenSize.width*12.66,screenSize.height*(-1.1));
    [self addChild:land12 z:10 tag:112];
    
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_staticBody;
    bodyDef.position.Set(land12.position.x/PTM_RATIO, land12.position.y/PTM_RATIO);
    bodyDef.userData = land12;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"pigrun-land12";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [land12 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
    
    
}

- (void)drawland13 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    
    land13 = [CCSprite spriteWithSpriteFrameName:@"pigrun-land13.png"];
    
    land13.position = CGPointMake(screenSize.width*12.96,screenSize.height*(-1.1));
    [self addChild:land13 z:10 tag:113];
    
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_staticBody;
    bodyDef.position.Set(land13.position.x/PTM_RATIO, land13.position.y/PTM_RATIO);
    bodyDef.userData = land13;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"pigrun-land13";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [land13 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
    
    
}



- (void)drawland6_3 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    
    land6_3 = [CCSprite spriteWithSpriteFrameName:@"pigrun-land17.png"];
    [land6_3 setPosition:ccp(screenSize.width*13.32,screenSize.height*(-1.05))];
    [self addChild:land6_3 z:10 tag:106];
    
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_staticBody;
    bodyDef.position.Set(land6_3.position.x/PTM_RATIO, land6_3.position.y/PTM_RATIO);
    bodyDef.userData = land6_3;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"pigrun-land17";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [land6_3 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
    
    
}




- (void)drawland14 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    
    land14 = [CCSprite spriteWithSpriteFrameName:@"pigrun-land14.png"];
    
    land14.position = CGPointMake(screenSize.width*14.5,screenSize.height*(-1.0));
    [self addChild:land14 z:10 tag:113];
    
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_staticBody;
    bodyDef.position.Set(land14.position.x/PTM_RATIO, land14.position.y/PTM_RATIO);
    bodyDef.userData = land14;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"pigrun-land14";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [land14 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
    
    
}



-(void)Gameovers{
    CGSize screenSize=[[CCDirector sharedDirector] winSize];
    
    CCSprite *gamesprite;
    CGPoint temppos=self.position;
    if (gametime>450) {
        game3level=3;
          [[SimpleAudioEngine sharedEngine]stopBackgroundMusic];
         [[SimpleAudioEngine sharedEngine]playEffect:@"start3.mp3" pitch:12.0 pan:5.0 gain:2.0];
        gamesprite=[CCSprite spriteWithSpriteFrameName:@"game-end4.png"];
        temppos.x=screenSize.width*0.5-temppos.x;
        temppos.y=screenSize.height*0.5-temppos.y;
        gamesprite.position=temppos;
        [self addChild:gamesprite z:50 tag:501];
      
    }else if (gametime>300){
        game3level=2;
          [[SimpleAudioEngine sharedEngine]stopBackgroundMusic];
         [[SimpleAudioEngine sharedEngine]playEffect:@"start2.mp3"];
        
        gamesprite=[CCSprite spriteWithSpriteFrameName:@"game-end3.png"];
        temppos.x=screenSize.width*0.5-temppos.x;
        temppos.y=screenSize.height*0.5-temppos.y;
        gamesprite.position=temppos;
        [self addChild:gamesprite z:50 tag:501];
        
    }else if(gametime>150){
        game3level=1;
          [[SimpleAudioEngine sharedEngine]stopBackgroundMusic];
        [[SimpleAudioEngine sharedEngine]playEffect:@"start1.mp3"];
        
        gamesprite=[CCSprite spriteWithSpriteFrameName:@"game-end2.png"];
        temppos.x=screenSize.width*0.5-temppos.x;
        temppos.y=screenSize.height*0.5-temppos.y;
        gamesprite.position=temppos;
        [self addChild:gamesprite z:50 tag:501];
        
        
    }else{
          [[SimpleAudioEngine sharedEngine]stopBackgroundMusic];
        gamesprite=[CCSprite spriteWithSpriteFrameName:@"game-end1.png"];
         [[SimpleAudioEngine sharedEngine]playEffect:@"start0.mp3"];
        temppos.x=screenSize.width*0.5-temppos.x;
        temppos.y=screenSize.height*0.5-temppos.y;
        gamesprite.position=temppos;
        //[gamesprite setPosition:ccp(screenSize.width*0.5,screenSize.height*0.5)];
        [self addChild:gamesprite z:50 tag:501];
    }
    
   
    
    CCMenuItemImage *menum2 = [CCMenuItemImage itemFromNormalImage:@"gaming-list2.png" selectedImage:@"gaming-list2-1.png" disabledImage:@"gaming-list2.png" target:self selector:@selector(gomenu2)];
    menu2 = [CCMenu menuWithItems: menum2, nil];
    menu2.position =  CGPointMake(screenSize.width*0.31, screenSize.height*0.48);
    [gamesprite addChild: menu2 z:55 tag:122];
    
    
    CCMenuItemImage *menum5 = [CCMenuItemImage itemFromNormalImage:@"gaming-list5.png" selectedImage:@"gaming-list5-1.png" disabledImage:@"gaming-list5.png" target:self selector:@selector(gomenu5)];
    menu5 = [CCMenu menuWithItems: menum5, nil];
    menu5.position =  CGPointMake(screenSize.width*0.39, screenSize.height*0.33);
    [gamesprite addChild: menu5 z:55 tag:125];
    
    CCMenuItemImage *menum7 = [CCMenuItemImage itemFromNormalImage:@"gaming-list7.png" selectedImage:@"gaming-list7-1.png" disabledImage:@"gaming-list7.png" target:self selector:@selector(gomenu7)];
    menu7 = [CCMenu menuWithItems: menum7, nil];
    menu7.position =  CGPointMake(screenSize.width*0.51, screenSize.height*0.26);
    [gamesprite addChild: menu7 z:55 tag:125];
    
    [self gampause];
    //[[CCDirector sharedDirector] pause];
    //CCTransitionFade *tranScene=[CCTransitionFade transitionWithDuration:1 scene:[GameOverScene scene]];
    //[[CCDirector sharedDirector] replaceScene:tranScene];
    
}


- (void)selectSpriteForTouch:(CGPoint)touchLocation
{
    
    if (CGRectContainsPoint(pig.boundingBox, touchLocation))
    {

       // [pig jump];

        
    }
    
    if (CGRectContainsPoint(game3treasure.boundingBox, touchLocation))
    {
        NSLog(@"faxianla1");
        game3thing=1;
        //[game1treasure removeFromParentAndCleanup:YES];
        // [self removeChild:game1treasure cleanup:YES];
        
    }

    
    
}



- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
     CGSize screenSize = [[CCDirector sharedDirector] winSize];
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    [self selectSpriteForTouch:touchLocation];
    if (self.position.x<screenSize.width*(-0.5))
    {
        if (pigjumping==0)
        {
             [pig jump];
        }
    }
    return TRUE;
}

-(void) runobsMoveSequencex:(CCSprite*)spider
{
    
	CGPoint belowScreenPosition = CGPointMake(spider.position.x-29,spider.position.y);
    //CCLOG(@" --- %d ---- %f -----", belowScreenPosition.x,belowScreenPosition.y);
	CCMoveTo* move = [CCMoveTo actionWithDuration:0.1f position:belowScreenPosition];
    
	CCSequence* sequence = [CCSequence actions:move,nil];
	[spider runAction:sequence];
    
    
    
}

-(void) runobsMoveSequencey:(CCSprite*)spider
{
    
	CGPoint belowScreenPosition = CGPointMake(spider.position.x,spider.position.y+10);
    
    

	CCMoveTo* move = [CCMoveTo actionWithDuration:0.1f position:belowScreenPosition];
    
	CCSequence* sequence = [CCSequence actions:move,nil];
	[spider runAction:sequence];
    
    
    
}
-(void) gampause{
    [[CCDirector sharedDirector] pause];
}

-(void) gomenu2
{
    [[CCDirector sharedDirector] resume];
    [[CCDirector sharedDirector] resume];
    CCScene* newScene = [LoadingScene sceneWithTargetScene:TargetScene3Scene];
    [[CCDirector sharedDirector] replaceScene:newScene];
    
}

-(void) gomenu5
{
    [[CCDirector sharedDirector] resume];
    [[CCDirector sharedDirector] resume];
    CCScene* newScene = [LoadingScene sceneWithTargetScene:TargetSceneHome];
    [[CCDirector sharedDirector] replaceScene:newScene];
    
}
-(void) gomenu7{
    [[CCDirector sharedDirector] resume];
    [[CCDirector sharedDirector] resume];
    CCScene* newScene = [LoadingScene sceneWithTargetScene:TargetScene4Scene];
    [[CCDirector sharedDirector] replaceScene:newScene];
    
}


-(void) dealloc
{
	CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
