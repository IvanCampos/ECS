import RealityKit

class LevelSystem: System {
    private static let query = EntityQuery(where: .has(LevelComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
                        if var level = entity.components[LevelComponent.self] {
                            if level.value < 1 { level.value = 1 }
                            entity.components.set(level)
                        }
        }
    }
}
