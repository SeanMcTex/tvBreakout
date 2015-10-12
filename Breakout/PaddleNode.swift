//
//  PaddleNode.swift
//  Breakout
//
//  Created by Sean McMains on 9/20/15.
//  Copyright © 2015 McMains. All rights reserved.
//

import SpriteKit

typealias PaddleNode = SKSpriteNode

let verticalPaddleSize = CGSizeMake(10, 100)
let horizontalPaddleSize = CGSizeMake(verticalPaddleSize.height, verticalPaddleSize.width)

class PaddleNodeFactory {
    class func paddleNodes(playfieldSize playfieldSize: CGSize ) -> [PaddleNode] {
        let paddle1Position = CGPointMake(verticalPaddleSize.width / 2 + horizontalOverscanMargin, playfieldSize.height / 2)
        let paddle1 = self.paddleNode(SKColor.redColor(), position: paddle1Position, orientation: .vertical)
        
        let paddle2Position = CGPointMake(playfieldSize.width - verticalPaddleSize.width / 2 - horizontalOverscanMargin, playfieldSize.height / 2)
        let paddle2 = self.paddleNode(SKColor.greenColor(), position: paddle2Position, orientation: .vertical)
        
        let paddle3Position = CGPointMake(playfieldSize.width / 2, horizontalPaddleSize.height / 2 + verticalOverscanMargin)
        let paddle3 = self.paddleNode(SKColor.yellowColor(), position: paddle3Position, orientation: .horizontal)
        
        let paddle4Position = CGPointMake(playfieldSize.width / 2, playfieldSize.height - horizontalPaddleSize.height / 2 - verticalOverscanMargin)
        let paddle4 = self.paddleNode(SKColor.blueColor(), position: paddle4Position, orientation: .horizontal)
        
        return [paddle1, paddle2, paddle3, paddle4]
    }
    
    class func paddleNode( color: SKColor, position: CGPoint, orientation: Orientation) -> PaddleNode {
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
}
