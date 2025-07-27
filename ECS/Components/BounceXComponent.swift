import RealityKit

struct BounceXComponent: Component {
    var amplitude: Float = 0
    var speed: Float = 0
    var phase: Float = 0
    var origin: SIMD3<Float> = .zero
}
