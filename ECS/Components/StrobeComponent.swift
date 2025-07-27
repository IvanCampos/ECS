import RealityKit
import SwiftUI

struct StrobeComponent: Component {
    var interval: TimeInterval = 0
    var timer: TimeInterval = 0
    var colorA: Color = .white
    var colorB: Color = .black
    var useA: Bool = true
}
