/*:
 # Hello WWDC19
 
 ## My name is Alex and this is my playgound
 
 
 
 
 A lot of people feel overwhelmed by the daunting task of learning an instrument and proceed to believe that composition is not for them. I think composing is supposed to be a fun and laid back experience and this is what I aimed for with this playground.
 
 
 *So run this code and let's begin...*
 */
import SpriteKit
import PlaygroundSupport

let frame = CGRect(x: 0, y: 0, width: 640, height: 480)
let view = SKView(frame: frame)
let scene = TutorialScene(size: frame.size)

view.presentScene(scene)
scene.scaleMode = .resizeFill


PlaygroundPage.current.liveView = view

/*:
 To your right is a music creation environment I call the ***Hyper-Neon Marimba*** (behold...). Try clicking somewhere over there.
 
 As you can see a ball will appear and when it hits the keys in the bottom a note will sound. The leftmost keys produce a lower **pitch** while the ones in the right produce a higher one.
 
 All of the notes are in the B pentatonic scale. If you don't know what it is, don't worry about it, it basically means that there are no "wrong notes", so go crazy 🙂
 
 Play with it a little bit and meet me in the next page to see a few more features.
 
 */
//: [Next](@next)
