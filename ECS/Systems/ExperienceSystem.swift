import RealityKit

class ExperienceSystem: System {
    private static let query = EntityQuery(where: .has(ExperienceComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
                        if var xp = entity.components[ExperienceComponent.self] {
                            if xp.points < 0 { xp.points = 0 }
                            entity.components.set(xp)
                        }
        }
    }
}
