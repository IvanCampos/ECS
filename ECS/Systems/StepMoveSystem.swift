import RealityKit
import simd

class StepMoveSystem: System {
    private static let query = EntityQuery(where: .has(StepMoveComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var comp = entity.components[StepMoveComponent.self] {
                comp.timer += dt
                if comp.timer >= comp.interval {
                    comp.timer = 0
                    entity.position += comp.axis * comp.step
                }
                entity.components.set(comp)
            }
        }
    }
}
