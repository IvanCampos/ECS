import RealityKit
import simd

struct StepMoveComponent: Component {
    var axis: SIMD3<Float> = [1, 0, 0]
    var step: Float = 0
    var interval: Float = 1
    var timer: Float = 0
}
