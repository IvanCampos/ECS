import RealityKit

struct OrbitXComponent: Component {
    var center: SIMD3<Float> = .zero
    var radius: Float = 0
    var speed: Float = 0
    var angle: Float = 0
}
