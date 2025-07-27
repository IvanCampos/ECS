import RealityKit
import simd

struct SeekComponent: Component {
    var target: SIMD3<Float> = .zero
    var speed: Float = 0
}
