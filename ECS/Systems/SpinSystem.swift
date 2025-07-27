import RealityKit
import simd

class SpinSystem: System {
    private static let query = EntityQuery(where: .has(SpinComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if let spin = entity.components[SpinComponent.self] {
                let q = simd_quatf(angle: spin.speed * dt, axis: spin.axis)
                entity.orientation = simd_normalize(q * entity.orientation)
            }
        }
    }
}
