import RealityKit

class DamageSystem: System {
    private static let query = EntityQuery(where: .has(DamageComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
                        if var damage = entity.components[DamageComponent.self], var health = entity.components[HealthComponent.self] {
                            if damage.amount > 0 {
                                health.value -= damage.amount
                                damage.amount = 0
                                entity.components.set(health)
                                entity.components.set(damage)
                            }
                        }
        }
    }
}
