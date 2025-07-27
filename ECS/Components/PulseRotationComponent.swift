import RealityKit
import simd

struct PulseRotationComponent: Component {
    var axis: SIMD3<Float> = [0, 1, 0]
    var amplitude: Float = 0
    var speed: Float = 0
    var phase: Float = 0
}
