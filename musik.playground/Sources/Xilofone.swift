import Foundation
import SpriteKit

public class Xilofone : SKNode {
    
    public var keys:[SKShapeNode]! = []
    
    var w:CGFloat!
    var h:CGFloat!
    let n:Int = 9
    let cornerRadius:CGFloat = 4
    let glowWidth:CGFloat = 4
    
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("A problem ocurred, there is no decoder needed")
    }

    public init(viewSize:CGSize)
    {
        w = viewSize.width/9
        h = viewSize.height/20
        super.init()
        for eachKey in 0...n-1
        {
            let i = CGFloat(eachKey)
            keys.append(SKShapeNode(rect: CGRect(x: i * w, y: glowWidth, width: w - glowWidth, height: h), cornerRadius: cornerRadius))
            keys[eachKey].strokeColor = UIColor.init(red: i/9, green: 0, blue: 1-i/9, alpha: 1)
            keys[eachKey].glowWidth = glowWidth
            keys[eachKey].lineWidth = 2
            self.addChild(keys[eachKey])
        }
    }
    
    public func redraw(viewSize:CGSize,scale:CGFloat)
    {
        w = viewSize.width/9
        h = viewSize.height/20
        for eachKey in 0...n-1
        {
            let i = CGFloat(eachKey)
            keys[eachKey].position = CGPoint(x: i * w, y: glowWidth)
            keys[eachKey].setScale(scale)
            keys.append(SKShapeNode(rect: CGRect(x: i * w, y: glowWidth, width: w - glowWidth, height: h), cornerRadius: cornerRadius))
            self.addChild(keys[eachKey])
        }
    }
}
