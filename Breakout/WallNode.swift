//
//  WallNode.swift
//  Breakout
//
//  Created by Sean McMains on 9/20/15.
//  Copyright © 2015 McMains. All rights reserved.
//

import SpriteKit

typealias WallNode = SKSpriteNode

class WallNodeFactory {
    class func wallNodes(playfieldSize playfieldSize: CGSize ) -> [WallNode] {
        let horizontalWallSize = CGSizeMake(playfieldSize.width, 10)
        let verticalWallSize = CGSizeMake(10, playfieldSize.height)
        
        let wall1Position = CGPointMake(verticalWallSize.width / 2, playfieldSize.height / 2)
        let wall1 = self.wallNode(wall1Position, size: verticalWallSize)
        
        let wall2Position = CGPointMake(playfieldSize.width - verticalWallSize.width / 2, playfieldSize.height / 2)
        let wall2 = self.wallNode(wall2Position, size: verticalWallSize)
        
        let wall3Position = CGPointMake(playfieldSize.width / 2, horizontalWallSize.height / 2)
        let wall3 = self.wallNode(wall3Position, size: horizontalWallSize)
        
        let wall4Position = CGPointMake(playfieldSize.width / 2, playfieldSize.height - horizontalWallSize.height / 2)
        let wall4 = self.wallNode(wall4Position, size: horizontalWallSize)
        
        return [wall1, wall2, wall3, wall4]
    }
    
    class func wallNode( position: CGPoint, size: CGSize ) -> WallNode {
        let wallNode = WallNode(color: SKColor.whiteColor(), size: size)
        wallNode.position = position
        
        wallNode.physicsBody = SKPhysicsBody(rectangleOfSize: wallNode.size)
        wallNode.physicsBody?.dynamic = false
        wallNode.physicsBody?.restitution = 1.0
        
        return wallNode
    }

}

