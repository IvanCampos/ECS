import RealityKit
import simd

class ScaleZSystem: System {
    private static let query = EntityQuery(where: .has(ScaleZComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if let comp = entity.components[ScaleZComponent.self] {
                let factor = 1 + comp.rate * dt
                entity.scale.z *= factor
            }
        }
    }
}
