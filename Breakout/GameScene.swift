//
//  GameScene.swift
//  Breakout
//
//  Created by Sean McMains on 9/16/15.
//  Copyright (c) 2015 McMains. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var players = 2
    
    let controllerManager = GameControllerManager()
    
    var paddleNodes: [PaddleNode] = []
    var wallNodes: [WallNode] = []
    var ballNodes: [BallNode] = []
    
    override func didMove(to view: SKView) {
        self.paddleNodes = PaddleNodeFactory.paddleNodes( playfieldSize: self.size )
        self.wallNodes = WallNodeFactory.wallNodes( playfieldSize: self.size )
        self.ballNodes = [BallNodeFactory.startingBall( playfieldSize: self.size )]
        self.setupPhysicsWorld()
        
        self.addNodesToScene()
    }
    
    func setupPhysicsWorld() {
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
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
    
    
    
    override func update(_ currentTime: CFTimeInterval) {
        for index in 0..<players {
            let paddleNode = paddleNodes[index]
            switch paddleNode.orientation {
            case .horizontal:
                paddleNode.position.x += CGFloat( self.controllerManager.controllerXY(player: index).x )
            case .vertical:
                paddleNode.position.y += CGFloat( self.controllerManager.controllerXY(player: index).y )
            }
        }
        
        if ( self.controllerManager.buttonPressed( player: 0 ) ) {
            let newBallNode = BallNodeFactory.startingBall( playfieldSize: self.size )
            self.ballNodes.append( newBallNode )
            self.addChild( newBallNode )
        }
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        let ( node1, node2 ) = nodesFromContactOrderedByCategory( contact: contact )
        if let paddleNode = node1 as? PaddleNode, let ballNode = node2 as? BallNode {
            ballNode.fillColor = paddleNode.color
        }
    }
    
    func nodesFromContactOrderedByCategory( contact: SKPhysicsContact ) -> ( SKNode, SKNode ) {
        let firstBody: SKPhysicsBody;
        let secondBody: SKPhysicsBody;
        
        if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask)
        {
            firstBody = contact.bodyA;
            secondBody = contact.bodyB;
        }
        else
        {
            firstBody = contact.bodyB;
            secondBody = contact.bodyA;
        }
        
        return (firstBody.node!, secondBody.node!)
    }
}

