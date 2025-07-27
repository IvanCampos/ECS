import RealityKit
import Foundation

struct BlinkComponent: Component {
    var interval: TimeInterval = 1
    var timer: TimeInterval = 0
    var visible: Bool = true
}
