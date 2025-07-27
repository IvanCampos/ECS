import RealityKit

class ScaleSystem: System {
    private static let query = EntityQuery(where: .has(ScaleComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var scale = entity.components[ScaleComponent.self] {
                let factor = 1 + scale.rate * dt
                entity.scale *= SIMD3<Float>(repeating: factor)
            }
        }
    }
}
