import RealityKit
import simd

struct DriftColorComponent: Component {
    var velocity: SIMD3<Float> = .zero
    var speed: Float = 0
    var phase: Float = 0
}
