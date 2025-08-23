import RealityKit

class ScoreSystem: System {
    private static let query = EntityQuery(where: .has(ScoreComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
                        if var score = entity.components[ScoreComponent.self] {
                            if score.value < 0 { score.value = 0 }
                            entity.components.set(score)
                        }
        }
    }
}
