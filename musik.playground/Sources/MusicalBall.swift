import Foundation
import SpriteKit
import AVFoundation

public class MusicalBall : SKNode {
    
    var note:String = ""
    var initHeight:CGFloat = 0
    var xPos:CGFloat = 0
    var noteIndex:Int = 0
    var vel:CGFloat = 4
    var player : AVAudioPlayer!
    let glowWidth:CGFloat = 4
    
    var shapeNode:SKShapeNode
    var radius:CGFloat = 16
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("A problem ocurred, there is no decoder needed")
    }
    
    init(nota:String, x:CGFloat, y:CGFloat) {
        self.shapeNode = SKShapeNode(circleOfRadius: radius)
        super.init()
        self.note = nota
        self.xPos = x
        self.initHeight = y
        shapeNode.strokeColor = #colorLiteral(red: 0.6181097031, green: 1, blue: 0.3378727436, alpha: 1)
        shapeNode.glowWidth = glowWidth
        self.position = CGPoint(x: x, y: y)

        
        self.addChild(shapeNode)
        
    }
    
    convenience public override init() {
        self.init(nota: "b2", x: 0, y: 0)
    }
    
    @objc public func playSound(note:String){
        let path = Bundle.main.path(forResource: note, ofType: "wav")!
        let url = URL(fileURLWithPath: path)
        do{
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        }catch{
            print("Problem with AVAudioplayer")
        }
    }
}
