import RealityKit
import simd

struct GravityComponent: Component {
    var acceleration: SIMD3<Float> = [0, -9.8, 0]
    var velocity: SIMD3<Float> = .zero
}
