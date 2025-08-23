import RealityKit

class StatusEffectSystem: System {
    private static let query = EntityQuery(where: .has(StatusEffectComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
                        if var effect = entity.components[StatusEffectComponent.self] {
                            effect.timer += context.deltaTime
                            if effect.timer >= effect.duration {
                                entity.components.remove(StatusEffectComponent.self)
                            } else {
                                entity.components.set(effect)
                            }
                        }
        }
    }
}
