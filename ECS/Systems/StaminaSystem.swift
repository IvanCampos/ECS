import RealityKit

class StaminaSystem: System {
    private static let query = EntityQuery(where: .has(StaminaComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
                        if var stamina = entity.components[StaminaComponent.self] {
                            stamina.value += stamina.regen * Float(context.deltaTime)
                            if stamina.value > stamina.max { stamina.value = stamina.max }
                            entity.components.set(stamina)
                        }
        }
    }
}
