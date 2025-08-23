import RealityKit

class WeaponSystem: System {
    private static let query = EntityQuery(where: .has(WeaponComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
                        if var weapon = entity.components[WeaponComponent.self] {
                            weapon.isFiring = false
                            entity.components.set(weapon)
                        }
        }
    }
}
