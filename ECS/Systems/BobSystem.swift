import RealityKit

class BobSystem: System {
    private static let query = EntityQuery(where: .has(BobComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var bob = entity.components[BobComponent.self] {
                bob.phase += bob.speed * dt
                entity.position.y = sin(bob.phase) * bob.amplitude
                entity.components.set(bob)
            }
        }
    }
}
