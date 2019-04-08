import Foundation
import SpriteKit

public class StartButton : SKNode {
    
    public var button:SKShapeNode!
    public var label:SKLabelNode!
    
    let w:CGFloat!
    let h:CGFloat!
    let cornerRadius:CGFloat = 4
    let offset:CGFloat = 20
    let glowWidth:CGFloat = 4
    
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("A problem ocurred, there is no decoder needed")
    }
    
    
    public init(viewSize:CGSize)
    {
        w = viewSize.width/7
        h = viewSize.height/14
        button = SKShapeNode(rectOf: CGSize(width: w, height: h), cornerRadius: cornerRadius)
        label = SKLabelNode(text: "Running")
        super.init()
        button.position = CGPoint(x: 0 + w/2 + offset, y: viewSize.height - h/2 - offset)
        label.fontName = "Helvetica"
        label.position = CGPoint(x: 0 + w/2 + offset, y: viewSize.height - h/2 - offset - 10)
        label.fontSize = 22
        

        button.glowWidth = glowWidth
        setStartColors()
        self.addChild(button)
        self.addChild(label)
    }
    
    public func buttonClicked()
    {
        if(label.text == "Running")
        {
            label.text = "Paused"
            label.fontColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            button.strokeColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        }
        else
        {
            label.text = "Running"
            setStartColors()
        }
    }
    
    public func setStartColors()
    {
        label.fontColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        button.strokeColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
    }
}

