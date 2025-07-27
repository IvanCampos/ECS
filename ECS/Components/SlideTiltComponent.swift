import RealityKit
import simd

struct SlideTiltComponent: Component {
    var axis: SIMD3<Float> = [1, 0, 0]
    var speed: Float = 0
    var length: Float = 0
    var position: Float = 0
    var tiltAmplitude: Float = 0
    var forward: Bool = true
}
