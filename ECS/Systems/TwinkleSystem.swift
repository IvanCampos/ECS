import RealityKit

class TwinkleSystem: System {
    private static let query = EntityQuery(where: .has(TwinkleComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var comp = entity.components[TwinkleComponent.self] {
                comp.timer += context.deltaTime
                if comp.timer >= comp.interval {
                    comp.timer = 0
                    entity.isEnabled.toggle()
                }
                entity.components.set(comp)
            }
        }
    }
}
