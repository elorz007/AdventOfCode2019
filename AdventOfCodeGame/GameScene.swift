//
//  GameScene.swift
//  AdventOfCodeGame
//
//  Created by Mikel Elorz on 10.04.20.
//  Copyright © 2020 Mikel Elorz. All rights reserved.
//

import SpriteKit
import GameplayKit
import AdventOfCodeFramework

class GameScene: SKScene {
    let blockSize = 25
    let playgroundSize = 44
    var arcadeCabinet: ArcadeCabinet?
    var shapes = [Position: SKShapeNode]()
    var label = SKLabelNode()

    override func didMove(to view: SKView) {
        arcadeCabinet = Day13().arcadeCabinet()
        guard let arcadeCabinet = arcadeCabinet else {
            return
        }
        arcadeCabinet.insertCoin()

        let cameraNode = SKCameraNode()
        let center = blockSize * playgroundSize / 2
        cameraNode.position = CGPoint(x: center, y: center)
        addChild(cameraNode)
        camera = cameraNode

        for x in 0..<playgroundSize {
            for y in 0..<playgroundSize {
                let position = Position(x: x, y: y)
                shapes[position] = createShape(in: position)
            }
        }

        label.position = CGPoint(x: blockSize*2, y: -blockSize)
        addChild(label)

        arcadeCabinet.preInput = {
            Thread.sleep(forTimeInterval: 0.01)
        }
    }

    func start() {
        DispatchQueue.global().async { [weak self] in
            guard let arcadeCabinet = self?.arcadeCabinet  else { return }
            arcadeCabinet.run()
            while (arcadeCabinet.tiles.contains { $0.value.type == .Block }) {
                arcadeCabinet.run()
            }
        }
    }

    func touchDown(atPoint pos: CGPoint) {
//        camera?.position = pos
        print(pos)
    }

    func touchMoved(toPoint pos: CGPoint) {
//        camera?.position = pos
    }

    func touchUp(atPoint pos: CGPoint) {
//        camera?.position = pos
    }

    override func mouseDown(with event: NSEvent) {
        touchDown(atPoint: event.location(in: self))
    }

    override func mouseDragged(with event: NSEvent) {
        touchMoved(toPoint: event.location(in: self))
    }

    override func mouseUp(with event: NSEvent) {
        touchUp(atPoint: event.location(in: self))
    }

    override func keyDown(with event: NSEvent) {
        switch event.keyCode {
        case 123:
            arcadeCabinet?.joystick = .left
        case 124:
            arcadeCabinet?.joystick = .right
        case 49:
            start()
        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
        }
    }

    override func keyUp(with event: NSEvent) {
        arcadeCabinet?.joystick = .neutral
        print("keyUp: \(event.characters!) keyCode: \(event.keyCode)")
    }

    override func update(_ currentTime: TimeInterval) {
        arcadeCabinet?.tiles.forEach { (position, tile) in
            if let shape = shapes[position] {
                decorate(shape: shape, with: tile)
            } else if position == ArcadeTile.scorePosition {
                label.text = String(tile.score ?? 0)
            }
        }
    }

    func decorate(shape: SKShapeNode, with tile: ArcadeTile) {
        shape.strokeColor = .clear
        shape.alpha = 1
        switch tile.type {
        case .empty:
            shape.fillColor = .clear
        case .wall:
            shape.fillColor = .black
        case .block:
            shape.fillColor = .yellow
        case .paddle:
            shape.fillColor = .red
        case .ball:
            shape.fillColor = .blue
        }
    }

    func createShape(in position: Position) -> SKShapeNode {
        let shape = SKShapeNode(rect: CGRect(x: 0, y: 0, width: blockSize, height: blockSize))
        shape.fillColor = .clear
        shape.strokeColor = .clear
        shape.alpha = 0
        shape.position = CGPoint(x: position.x * blockSize, y: position.y*blockSize)
        addChild(shape)
        return shape
    }

}
