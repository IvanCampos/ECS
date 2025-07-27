import RealityKit
import SwiftUI

struct HitHighlightComponent: Component {
    var color: Color = .yellow
    var duration: Float = 0.5
    var timer: Float = 0
    var originalColor: Color? = nil
}
