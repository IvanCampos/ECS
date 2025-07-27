import RealityKit
import simd

struct FadeColorComponent: Component {
    var colorA: SIMD3<Float> = [1, 1, 1]
    var colorB: SIMD3<Float> = [0, 0, 0]
    var speed: Float = 0
    var phase: Float = 0
}
