import RealityKit
import simd

struct StretchComponent: Component {
    var axis: SIMD3<Float> = [1, 0, 0]
    var amplitude: Float = 0
    var speed: Float = 0
    var phase: Float = 0
}
