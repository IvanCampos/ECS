import RealityKit

class EnemySpawnSystem: System {
    private static let query = EntityQuery(where: .has(EnemySpawnComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
                        if var spawn = entity.components[EnemySpawnComponent.self] {
                            spawn.timer += context.deltaTime
                            if spawn.timer >= spawn.interval {
                                spawn.timer = 0
                            }
                            entity.components.set(spawn)
                        }
        }
    }
}
