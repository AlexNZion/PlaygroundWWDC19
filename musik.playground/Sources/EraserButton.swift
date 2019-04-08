import Foundation
import SpriteKit

public class EraserButton : SKNode {
    
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
        w = viewSize.width/5
        h = viewSize.height/14
        button = SKShapeNode(rectOf: CGSize(width: w, height: h), cornerRadius: cornerRadius)
        label = SKLabelNode(text: "Eraser Off")
        super.init()
        button.position = CGPoint(x: viewSize.width - w/2 - offset, y: viewSize.height - h/2 - offset)
        label.fontName = "Helvetica"
        label.position = CGPoint(x: viewSize.width - w/2 - offset, y: viewSize.height - h/2 - offset - 10)
        label.fontSize = 24
        setOffColors()
        button.glowWidth = glowWidth
        
        self.addChild(button)
        self.addChild(label)
    }
    
    public func buttonClicked()
    {
        if(label.text == "Eraser Off")
        {
            label.text = "Eraser On"
            button.strokeColor = #colorLiteral(red: 1, green: 0.08394861966, blue: 0.06735794246, alpha: 1)
            label.fontColor = #colorLiteral(red: 0.8772130609, green: 0.07768962532, blue: 0.06856130809, alpha: 1)
        }
        else
        {
            label.text = "Eraser Off"
            setOffColors()
        }
    }
    
    public func setOffColors()
    {
        label.fontColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
        button.strokeColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
    }
    
}
