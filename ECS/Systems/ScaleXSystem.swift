import RealityKit
import simd

class ScaleXSystem: System {
    private static let query = EntityQuery(where: .has(ScaleXComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if let comp = entity.components[ScaleXComponent.self] {
                let factor = 1 + comp.rate * dt
                entity.scale.x *= factor
            }
        }
    }
}
