import RealityKit
import simd

struct ColorRiseComponent: Component {
    var speed: Float = 0
    var colorA: SIMD3<Float> = [0, 0, 1]
    var colorB: SIMD3<Float> = [1, 0, 0]
    var height: Float = 1
}
