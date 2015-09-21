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
typealias BallNode = SKSpriteNode

let verticalPaddleSize = CGSizeMake(10, 100)
let horizontalPaddleSize = CGSizeMake(verticalPaddleSize.height, verticalPaddleSize.width)

enum Orientation {
    case horizontal
    case vertical
}

let ballRadius = CGFloat( 10 )


class GameScene: SKScene {
    var players = 1
    
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
        
        self.startBall()
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
    }
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    //MARK: Setup Functions
    func createPaddleNodes() -> [PaddleNode] {
        let paddle1Position = CGPointMake(verticalPaddleSize.width / 2, self.size.height / 2)
        let paddle1 = self.paddleNode(UIColor.redColor(), position: paddle1Position, orientation: .vertical)
        
        let paddle2Position = CGPointMake(self.size.width - verticalPaddleSize.width / 2, self.size.height / 2)
        let paddle2 = self.paddleNode(UIColor.greenColor(), position: paddle2Position, orientation: .vertical)
        
        let paddle3Position = CGPointMake(self.size.width / 2, horizontalPaddleSize.height / 2)
        let paddle3 = self.paddleNode(UIColor.yellowColor(), position: paddle3Position, orientation: .horizontal)
        
        let paddle4Position = CGPointMake(self.size.width / 2, self.size.height - horizontalPaddleSize.height / 2)
        let paddle4 = self.paddleNode(UIColor.blueColor(), position: paddle4Position, orientation: .horizontal)
        
        return [paddle1, paddle2, paddle3, paddle4]
    }
    
    func paddleNode( color: UIColor, position: CGPoint, orientation: Orientation) -> PaddleNode {
        let size: CGSize
        switch orientation {
        case .horizontal:
            size = horizontalPaddleSize
        case .vertical:
            size = verticalPaddleSize
        }
        let paddleNode = PaddleNode(color: color, size: size)
        paddleNode.position = position
        paddleNode.physicsBody = SKPhysicsBody(rectangleOfSize: paddleNode.size)
        paddleNode.physicsBody?.dynamic = false
        paddleNode.physicsBody?.restitution = 1.0
        return paddleNode
    }
    
    func createWallNodes() -> [WallNode] {
        let horizontalWallSize = CGSizeMake(self.size.width, horizontalPaddleSize.height)
        let verticalWallSize = CGSizeMake(verticalPaddleSize.width, self.size.height)
        
        let wall1Position = CGPointMake(verticalWallSize.width / 2, self.size.height / 2)
        let wall1 = self.wallNode(wall1Position, size: verticalWallSize)
        
        let wall2Position = CGPointMake(self.size.width - verticalWallSize.width / 2, self.size.height / 2)
        let wall2 = self.wallNode(wall2Position, size: verticalWallSize)
        
        let wall3Position = CGPointMake(self.size.width / 2, horizontalWallSize.height / 2)
        let wall3 = self.wallNode(wall3Position, size: horizontalWallSize)

        let wall4Position = CGPointMake(self.size.width / 2, self.size.height - horizontalWallSize.height / 2)
        let wall4 = self.wallNode(wall4Position, size: horizontalWallSize)

        return [wall1, wall2, wall3, wall4]
    }
    
    func wallNode( position: CGPoint, size: CGSize ) -> WallNode {
        let wallNode = WallNode(color: UIColor.whiteColor(), size: size)
        wallNode.position = position
        wallNode.size = size
        wallNode.physicsBody = SKPhysicsBody(rectangleOfSize: wallNode.size)
        wallNode.physicsBody?.dynamic = false
        wallNode.physicsBody?.restitution = 1.0
        return wallNode
    }
    
    func startBall() {
        if let paddleNodes = self.paddleNodes {
            if  paddleNodes.count > 0 {
                let paddleNode = paddleNodes[0]
                let ballNode = BallNode()
                ballNode.size = CGSizeMake(ballRadius * 2.0, ballRadius * 2.0)
                ballNode.color = UIColor.purpleColor()
                ballNode.physicsBody = SKPhysicsBody(circleOfRadius: ballRadius)
                ballNode.position = CGPointMake(paddleNode.position.x + 20, paddleNode.position.y)
                ballNode.physicsBody?.velocity = CGVectorMake(500, 500)
                ballNode.physicsBody?.friction = 0.0
                ballNode.physicsBody?.restitution = 1.0
                ballNode.physicsBody?.linearDamping = 0.0
                self.addChild( ballNode )
            }
        }
    }
}
