import RealityKit

class FireRateSystem: System {
    private static let query = EntityQuery(where: .has(FireRateComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
                        if var fire = entity.components[FireRateComponent.self] {
                            if !fire.canFire {
                                fire.timer += context.deltaTime
                                if fire.timer >= fire.interval {
                                    fire.timer = 0
                                    fire.canFire = true
                                }
                            }
                            entity.components.set(fire)
                        }
        }
    }
}
