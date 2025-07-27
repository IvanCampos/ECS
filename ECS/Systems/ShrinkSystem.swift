import RealityKit

class ShrinkSystem: System {
    private static let query = EntityQuery(where: .has(ShrinkComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if let shrink = entity.components[ShrinkComponent.self] {
                let factor = max(0, 1 - shrink.rate * dt)
                entity.scale *= SIMD3<Float>(repeating: factor)
            }
        }
    }
}
