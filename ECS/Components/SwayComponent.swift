import RealityKit
import simd

struct SwayComponent: Component {
    var amplitudeX: Float = 0
    var amplitudeZ: Float = 0
    var speed: Float = 0
    var phase: Float = 0
    var origin: SIMD3<Float> = .zero
}
