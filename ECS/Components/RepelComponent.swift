import RealityKit
import simd

struct RepelComponent: Component {
    var target: SIMD3<Float> = .zero
    var strength: Float = 0
    var velocity: SIMD3<Float> = .zero
}
