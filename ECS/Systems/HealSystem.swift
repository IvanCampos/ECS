import RealityKit

class HealSystem: System {
    private static let query = EntityQuery(where: .has(HealComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
                        if var heal = entity.components[HealComponent.self], var health = entity.components[HealthComponent.self] {
                            if heal.amount > 0 {
                                health.value += heal.amount
                                heal.amount = 0
                                if health.value > health.max { health.value = health.max }
                                entity.components.set(health)
                                entity.components.set(heal)
                            }
                        }
        }
    }
}
