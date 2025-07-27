import RealityKit
import simd

struct BoomerangComponent: Component {
    var start: SIMD3<Float> = .zero
    var end: SIMD3<Float> = .zero
    var speed: Float = 0
    var forward: Bool = true
}
