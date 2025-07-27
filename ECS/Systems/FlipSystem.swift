import RealityKit
import simd

class FlipSystem: System {
    private static let query = EntityQuery(where: .has(FlipComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if let flip = entity.components[FlipComponent.self] {
                let q = simd_quatf(angle: flip.speed * dt, axis: flip.axis)
                entity.orientation = simd_normalize(q * entity.orientation)
            }
        }
    }
}
