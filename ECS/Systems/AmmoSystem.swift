import RealityKit

class AmmoSystem: System {
    private static let query = EntityQuery(where: .has(AmmoComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
                        if var ammo = entity.components[AmmoComponent.self] {
                            if ammo.count > ammo.capacity { ammo.count = ammo.capacity }
                            if ammo.count < 0 { ammo.count = 0 }
                            entity.components.set(ammo)
                        }
        }
    }
}
