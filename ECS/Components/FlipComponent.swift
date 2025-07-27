import RealityKit
import simd

struct FlipComponent: Component {
    var axis: SIMD3<Float> = [1, 0, 0]
    var speed: Float = .pi
}
