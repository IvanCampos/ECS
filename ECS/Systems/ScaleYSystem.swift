import RealityKit
import simd

class ScaleYSystem: System {
    private static let query = EntityQuery(where: .has(ScaleYComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if let comp = entity.components[ScaleYComponent.self] {
                let factor = 1 + comp.rate * dt
                entity.scale.y *= factor
            }
        }
    }
}
