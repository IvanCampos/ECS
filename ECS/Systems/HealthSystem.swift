import RealityKit

class HealthSystem: System {
    private static let query = EntityQuery(where: .has(HealthComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
                        if var health = entity.components[HealthComponent.self] {
                            health.value = min(max(health.value, 0), health.max)
                            if health.value <= 0 {
                                entity.isEnabled = false
                            }
                            entity.components.set(health)
                        }
        }
    }
}
