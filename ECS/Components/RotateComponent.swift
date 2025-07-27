import RealityKit
import simd

struct RotateComponent: Component {
    var axis: SIMD3<Float> = [0, 1, 0]
    var speed: Float = 0
}
