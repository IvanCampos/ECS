import RealityKit

class GrowSystem: System {
    private static let query = EntityQuery(where: .has(GrowComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if let grow = entity.components[GrowComponent.self] {
                let factor = 1 + grow.rate * dt
                entity.scale *= SIMD3<Float>(repeating: factor)
            }
        }
    }
}
