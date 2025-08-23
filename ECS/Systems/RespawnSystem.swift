import RealityKit

class RespawnSystem: System {
    private static let query = EntityQuery(where: .has(RespawnComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
                        if var respawn = entity.components[RespawnComponent.self] {
                            if !entity.isEnabled {
                                respawn.timer += context.deltaTime
                                if respawn.timer >= respawn.time {
                                    respawn.timer = 0
                                    entity.isEnabled = true
                                }
                                entity.components.set(respawn)
                            }
                        }
        }
    }
}
