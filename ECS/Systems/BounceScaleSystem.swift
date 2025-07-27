import RealityKit

class BounceScaleSystem: System {
    private static let query = EntityQuery(where: .has(BounceScaleComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var comp = entity.components[BounceScaleComponent.self] {
                comp.phase += comp.speed * dt
                let scale = 1 + sin(comp.phase) * comp.amplitude
                entity.scale = [scale, scale, scale]
                entity.components.set(comp)
            }
        }
    }
}
