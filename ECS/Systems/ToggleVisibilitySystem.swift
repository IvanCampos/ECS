import RealityKit
import simd

class ToggleVisibilitySystem: System {
    private static let query = EntityQuery(where: .has(ToggleVisibilityComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var comp = entity.components[ToggleVisibilityComponent.self] {
                comp.timer += dt
                if comp.timer >= comp.interval {
                    comp.timer = 0
                    entity.isEnabled.toggle()
                }
                entity.components.set(comp)
            }
        }
    }
}
