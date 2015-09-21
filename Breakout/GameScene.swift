//
//  GameScene.swift
//  Breakout
//
//  Created by Sean McMains on 9/16/15.
//  Copyright (c) 2015 McMains. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var players = 1
    
    var paddleNodes: [PaddleNode] = []
    var wallNodes: [WallNode] = []
    var ballNodes: [BallNode] = []
    
    override func didMoveToView(view: SKView) {
        self.paddleNodes = PaddleNodeFactory.paddleNodes( playfieldSize: self.size )
        self.wallNodes = WallNodeFactory.wallNodes( playfieldSize: self.size )
        self.ballNodes = [BallNodeFactory.startingBall( playfieldSize: self.size )]
        self.setupPhysicsWorld()
        
        self.addNodesToScene()
    }
    
    func setupPhysicsWorld() {
        self.physicsWorld.gravity = CGVectorMake(0, 0)
    }
    
    func addNodesToScene() {
        for i in 0 ..< 4  {
            let currentPlayerActive = i < players
            if currentPlayerActive {
                self.addChild( paddleNodes[i] )
            } else {
                self.addChild( wallNodes[i] )
            }
        }
        
        for ballNode in self.ballNodes {
            self.addChild( ballNode )
        }
    

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
    }
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}

