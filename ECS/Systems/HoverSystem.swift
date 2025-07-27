import RealityKit
import simd

class HoverSystem: System {
    private static let query = EntityQuery(where: .has(HoverComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var hover = entity.components[HoverComponent.self] {
                hover.phase += hover.speed * dt
                let offset = hover.height + sin(hover.phase) * hover.amplitude
                entity.position = hover.origin + [0, offset, 0]
                entity.components.set(hover)
            }
        }
    }
}
