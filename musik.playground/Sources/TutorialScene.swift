import Foundation
import SpriteKit
import AVFoundation

public class TutorialScene : SKScene {
    
    var balls:[MusicalBall] = []
    var currentBall:MusicalBall?
    var referenceBall:MusicalBall!
    var sampler:AVAudioUnitSampler!
    let notes:[String] = ["b1","d2","e2","fs2","a2","b2","d3","e3","fs3"]
    
    // editable elements
    
    var xilofone:Xilofone!
    var bottom:CGFloat = 0
    
    
    public override func didMove(to view: SKView) {
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        xilofone = Xilofone(viewSize: size)
        bottom = xilofone.glowWidth + xilofone.h
        
        addChild(xilofone)
    }
    
    public override func update(_ currentTime: TimeInterval) {

        for b in balls {
            b.position.y -= b.vel
            if(b.position.y - b.radius < bottom)
            {
                // ball hit key
                b.position.y = bottom + b.radius
                b.vel *= -1
                b.playSound(note:b.note)
            }
            if(b.position.y > b.initHeight)
            {
                b.position.y = b.initHeight
                b.vel *= -1
            }
        }
    }
    
    func touchDown(atPoint pos:CGPoint) {
            currentBall = MusicalBall()
            currentBall!.position = pos
            addChild(currentBall!)
    }
    
    func touchMoved(toPoint pos:CGPoint){

        if(currentBall != nil) {
            currentBall!.position = pos
        }
    }
    
    func touchEnded(atPoint pos:CGPoint){
        if(currentBall != nil) // append and drop ball
        {
            var x:Double = Double(pos.x)
            let w:Double = Double(size.width)
            if(x > w - Double(currentBall!.radius))
            {
                x = w - Double(currentBall!.radius)
            }
            else if(x < Double(currentBall!.radius))
            {
                x = Double(currentBall!.radius)
            }
            let index:Int = Int(floor(x * Double(notes.count) / w))
            currentBall!.noteIndex = index
            let n:String = notes[index]
            currentBall!.note = n
            
            let minOffset:CGFloat = 23
            if(pos.y < bottom + minOffset)
            {
                currentBall!.position.x = CGFloat(x)
                currentBall!.position.y = bottom + currentBall!.radius + minOffset
            }
            else
            {
                currentBall!.position.x = CGFloat(x)
                currentBall!.position.y = pos.y
            }
            currentBall!.initHeight = currentBall!.position.y
            balls.append(currentBall!)
            currentBall = nil
        }
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchDown(atPoint: t.location(in: self)) }
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchMoved(toPoint: t.location(in: self)) }
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchEnded(atPoint: t.location(in: self)) }
    }
}
