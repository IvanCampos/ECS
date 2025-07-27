import RealityKit
import simd

struct SeekRotateComponent: Component {
    var target: SIMD3<Float> = .zero
    var moveSpeed: Float = 0
    var rotateSpeed: Float = 0
}
