//
//  GameScene.swift
//  Breakout
//
//  Created by Sean McMains on 9/16/15.
//  Copyright (c) 2015 McMains. All rights reserved.
//

import SpriteKit

typealias PaddleNode = SKSpriteNode
typealias WallNode = SKSpriteNode

let verticalPaddleSize = CGSizeMake(10, 50)
let horizontalPaddleSize = CGSizeMake(verticalPaddleSize.height, verticalPaddleSize.width)


class GameScene: SKScene {
    var players = 2

    
    var paddleNodes: [PaddleNode]?
    var wallNodes: [WallNode]?
    
    override func didMoveToView(view: SKView) {
        self.paddleNodes = self.createPaddleNodes()
        self.wallNodes = self.createWallNodes()
        
        for i in 0 ..< 4  {
            let currentPlayerActive = i < players
            if currentPlayerActive {
                self.addChild( paddleNodes![i] )
            } else {
                self.addChild( wallNodes![i] )
            }
        }
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            let sprite = SKSpriteNode(imageNamed:"Spaceship")
            
            sprite.xScale = 0.5
            sprite.yScale = 0.5
            sprite.position = location
            
            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
            
            sprite.runAction(SKAction.repeatActionForever(action))
            
            self.addChild(sprite)
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    //MARK: Setup Functions
    func createPaddleNodes() -> [PaddleNode] {
        let paddle1 = PaddleNode(color: UIColor.redColor(), size: verticalPaddleSize)
        paddle1.position = CGPointMake(verticalPaddleSize.width / 2, self.size.height / 2)
        
        let paddle2 = PaddleNode(color: UIColor.greenColor(), size: verticalPaddleSize)
        paddle2.position = CGPointMake(self.size.width - verticalPaddleSize.width / 2, self.size.height / 2)
        
        let paddle3 = PaddleNode(color: UIColor.yellowColor(), size: horizontalPaddleSize)
        paddle3.position = CGPointMake(self.size.width / 2, horizontalPaddleSize.height / 2)
        
        let paddle4 = PaddleNode(color: UIColor.blueColor(), size: horizontalPaddleSize)
        paddle4.position = CGPointMake(self.size.width / 2, self.size.height - horizontalPaddleSize.height / 2)
     
        return [paddle1, paddle2, paddle3, paddle4]
    }
    
    func createWallNodes() -> [WallNode] {
        let horizontalWallSize = CGSizeMake(self.size.width, horizontalPaddleSize.height)
        let verticalWallSize = CGSizeMake(verticalPaddleSize.width, self.size.height)
        
        let wall1 = WallNode(color: UIColor.whiteColor(), size: verticalWallSize)
        wall1.position = CGPointMake(verticalWallSize.width / 2, self.size.height / 2)

        let wall2 = WallNode(color: UIColor.whiteColor(), size: verticalWallSize)
        wall2.position = CGPointMake(self.size.width - verticalWallSize.width / 2, self.size.height / 2)

        let wall3 = WallNode(color: UIColor.whiteColor(), size: horizontalWallSize)
        wall3.position = CGPointMake(self.size.width / 2, horizontalWallSize.height / 2)

        let wall4 = WallNode(color: UIColor.whiteColor(), size: horizontalWallSize)
        wall4.position = CGPointMake(self.size.width / 2, self.size.height - horizontalWallSize.height / 2)
        
        return [wall1, wall2, wall3, wall4]
}
}
