import RealityKit
import simd

struct HoverComponent: Component {
    var height: Float = 0
    var amplitude: Float = 0
    var speed: Float = 0
    var phase: Float = 0
    var origin: SIMD3<Float> = .zero
}
