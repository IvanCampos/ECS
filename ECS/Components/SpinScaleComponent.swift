import RealityKit
import simd

struct SpinScaleComponent: Component {
    var axis: SIMD3<Float> = [0, 1, 0]
    var spinSpeed: Float = 0
    var scaleRate: Float = 0
}
