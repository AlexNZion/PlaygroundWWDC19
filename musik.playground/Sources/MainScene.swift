import Foundation
import SpriteKit
import AVFoundation

public class MainScene : SKScene {

    var balls:[MusicalBall] = []
    var currentBall:MusicalBall?
    var referenceBall:MusicalBall!
    let notes:[String] = ["b1","d2","e2","fs2","a2","b2","d3","e3","fs3"]

    // editable elements
    
    var xilofone:Xilofone!
    var bottom:CGFloat = 0
    
    var startButton:StartButton!
    var eraserButton:EraserButton!
    var changeWindowButton:SKShapeNode!
    var running:Bool!
    var clickedStart:Bool!
    var clickedEraser:Bool!
    var eraserModeOn:Bool!
    var snapIsOn:Bool!
    let snapRange:Float = 10
    var snaped:Bool = false
    
    var line1:SKShapeNode!
    var contactLineRef:CGFloat!
    let linesApartBy:CGFloat = 80 // has to be grater than the snapRange
    
    
    public override func didMove(to view: SKView) {
        referenceBall = MusicalBall()
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)

        running = true
        clickedStart = false
        clickedEraser = false
        eraserModeOn = false
        snapIsOn = true
        snaped = false
        
        xilofone = Xilofone(viewSize: size)
        bottom = xilofone.glowWidth + xilofone.h
        startButton = StartButton(viewSize: size)
        eraserButton = EraserButton(viewSize: size)
//
//        changeWindowButton = SKShapeNode(circleOfRadius: 20)
//        changeWindowButton.position = CGPoint(x: size.width/2, y: size.height - 60)
//        changeWindowButton.fillColor = .red

        // criar linhas
        contactLineRef = bottom + referenceBall.radius
        var points = [CGPoint(x: -10,               y: contactLineRef + linesApartBy),
                      CGPoint(x: size.width + 10,   y: contactLineRef + linesApartBy),
                      CGPoint(x: size.width + 10,   y: contactLineRef + 2*linesApartBy),
                      CGPoint(x: -10,               y: contactLineRef + 2*linesApartBy),
                      CGPoint(x: -10,               y: contactLineRef + 3*linesApartBy),
                      CGPoint(x: size.width + 10,   y: contactLineRef + 3*linesApartBy),
                      CGPoint(x: size.width + 10,   y: contactLineRef + 4*linesApartBy),
                      CGPoint(x: -10,               y: contactLineRef + 4*linesApartBy)]
        line1 = SKShapeNode(points: &points,
                            count: points.count)
        line1.strokeColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        line1.lineWidth = 2
        
        
        addChild(line1)
        addChild(xilofone)
        addChild(startButton)
        addChild(eraserButton)
        //addChild(changeWindowButton)
        
    }
    
    public override func update(_ currentTime: TimeInterval) {
        
        // make balls fall
        if(running)
        {
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
    }

    func touchDown(atPoint pos:CGPoint) {

        if(startButton.contains(pos))
        {
            clickedStart = true
        }
        else if (eraserButton.contains(pos))
        {
            clickedEraser = true
        }
        else if (eraserModeOn)
        {
            return
        }
        else
        {
            currentBall = MusicalBall()
            currentBall!.position = pos
            addChild(currentBall!)
        }
    }
    
    func touchMoved(toPoint pos:CGPoint){

        if(eraserModeOn)
        {
            var index:Int = 0
            for b in balls
            {
                if(b.contains(pos))
                {
                    balls.remove(at: index)
                    b.removeFromParent()
                    index -= 1
                }
                index += 1
            }
        }
        else if(currentBall != nil) {
            // snap to lines
            if(snapIsOn)
            {
                snaped = false
                for i in 1...4
                {
                    let distance = fabsf(Float(pos.y.distance(to: contactLineRef + CGFloat(i)*linesApartBy)))
                    if( distance < snapRange )
                    {
                        currentBall!.position.y = contactLineRef + CGFloat(i)*linesApartBy
                        currentBall!.position.x = pos.x
                        snaped = true
                    }
                    else if (!snaped)
                    {
                        currentBall!.position = pos
                    }
                }
            }
            else
            {
                currentBall!.position = pos
            }
        }
        
    }
    
    func touchEnded(atPoint pos:CGPoint){
        if(clickedStart && startButton.contains(pos))
        {
            running = !running
            startButton.buttonClicked()
        }
        else if(clickedEraser && eraserButton.contains(pos))
        {
            eraserModeOn = !eraserModeOn
            eraserButton.buttonClicked()
        }
        else
        {
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
                if(snaped)
                {
                    // already set
                }
                else if(pos.y < bottom + minOffset)
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
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchDown(atPoint: t.location(in: self))}
    }

    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchMoved(toPoint: t.location(in: self)) }
    }

    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchEnded(atPoint: t.location(in: self)) }
    }
    
    public override func didChangeSize(_ oldSize: CGSize) {
        repositionAll(oldSize)
    }
    
    private func repositionAll(_ oldSize:CGSize)
    {
        for c in children
        {
            reposition(obj: c, oldSize: oldSize)
        }
    }
    
    private func reposition(obj: SKNode, oldSize: CGSize)
    {
        let newX = size.width * obj.position.x / oldSize.width
        let newY = size.height * obj.position.y / oldSize.height
        
        obj.position = CGPoint(x: newX, y: newY)
    }
}
