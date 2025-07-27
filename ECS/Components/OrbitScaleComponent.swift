import RealityKit
import simd

struct OrbitScaleComponent: Component {
    var center: SIMD3<Float> = .zero
    var radius: Float = 0
    var speed: Float = 0
    var angle: Float = 0
    var amplitude: Float = 0
    var phase: Float = 0
}
