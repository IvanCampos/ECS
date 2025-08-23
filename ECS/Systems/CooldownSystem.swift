import RealityKit

class CooldownSystem: System {
    private static let query = EntityQuery(where: .has(CooldownComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
                        if var cd = entity.components[CooldownComponent.self] {
                            if !cd.ready {
                                cd.timer += context.deltaTime
                                if cd.timer >= cd.time {
                                    cd.timer = 0
                                    cd.ready = true
                                }
                            }
                            entity.components.set(cd)
                        }
        }
    }
}
