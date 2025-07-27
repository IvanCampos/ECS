import RealityKit
import simd

struct OrbitComponent: Component {
    var center: SIMD3<Float> = .zero
    var axis: SIMD3<Float> = [0, 1, 0]
    var speed: Float = 0
}
