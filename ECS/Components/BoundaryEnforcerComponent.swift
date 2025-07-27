import RealityKit
import simd

struct BoundaryEnforcerComponent: Component {
    var minBounds: SIMD3<Float> = [-1, -1, -1]
    var maxBounds: SIMD3<Float> = [1, 1, 1]
}
