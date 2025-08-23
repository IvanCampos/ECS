import RealityKit
import Foundation

struct CooldownComponent: Component {
    var time: TimeInterval = 1
    var timer: TimeInterval = 0
    var ready: Bool = true
}
