import RealityKit
import simd

class OrbitScaleSystem: System {
    private static let query = EntityQuery(where: .has(OrbitScaleComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var comp = entity.components[OrbitScaleComponent.self] {
                comp.angle += comp.speed * dt
                comp.phase += comp.speed * dt
                entity.position.x = comp.center.x + cos(comp.angle) * comp.radius
                entity.position.z = comp.center.z + sin(comp.angle) * comp.radius
                let scale = 1 + sin(comp.phase) * comp.amplitude
                entity.scale = [scale, scale, scale]
                entity.components.set(comp)
            }
        }
    }
}
