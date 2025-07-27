import RealityKit
import simd
import Foundation

struct TeleportComponent: Component {
    var interval: TimeInterval = 1
    var timer: TimeInterval = 0
    var range: Float = 0.5
}
