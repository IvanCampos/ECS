import RealityKit
import Foundation

struct FireRateComponent: Component {
    var interval: TimeInterval = 1
    var timer: TimeInterval = 0
    var canFire: Bool = true
}
