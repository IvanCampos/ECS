import RealityKit

class DamageOverTimeSystem: System {
    private static let query = EntityQuery(where: .has(DamageOverTimeComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
                        if var dot = entity.components[DamageOverTimeComponent.self], var health = entity.components[HealthComponent.self] {
                            if dot.rate > 0 {
                                health.value -= dot.rate * Float(context.deltaTime)
                                entity.components.set(health)
                            }
                        }
        }
    }
}
