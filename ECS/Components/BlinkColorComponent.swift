import RealityKit
import simd

struct BlinkColorComponent: Component {
    var interval: Float = 1
    var timer: Float = 0
    var colorA: SIMD3<Float> = [1,1,1]
    var colorB: SIMD3<Float> = [0,0,0]
    var useA: Bool = true
}
