import RealityKit
import simd

struct BeelineComponent: Component {
    var direction: SIMD3<Float> = [0, 0, -1]
    var speed: Float = 0
}
