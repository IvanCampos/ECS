import RealityKit
import simd

struct DriftRotateComponent: Component {
    var velocity: SIMD3<Float> = .zero
    var rotationSpeed: Float = 0
}
