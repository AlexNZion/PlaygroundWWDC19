/*:
 [Previous](@previous)
 
 ## Going a little deeper
 ### with few more features
 
 As you've already seen, the **altitude** of the ball has no significance for the note created, it only determines how often it will sound.
 
 The **horizontal lines** have a little snap so you can place balls with the same altitude. Use de **Paused** mode by clicking the top left button to help you out (it's good to make chords). Being in "Running" mode and creating balls in the same line will make a more stable music, whereas creating balls in different altitudes can have a waky tempo to it, wich can also be fun.
 
 If you've made a mistake you can erase the balls by clicking the **"Erase"** button on the top right corner. Just remeber to turn it off if you want go back to creating balls.
 */

import SpriteKit
import PlaygroundSupport

let frame = CGRect(x: 0, y: 0, width: 640, height: 480)
let view = SKView(frame: frame)
let scene = MainScene(size: frame.size)

view.presentScene(scene)
scene.scaleMode = .resizeFill


PlaygroundPage.current.liveView = view
/*:
 
 Enjoy!
 
 */
